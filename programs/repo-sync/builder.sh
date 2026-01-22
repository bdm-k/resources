set -e
set -u

export PATH="$coreutils/bin:$gcc/bin"
mkdir -p $out/bin
g++ -o $out/bin/repo-sync $src
