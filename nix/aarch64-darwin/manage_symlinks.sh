CONFIG_DIR=$HOME/.config
ROOT=$HOME/resources

function symlinks()
{
  ln -s $ROOT/starship.toml $CONFIG_DIR/starship.toml

  mkdir -p "$HOME/Library/Application Support/Code/User"
  ln -s $ROOT/vscode/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
  ln -s $ROOT/vscode/settings.json "$HOME/Library/Application Support/Code/User/settings.json"

  mkdir -p $CONFIG_DIR/wezterm
  ln -s $ROOT/wezterm/wezterm.lua $CONFIG_DIR/wezterm/wezterm.lua

  mkdir -p $CONFIG_DIR/nvim
  ln -s $ROOT/nvim/init.lua $CONFIG_DIR/nvim/init.lua
  ln -s $ROOT/nvim/lua $CONFIG_DIR/nvim/lua
}

function clean_symlinks()
{
  rm \
    $CONFIG_DIR/starship.toml \
    "$HOME/Library/Application Support/Code/User/keybindings.json" \
    "$HOME/Library/Application Support/Code/User/settings.json" \
    $CONFIG_DIR/wezterm/wezterm.lua \
    $CONFIG_DIR/nvim/init.lua \
    $CONFIG_DIR/nvim/lua
}

if [ $1 = "symlinks" ]; then
  symlinks
fi

if [ $1 = "clean_symlinks" ]; then
  clean_symlinks
fi
