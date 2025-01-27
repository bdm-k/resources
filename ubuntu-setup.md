1. Install Zsh by running `sudo apt install zsh`.
1. Change the login shell to Zsh by running `chsh -s $(which zsh)`. You need to log in again for it to take effect.
1. Install Nix and Home Manager. ([guide](https://github.com/Evertras/simple-homemanager/blob/main/01-install.md))
1. Use the following Home Manager configuration to make Git and GitHub CLI available:
   ```nix
   { config, pkgs, ... }:
   let
     username = import ./username.nix;
   in
   {
     home.username = username;
     home.homeDirectory = "home/${username}";
     home.stateVersion = "24.11";
     home.packages = [
       pkgs.git
       pkgs.gh
     ];
     programs.home-manager.enable = true;
   }
   ```
1. Create a key pair by running `ssh-keygen -t ed25519`, then authenticate the GitHub CLI by running `gh auth login`.
1. Clone this repository and update the Home Manager configuration to [this](https://github.com/bdm-k/resources/blob/main/home-manager/home.nix).
