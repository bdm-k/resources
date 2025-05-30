{ config, pkgs, ... }:
let
  username = import ./username.nix;
  resources = "/home/${username}/resources";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.starship
    pkgs.fzf
    pkgs.bat
    pkgs.neofetch
    pkgs.gh
    pkgs.gccgo
    pkgs.gnumake
    pkgs.clang-tools
    pkgs.lua-language-server

    pkgs.neovim
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

    pkgs.source-code-pro

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  programs.git = {
    enable = true;
    userName = "bdm-k";
    userEmail = "kokusyunn@gmail.com";
    extraConfig = {
      core.editor = "nvim";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
