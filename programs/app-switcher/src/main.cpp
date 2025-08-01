#include <cerrno>
#include <cstdlib>
#include <cstring>
#include <cstdarg>
#include <cstdio>
#include <cctype>
#include <fcntl.h>
#include <unistd.h>

#include <string>
#include <vector>
#include <algorithm>

constexpr char AEROSPACE_BIN[] = "/opt/homebrew/bin/aerospace";
constexpr char OPEN_BIN[] = "/usr/bin/open";

struct window {
  int id;
  char * app;
};

void setup_logging();
std::vector<struct window> run_and_parse(const char * command);
struct window & next_window(std::vector<struct window> & ws, int id);

int main(int argc, char * argv[])
{
  setup_logging();

  if (argc != 2) {
    fprintf(stderr, "[app-switcher] [ERROR] No argument specified\n");
    exit(EXIT_FAILURE);
  }

  char * app_to_focus = argv[1];
  char * command;

  asprintf(&command, "%s list-windows --focused", AEROSPACE_BIN);
  struct window curr_window = run_and_parse(command)[0];

  if (strcmp(curr_window.app, app_to_focus) != 0) {
    if (execl(OPEN_BIN, "open", "-a", app_to_focus, nullptr) == -1) {
      fprintf(stderr, "[app-switcher] [ERROR] execl failed: %s\n", strerror(errno));
      exit(EXIT_FAILURE);
    };
  }

  asprintf(&command, "%s list-windows --all", AEROSPACE_BIN);
  std::vector<struct window> target_app_ws;
  for (auto && w : run_and_parse(command)) {
    target_app_ws.push_back(std::move(w));
  }

  std::sort(target_app_ws.begin(), target_app_ws.end(),
      [](struct window & a, struct window & b) {
        return a.id < b.id;
      });

  struct window & window_to_focus = next_window(target_app_ws, curr_window.id);
  if (execl(AEROSPACE_BIN, "aerospace", "focus", "--window-id",
            std::to_string(window_to_focus.id).c_str(), nullptr) == -1) {
    fprintf(stderr, "[app-switcher] [ERROR] execl failed: %s\n", strerror(errno));
    exit(EXIT_FAILURE);
  }

  return 0;
}

void trim_end(char * s)
{
  size_t len = strlen(s);
  if (len == 0) return;
  char * p = &s[len - 1];
  while (p >= s && isspace(*p)) p -= 1;
  *(p + 1) = '\0';
}

struct window parse_line(const char * line)
{
  struct window w;
  w.app = static_cast<char *>(malloc(strlen(line)));
  if (sscanf(line, "%i | %[^|]", &w.id, w.app) != 2) {
    fprintf(stderr, "[app-switcher] [INFO] Invalid line format: \"%s\". Ignoring the line\n", line);
    return window{0, nullptr};
  }
  trim_end(w.app);
  return w;
}

std::vector<struct window> parse(FILE * input)
{
  static size_t line_capacity = 128;
  static char * line = static_cast<char *>(malloc(line_capacity));

  std::vector<struct window> ws;

  while (1) {
    off_t offset = 0;
    while (1) {
      memset(line + offset, 0, line_capacity - offset);

      if (!fgets(line + offset, line_capacity - offset, input)) return ws;

      bool read_entire_line = line[line_capacity - 2] == '\0' || line[line_capacity - 2] == '\n';
      if (read_entire_line) break;

      line_capacity *= 2;
      line = static_cast<char *>(realloc(line, line_capacity));
      offset = line_capacity / 2 - 1;
    }

    auto && w = parse_line(line);
    if (w.app) {
      ws.push_back(std::move(w));
    }
  }
}

std::vector<struct window> run_and_parse(const char * command)
{
  FILE * fp = popen(command, "r");
  if (!fp) {
    fprintf(stderr, "[app-switcher] [ERROR] popen failed: %s\n", strerror(errno));
    exit(EXIT_FAILURE);
  }
  std::vector<struct window> ret = parse(fp);
  fclose(fp);
  return ret;
}

struct window & next_window(std::vector<struct window> & ws, int id)
{
  for (int i = 0; i < ws.size() - 1; ++i) {
    if (ws[i].id == id) {
      return ws[i + 1];
    }
  }
  return ws[0];
}

char * build_log_path()
{
  char * log_path;

  char * env_xdg_cache_home = getenv("XDG_CACHE_HOME");
  if (!env_xdg_cache_home) {
    char * env_home = getenv("HOME");
    if (!env_home) exit(EXIT_FAILURE);

    constexpr char suffix[] = "/.cache/app-switcher.log";
    log_path = static_cast<char *>(malloc(strlen(env_home) + sizeof(suffix)));
    strcpy(log_path, env_home);
    strcat(log_path, suffix);
  } else {
    constexpr char suffix[] = "/app-switcher.log";
    log_path = static_cast<char *>(malloc(strlen(env_xdg_cache_home) + sizeof(suffix)));
    strcpy(log_path, env_xdg_cache_home);
    strcat(log_path, suffix);
  }

  return log_path;
}

void setup_logging()
{
  char * log_path = build_log_path();

  int fd = open(log_path, O_WRONLY | O_CREAT | O_APPEND, 0644);
  if (fd == -1) exit(EXIT_FAILURE);

  if (dup2(fd, STDOUT_FILENO) == -1) exit(EXIT_FAILURE);
  if (dup2(fd, STDERR_FILENO) == -1) exit(EXIT_FAILURE);

  close(fd);
}
