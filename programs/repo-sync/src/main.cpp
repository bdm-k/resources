#include <errno.h>
#include <stdio.h>
#include <termios.h>
#include <unistd.h>

#include <array>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <fstream>
#include <optional>
#include <string>
#include <unordered_map>
#include <vector>

const std::vector<uint8_t> & get_git_files()
{
  static std::vector<uint8_t> git_files;

  if (git_files.empty()) {
    FILE * pipe = popen("git ls-files -z", "r");
    if (!pipe) {
      fprintf(
        stderr, "error(%s): Failed to execute git ls-files: %s\n", __func__,
        strerror(errno));
      exit(EXIT_FAILURE);
    }

    git_files.reserve(4096);

    std::array<uint8_t, 4096> buffer;
    size_t bytes_read;
    while ((bytes_read = fread(buffer.data(), 1, 4096, pipe)) > 0) {
      for (size_t i = 0; i < bytes_read; ++i) {
        git_files.push_back(buffer[i]);
      }
    }

    if (ferror(pipe)) {
      fprintf(
        stderr, "error(%s): Error reading git ls-files output: %s\n", __func__,
        strerror(errno));
      exit(EXIT_FAILURE);
    }

    int exit_code = pclose(pipe);
    if (exit_code != 0) {
      fprintf(
        stderr, "error(%s): git ls-files returned non-zero exit code\n",
        __func__);
      exit(EXIT_FAILURE);
    }
  }

  return git_files;
}

void usage(char * argv0)
{
  fprintf(
    stderr,
    "Usage: %s [-y] [-f] [-r <remote>]\n"
    "\n"
    "Options:\n"
    "-y           Do not perform a dry run\n"
    "-f           Fetch update from the remote repository\n"
    "-r <remote>  Specify the remote directory (e.g., user@host:~/path/)\n"
    "             This only needs to be specified once per repository.\n"
    "             Specifying it again will update the cached remote.\n",
    argv0);
}

std::string build_data_path()
{
  std::string data_path;

  char * env_xdg_data_home = getenv("XDG_DATA_HOME");
  if (!env_xdg_data_home) {
    char * env_home = getenv("HOME");
    if (!env_home) exit(EXIT_FAILURE);

    std::string suffix = "/.local/share/repo-sync";
    data_path = env_home;
    data_path += suffix;
  } else {
    std::string suffix = "/repo-sync";
    data_path = env_xdg_data_home;
    data_path += suffix;
  }

  return data_path;
}

class RemoteCacheManager
{
  std::string data_path_;
  std::unordered_map<std::string, std::string> cache_;

  void write_back()
  {
    std::ofstream ofs(data_path_);
    if (!ofs.is_open()) {
      fprintf(
        stderr, "error(%s): Couldn't open data file: %s\n", __func__,
        strerror(errno));
      exit(EXIT_FAILURE);
    }

    for (const auto & pair : cache_) {
      ofs << pair.first << "\n";
      ofs << pair.second << "\n";
    }

    ofs.close();
  }

public:
  RemoteCacheManager() : data_path_(build_data_path())
  {
    std::ifstream ifs(data_path_);
    if (!ifs.is_open()) {
      // Create the file and return.
      std::ofstream ofs(data_path_);
      if (!ofs.is_open()) {
        fprintf(
          stderr, "error(%s): Couldn't create data file: %s\n", __func__,
          strerror(errno));
        exit(EXIT_FAILURE);
      }
      ofs.close();

      return;
    }

    std::string line;
    std::string repo_path;
    bool expect_remote = false;

    while (std::getline(ifs, line)) {
      if (line.empty()) continue;

      if (!expect_remote) {
        repo_path = line;
        expect_remote = true;
      } else {
        cache_[repo_path] = line;
        expect_remote = false;
      }
    }
  }

  ~RemoteCacheManager() { write_back(); }

  std::optional<std::string> get_remote(const std::string & repo_path)
  {
    auto it = cache_.find(repo_path);
    if (it == cache_.end()) {
      return std::nullopt;
    }
    return it->second;
  }

  [[nodiscard]]
  bool set_remote(const std::string & repo_path, const std::string & remote)
  {
    if (remote.back() != '/') {
      return false;
    }

    cache_[repo_path] = remote;
    return true;
  }
};

// false for no, true for yes
bool wait_yes_no()
{
  termios old_termios, new_termios;

  if (tcgetattr(STDIN_FILENO, &old_termios) != 0) {
    fprintf(
      stderr, "error(%s): tcgetattr failed: %s\n", __func__, strerror(errno));
    exit(EXIT_FAILURE);
  }

  new_termios = old_termios;
  new_termios.c_lflag &= ~(ECHO | ICANON);

  if (tcsetattr(STDIN_FILENO, TCSANOW, &new_termios) != 0) {
    fprintf(
      stderr, "error(%s): tcsetattr failed: %s\n", __func__, strerror(errno));
    exit(EXIT_FAILURE);
  }

  bool ret;

  while (true) {
    char ch = getchar();
    if (ch == '\n' || ch == 'y' || ch == 'Y') {
      ret = true;
      break;
    } else if (ch == 'n' || ch == 'N') {
      ret = false;
      break;
    }
  }

  if (tcsetattr(STDIN_FILENO, TCSANOW, &old_termios) != 0) {
    fprintf(
      stderr, "error(%s): tcsetattr failed: %s\n", __func__, strerror(errno));
    exit(EXIT_FAILURE);
  }

  return ret;
}

