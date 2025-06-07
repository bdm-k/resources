HM_DIR=$HOME/.config/home-manager

cp flake.nix home.nix $HM_DIR

if [ -n $XDG_CURRENT_DESKTOP ]
then
  cp desktop.nix $HM_DIR
fi

home-manager switch
