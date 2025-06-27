set -e
set -u

export PATH="$coreutils/bin"
mkdir -p $out/bin
cp $src/bin/rm.sh $out/bin/safe-rm
chmod +x $out/bin/safe-rm