void dry_run(bool fetch, const std::string & remote)
{
  const std::vector<uint8_t> & git_files = get_git_files();

  char * command;

  if (fetch) {
    asprintf(
      &command,
      "rsync -rltvz --dry-run --itemize-changes --files-from=- --from0 %s ./",
      remote.c_str());
  } else {
    asprintf(
      &command,
      "rsync -rltvz --dry-run --itemize-changes --files-from=- --from0 ./ %s",
      remote.c_str());
  }

  FILE * pipe = popen(command, "w");
  if (!pipe) {
    fprintf(
      stderr, "error(%s): Failed to execute rsync command: %s\n", __func__,
      strerror(errno));
    exit(EXIT_FAILURE);
  }

  if (fwrite(git_files.data(), 1, git_files.size(), pipe) != git_files.size()) {
    fprintf(
      stderr, "error(%s): Error writing to pipe: %s\n", __func__,
      strerror(errno));
    exit(EXIT_FAILURE);
  }

  int exit_code = pclose(pipe);
  if (exit_code == -1) {
    fprintf(
      stderr, "error(%s): Failed to execute rsync command: %s\n", __func__,
      strerror(errno));
    exit(EXIT_FAILURE);
  }
  if (exit_code != 0) {
    fprintf(
      stderr, "error(%s): rsync command returned a non-zero exit code.\n",
      __func__);
    exit(EXIT_FAILURE);
  }

  printf("\n(repo-sync): Would you like to perform the rsync operation? [Y/n]");
  fflush(stdout);

  bool proceed = wait_yes_no();
  if (!proceed) {
    printf("\n(repo-sync): Cancelled.\n");
    exit(EXIT_SUCCESS);
  }
  printf("\n\n");

  free(command);
}

void run(bool fetch, const std::string & remote)
{
  const std::vector<uint8_t> & git_files = get_git_files();

  char * command;

  if (fetch) {
    asprintf(
      &command, "rsync -rltvz --itemize-changes --files-from=- --from0 %s ./",
      remote.c_str());
  } else {
    asprintf(
      &command, "rsync -rltvz --itemize-changes --files-from=- --from0 ./ %s",
      remote.c_str());
  }

  FILE * pipe = popen(command, "w");
  if (!pipe) {
    fprintf(
      stderr, "error(%s): Failed to execute rsync command: %s\n", __func__,
      strerror(errno));
    exit(EXIT_FAILURE);
  }

  if (fwrite(git_files.data(), 1, git_files.size(), pipe) != git_files.size()) {
    fprintf(
      stderr, "error(%s): Error writing to pipe: %s\n", __func__,
      strerror(errno));
    exit(EXIT_FAILURE);
  }

  int exit_code = pclose(pipe);
  if (exit_code == -1) {
    fprintf(
      stderr, "error(%s): Failed to execute rsync command: %s\n", __func__,
      strerror(errno));
    exit(EXIT_FAILURE);
  }
  if (exit_code != 0) {
    fprintf(
      stderr, "error(%s): rsync command returned a non-zero exit code.\n",
      __func__);
    exit(EXIT_FAILURE);
  }

  free(command);
}

int main(int argc, char * argv[])
{
  bool yes = false;
  bool fetch = false;
  std::string remote;

  int opt;
  while ((opt = getopt(argc, argv, "yfr:")) != -1) {
    switch (opt) {
      case 'y':
        yes = true;
        break;
      case 'f':
        fetch = true;
        break;
      case 'r':
        remote = optarg;
        break;
      default: // '?'
        usage(argv[0]);
        return 1;
    }
  }

  std::string cwd;
  try {
    cwd = std::filesystem::current_path().string();
  } catch (const std::filesystem::filesystem_error & ex) {
    fprintf(stderr, "error: Failed to get cwd: %s\n", ex.what());
    return 1;
  }
  if (!std::filesystem::is_directory(cwd + "/.git")) {
    fprintf(
      stderr,
      "error: repo-sync must be run from the root directory of a Git "
      "repository\n");
    return 1;
  }

  RemoteCacheManager manager;

  if (!remote.empty()) {
    if (!manager.set_remote(cwd, remote)) {
      fprintf(stderr, "error: <remote> should end with a slash\n");
      return 1;
    }
  } else {
    std::optional<std::string> remote_opt = manager.get_remote(cwd);
    if (!remote_opt.has_value()) {
      usage(argv[0]);
      return 1;
    }
    remote = remote_opt.value();
  }

  if (!yes) {
    dry_run(fetch, remote);
  }

  run(fetch, remote);

  return 0;
}
