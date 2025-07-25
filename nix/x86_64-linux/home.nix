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
    pkgs.neofetch
    pkgs.gcc
    pkgs.gnumake
    pkgs.cmake
    pkgs.clang-tools
    pkgs.lua-language-server

    pkgs-stable.neovim
    pkgs.ripgrep

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

    pkgs.qemu

    # my programs
    programs.starship_agnocast_kmod
    programs.safe-rm
  ];

  programs.git = {
    enable = true;
    userName = "bdm-k";
    userEmail = "kokusyunn@gmail.com";
    extraConfig = {
      core.editor = "nvim";
    };
  };

  programs.home-manager.enable = true;
}
