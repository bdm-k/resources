# To install gnome extensions, use the Extension Manager app, which can be installed by running:
# ❯ sudo apt update
# ❯ sudo apt install gnome-shell-extension-manager


EXTENSIONS_DIR=$HOME/.local/share/gnome-shell/extensions


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
gsettings set org.gnome.shell.keybindings toggle-quick-settings "[]"
gsettings set org.gnome.mutter.keybindings switch-monitor "[]"
gsettings set org.gnome.shell.keybindings shift-overview-down "[]"
gsettings set org.gnome.shell.keybindings shift-overview-up "[]"

# General
gsettings set org.gnome.desktop.wm.keybindings minimize "['<Super>m']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Super>q']"
gsettings set org.gnome.desktop.wm.keybindings cycle-group "['<Control>Left']"
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super><Alt><Control>v']"
gsettings set org.gnome.desktop.wm.keybindings begin-resize "['<Super><Alt><Control>8']"
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
if [ -d $EXTENSIONS_DIR/dash-to-dock@micxgx.gmail.com ]
then
  gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
  gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 128
  gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode ALL_WINDOWS
  gsettings set org.gnome.shell.extensions.dash-to-dock shortcut "[]"
  gsettings set org.gnome.shell.extensions.dash-to-dock shortcut-text ""
else
  echo '[INFO] Dash to Dock is not installed'
fi

#===================#
# Clipboard History #
#===================#
if [ ! -d $EXTENSIONS_DIR/clipboard-history@alexsaveau.dev ]
then
  echo '[INFO] Clipboard History is not installed'
fi

#===============#
# Blur my Shell #
#===============#
if [ ! -d $EXTENSIONS_DIR/blur-my-shell@aunetx ]
then
  echo '[INFO] Blur my Shell is not installed'
fi

#=========================#
# Native Window Placement #
#=========================#
if [ ! -d $EXTENSIONS_DIR/native-window-placement@gnome-shell-extensions.gcampax.github.com ]
then
  echo '[INFO] Native Window Placement is not installed'
fi

#========#
# Xremap #
#========#
if [ ! -d $EXTENSIONS_DIR/xremap@k0kubun.com ]
then
  echo '[INFO] Xremap is not installed'
fi

#====================#
# Input Method Panel #
#====================#
if [ ! -d $EXTENSIONS_DIR/kimpanel@kde.org ]
then
  echo '[INFO] Input Method Panel is not installed'
fi

#==============#
# Tiling Shell #
#==============#
if [ ! -d $EXTENSIONS_DIR/tilingshell@ferrarodomenico.com ]
then
  echo '[INFO] Tiling Shell is not installed'
fi
