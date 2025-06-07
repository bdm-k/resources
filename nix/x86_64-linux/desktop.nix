{ config, pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.source-code-pro
  ];

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
  };
}
