let
  pkgs = import <nixpkgs> {};
in
derivation {
  name = "starship_agnocast_kmod_version";
  builder = "${pkgs.bash}/bin/bash";
  args = [ ./builder.sh ];
  inherit (pkgs) gcc coreutils;
  src = ./main.cpp;
  system = builtins.currentSystem;
}
