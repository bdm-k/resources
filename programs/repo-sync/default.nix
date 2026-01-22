{ pkgs }:

derivation {
  name = "repo-sync";
  builder = "${pkgs.bash}/bin/bash";
  args = [ ./builder.sh ];
  inherit (pkgs) gcc coreutils;
  src = ./src/main.cpp;
  system = builtins.currentSystem;
}
