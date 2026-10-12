# Session-wide environment
#
# This is useful for non-interactive shells that haven't sourced .zshrc yet but
# still need to access the same environment variables.

#============================#
# nix and home-manager setup #
#============================#
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

if [ -e "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
  . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
fi


#========#
# ccache #
#========#
# If ccache is installed, make sure the symbolic links and environment variables
# are set up.
command -v ccache > /dev/null 2>&1
if [ $? -eq 0 ]
then
  if [ ! -d $HOME/.local/bin/ccache ]
  then
    mkdir -p $HOME/.local/bin/ccache
    ccache_bin=$(command -v ccache)
    ln -s $ccache_bin $HOME/.local/bin/ccache/ccache
    ln -s $ccache_bin $HOME/.local/bin/ccache/gcc
    ln -s $ccache_bin $HOME/.local/bin/ccache/g++
  fi

  export CC="$HOME/.local/bin/ccache/gcc"
  export CXX="$HOME/.local/bin/ccache/g++"
  export CCACHE_DIR="$HOME/.cache/ccache"
fi


#====================#
# other applications #
#====================#
# C/C++ compilers
export CPATH="$HOME/.nix-profile/include${CPATH+:$CPATH}"
export LIBRARY_PATH="$HOME/.nix-profile/lib${LIBRARY_PATH+:$LIBRARY_PATH}"

export EDITOR=nvim

export PATH="$HOME/.local/bin${PATH+:$PATH}"
