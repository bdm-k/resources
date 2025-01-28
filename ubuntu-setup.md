1. Install Zsh by running `sudo apt install zsh`.
1. Change the login shell to Zsh by running `chsh -s $(which zsh)`. You need to log in again for it to take effect.
1. Install Nix and Home Manager. ([guide](https://github.com/Evertras/simple-homemanager/blob/main/01-install.md))
1. Clone this repository by running `nix-shell -p git --run 'git clone https://github.com/bdm-k/resources.git'`.
1. Update the Home Manager configuration to [this](https://github.com/bdm-k/resources/blob/main/home-manager/home.nix).
