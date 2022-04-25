# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git poetry)

source $ZSH/oh-my-zsh.sh

# http://zsh.sourceforge.net/Doc/Release/Options.html
setopt extended_glob
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# br: https://github.com/Canop/broot (A new way to see and navigate directory trees)
source ~/Library/Preferences/org.dystroy.broot/launcher/bash/br

# fzf: https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

####################
# ZLE CONFIG
####################

# http://sgeb.io/posts/2014/04/zsh-zle-custom-widgets/
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#index-bindkey

# `^` for `ctrl` and `\e` for `alt`

# http://stackoverflow.com/questions/7767702
# in iterm: Preferences > Profiles > Keys
# choose a key combo, e.g. ctrl + up_arrow, and instruct it to send escape sequence, e.g. ^[[1;5A
# escape sequence is caught here caught and invokes a widget

# disable or alter conflicting hotkeys: System Preferences > Keyboard > Shortcuts

# widget for killing line, and piping it from the kill ring to pbcopy
function copy-kill-whole-line {
  zle kill-whole-line
  echo -n $CUTBUFFER | pbcopy
}
zle -N copy-kill-whole-line

bindkey '\e^[[A' copy-kill-whole-line # `alt + up_arrow`
bindkey '^[[1;5A' copy-kill-whole-line # `ctrl + up_arrow`

# widget for selecting a region, or copying and killing the selected region
function select-copy-kill-region {
  if [ "$REGION_ACTIVE" -eq "0" ]; then
    zle select-a-word
  else
    zle kill-region
    echo -n $CUTBUFFER | pbcopy
    zle yank
  fi
}
zle -N select-copy-kill-region

bindkey '\e^[[B' select-copy-kill-region # `alt + down_arrow`
bindkey '^[[1;5B' select-copy-kill-region # `ctrl + down_arrow`

####################
# END ZLE CONFIG
####################

# source .bash_profile after sourcing all other config files
source ~/.bash_profile
