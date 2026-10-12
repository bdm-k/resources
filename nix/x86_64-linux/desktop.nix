{ config, pkgs, ... }:
let
  bibata = "${pkgs.bibata-cursors}/share/icons";
in
{
  targets.genericLinux.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.brave-origin
    pkgs.wezterm

    pkgs.dart-sass  # For compiling my Obsidian CSS snippet

    pkgs.bibata-cursors

    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.source-code-pro
  ];

  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "Noto Sans" "Noto Sans CJK JP" ];
    serif     = [ "Noto Serif" "Noto Serif CJK JP" ];
    monospace = [ "Noto Sans Mono" "Noto Sans Mono CJK JP" ];
    emoji     = [ "Noto Color Emoji" ];
  };

  # Link the cursor theme
  xdg.dataFile."icons" = {
    source = "${pkgs.bibata-cursors}/share/icons";
    recursive = true;
  };

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
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
  };
}
