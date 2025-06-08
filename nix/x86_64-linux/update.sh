HM_DIR=$HOME/.config/home-manager

cp flake.nix home.nix $HM_DIR

# Determine whether the system is a desktop environment
if pgrep gnome > /dev/null
then
  cp desktop.nix $HM_DIR
fi

home-manager switch --impure
