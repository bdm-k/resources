{ config, pkgs, ... }:
{
  targets.genericLinux.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.brave-origin
    pkgs.wezterm

    pkgs.dart-sass  # For compiling my Obsidian CSS snippet

    pkgs.source-code-pro
  ];

  services.xremap = {
    enable = true;
    withHypr = true;
    config.keymap = [ ];
    extraArgs = [
      "--watch=device,config"
      "${config.home.homeDirectory}/resources/xremap/xremap-config.yaml"
    ];
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };
}
