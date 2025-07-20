{ config, pkgs, ... }:
{
  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.dart-sass  # For compiling my Obsidian CSS snippet

    pkgs.source-code-pro
  ];

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
    fcitx5.settings = {
      globalOptions = {
        "Hotkey"."TriggerKeys" = "";
        "Hotkey/ActivateKeys"."0" = "Hangul";
        "Hotkey/DeactivateKeys"."0" = "Hangul_Hanja";
      };
      inputMethod = {
        GroupOrder."0" = "Default";
        "Group/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "mozc";
        };
        "Group/0/Items/0".Name = "keyboard-us";
        "Group/0/Items/1".Name = "mozc";
      };
    };
  };
}
