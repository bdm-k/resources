{ pkgs }:

derivation {
  name = "safe-rm";
  builder = "${pkgs.bash}/bin/bash";
  args = [ ./builder.sh ];
  inherit (pkgs) coreutils;
  src = pkgs.fetchFromGitHub {
    owner = "kaelzhang";
    repo = "shell-safe-rm";
    rev = "3.1.2";
    sha256 = "sha256-SqdCA9GOCC4dNb52eFU+CtmO3B8CQXPJOUadUcRiYeA=";
  };
  system = builtins.currentSystem;
}
