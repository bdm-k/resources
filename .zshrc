#===================#
# Zsh configuration #
#===================#
# Use emacs for the default base keymap
bindkey -e

# For the option meanings, refer to zshoptions(1)
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

setopt AUTO_CD

# Enable compsys
# autoload -Uz compinit && compinit


#===========#
# fzf setup #
#===========#
# Set up fzf key bindings and fuzzy completion
export FZF_CTRL_T_COMMAND=""
export FZF_ALT_C_COMMAND=""
source <(fzf --zsh)
# Disable the beep when exiting fzf search
unsetopt beep
# Customize the appearance
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse --info=inline"
#
# usage note of fzf
#
# * Press CTRL-r to fuzzy find throught shell history. The selected command will
#   be pasted onto the command-line.
#


#=====================#
# zsh-autosuggestions #
#=====================#
# Install zsh-autosuggestions if it's not installed yet
if [ ! -d $HOME/.zsh-autosuggestions ]
then
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh-autosuggestions
fi
# Enable zsh-autosuggestions
source $HOME/.zsh-autosuggestions/zsh-autosuggestions.zsh
# keybinding to accept the next part of the suggestion
bindkey '^ ' forward-word
# suggestion text color
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6e6f72"
#
# usage note of zsh-autosuggestions
#
# Press → to accept the entire suggestion, and press CTRL-space to accept the
# next part of the suggestion.
#


#=========#
# zsh-nvm #
#=========#
# This plugin allows you to load nvm on demand.
# Lazy loading of nvm can significantly improve shell startup time.
# Make sure ~/.zshrc does not load nvm.
#
# Install the plugin if it's not installed yet
if [ ! -d $HOME/.zsh-nvm ]
then
  git clone https://github.com/lukechilds/zsh-nvm.git $HOME/.zsh-nvm
fi
# Enable the lazy loading
export NVM_LAZY_LOAD=true
source $HOME/.zsh-nvm/zsh-nvm.plugin.zsh


#====================#
# other applications #
#====================#
# Init Starship
eval "$(starship init zsh)"

# C/C++ compilers
export CPATH="$HOME/.nix-profile/include${CPATH+:$CPATH}"
export LIBRARY_PATH="$HOME/.nix-profile/lib${LIBRARY_PATH+:$LIBRARY_PATH}"


#=========#
# aliases #
#=========#
# git
alias amend='git commit --amend --no-edit'
alias log='git log --oneline'
alias status='git status'
alias branch='git branch -v'

alias dat='bat --diff'

if [ $(uname -s) = 'Darwin' ]
then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi

alias nvim='_nvim'

# On Ubuntu, the Trash folder is located at ~/.local/share/Trash/
if which safe-rm > /dev/null 2>&1
then
  export SAFE_RM_USE_APPLESCRIPT=no
  alias rm='safe-rm'
fi

alias sleep-record='node $HOME/resources/programs/sleep-record/dist/index.mjs'


#===========#
# functions #
#===========#
# If nvim is run without arguments, automtically start the pile picker
_nvim()
{
  if [ $# -eq 0 ]
  then
    command nvim -c 'Telescope frecency workspace=CWD'
  else
    command nvim $@
  fi
}
