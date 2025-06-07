#include <fcntl.h>      // open
#include <unistd.h>     // close
#include <sys/ioctl.h>  // ioctl
#include <cstring>      // strstr
#include <iostream>

#define AGNOCAST_GET_VERSION_CMD _IOR(0xA6, 1, struct ioctl_get_version_args)

#define VERSION_BUFFER_LEN 32  // Maximum size of version number represented as a string

struct ioctl_get_version_args
{
  char ret_version[VERSION_BUFFER_LEN];
};

__attribute__((noreturn))
void when()
{
  const char * pwd = std::getenv("PWD");
  if (pwd == nullptr) {
    exit(EXIT_FAILURE);
  }

  if (std::strstr(pwd, "agnocast") != nullptr) {
    exit(EXIT_SUCCESS);
  }

  if (std::strstr(pwd, "autoware") != nullptr) {
    exit(EXIT_SUCCESS);
  }

  exit(EXIT_FAILURE);
}

int main(int argc, char * argv[])
{
  if (argc == 2) when();

  int agnocast_fd = open("/dev/agnocast", O_RDONLY);
  if (agnocast_fd < 0) {
    std::cout << "kmod not loaded\n";
    return 0;
  }

  struct ioctl_get_version_args get_version_args = {};
  if (ioctl(agnocast_fd, AGNOCAST_GET_VERSION_CMD, &get_version_args) < 0) {
    std::cout << "kmod ?.?.?\n";
    close(agnocast_fd);
    return 0;
  }

  std::cout << "kmod " << get_version_args.ret_version << std::endl;
  close(agnocast_fd);
  return 0;
}
