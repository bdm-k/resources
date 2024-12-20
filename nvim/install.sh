set -e


echo '[info] Download the pre-built executable'
if [ $(uname -s) = 'Darwin' ]
then
  archive="nvim-macos-arm64.tar.gz"
else
  archive="nvim-linux64.tar.gz"
fi
wget -P ~/Downloads/ https://github.com/neovim/neovim/releases/latest/download/$archive
echo ''

echo '[info] Extract the archive'
mkdir -p ~/.local/bin
tar xvzf ~/Downloads/$archive -C ~/.local/bin/
echo ''

echo '[info] Create a symbolic link to the executable'
ln -s ~/.local/bin/${archive%.tar.gz}/bin/nvim ~/.local/bin/nvim
echo ''

echo '[info] Clone lazy.nvim'
git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
echo ''

echo '[info] Create a link to my configuration'
mkdir -p ~/.config
ln -s ~/resources/nvim ~/.config/nvim
