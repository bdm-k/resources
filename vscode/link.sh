kernel=$(uname -s)
if [ $kernel = 'Darwin' ]
then
  target_dir="$HOME/Library/Application Support/Code/User"
else
  target_dir="$HOME/.config/Code/User"
fi

cd $target_dir
ln -s ~/resources/vscode/keybindings.json keybindings.json
ln -s ~/resources/vscode/settings.json settings.json
cd -
