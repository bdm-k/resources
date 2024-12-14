kernel_name=$(uname -s)
if [ $kernel_name = 'Darwin' ]
then
  target_dir='~/Library/Application Support/Code/User'
else
  target_dir='~/.config/Code/User'
fi

ln -s ~/resources/vscode/keybindings.json ${target_dir}/keybindings.json
ln -s ~/resources/vscode/settings.json ${target_dir}/settings.json
