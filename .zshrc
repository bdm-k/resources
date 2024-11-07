#===================#
# Zsh configuration #
#===================#
# For the option meanings, refer to zshoptions(1)
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS

setopt AUTO_CD


#===========#
# fzf setup #
#===========#
# Set up fzf key bindings and fuzzy completion
export FZF_CTRL_T_COMMAND=""
export FZF_ALT_C_COMMAND=""
source <(fzf --zsh)
# Disable the beep when exiting fzf search
unsetopt beep
#
# usage note of fzf
#
# * Press CTRL-r to fuzzy find throught shell history. The selected command will
#   be pasted onto the command-line.
#


#=====================#
# zsh-autosuggestions #
#=====================#
# Enable zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
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
