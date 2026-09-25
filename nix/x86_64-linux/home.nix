{ config, pkgs, pkgs-stable, programs, ... }:
let
  username = import ./username.nix;
  resources = "/home/${username}/resources";
in
{
  imports = if builtins.pathExists ./desktop.nix
    then [ ./desktop.nix ]
    else [];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "24.11";

  home.packages = [
    pkgs.starship
    pkgs.fzf
    pkgs.bat
    pkgs.difftastic
    pkgs.fastfetch
    pkgs.pass
    pkgs.just
    pkgs.gh

    pkgs.pre-commit

    pkgs-stable.neovim
    pkgs.ripgrep

    pkgs.ccache

    # To start using the stable toolchain, run:
    # ```
    # rustup toolchain install stable
    # rustup default stable
    # ```
    # To use the rust-analyzer, also run:
    # ```
    # rustup component add rust-analyzer
    # ```
    pkgs.rustup

    # my programs
    programs.starship_agnocast_kmod
    programs.safe-rm
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "bdm-k";
        email = "kokusyunn@gmail.com";
      };
      core.editor = "nvim";
    };
  };

  programs.home-manager.enable = true;
}
