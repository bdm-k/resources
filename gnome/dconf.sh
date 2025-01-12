set -e


# Use dark theme
gsettings set org.gnome.desktop.interface color-scheme prefer-dark


# Set the background image
if [ -f ~/resources/gnome/background-image.png ]
then
  gsettings set org.gnome.desktop.background picture-uri-dark file://$HOME/resources/gnome/background-image.png
else
  echo '[info] Skip setting the background image'
  echo "If you want to set the background image, place the image at $HOME/resources/gnome/background-image.png"
fi


# Make it easy to resize windows
gsettings set org.gnome.mutter draggable-border-width 20


#=============#
# Keybindings #
#=============#
# Disable some keybindings
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last "[]"
gsettings set org.gnome.shell.keybindings focus-active-notification "[]"
gsettings set org.gnome.shell.keybindings toggle-application-view "[]"
gsettings set org.gnome.shell.keybindings toggle-message-tray "[]"
gsettings set org.gnome.shell.keybindings toggle-overview "[]"
gsettings set org.gnome.mutter.keybindings switch-monitor "[]"
gsettings set org.gnome.shell.keybindings shift-overview-down "[]"
gsettings set org.gnome.shell.keybindings shift-overview-up "[]"

# General
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Alt>h']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"
gsettings set org.gnome.desktop.wm.keybindings cycle-group "['<Control>Left']"
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super><Alt><Control>f']"
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Super><Control>q']"

# Switch to workspaces
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super><Alt><Control>l']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super><Alt><Control>u']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super><Alt><Control>g']"

# Move window between workspaces
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-left "['<Super><Alt><Control>Left']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-right "['<Super><Alt><Control>Right']"


#==============#
# Dash to Dock #
#==============#
if [ -d ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com ]
then
  gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
  gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 128
  gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode ALL_WINDOWS
else
  echo '[info] Dash to Dock is not installed'
fi
