# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

. /usr/share/autojump/autojump.sh

# Aliases
source ~/.git_aliases

alias yank="yank-cli -- xsel -b"

alias ta="tmux attach-session -t"

# yarn
export PATH="$HOME/.yarn/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# http://zsh.sourceforge.net/Doc/Release/Options.html
setopt extended_glob
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

####################
# ZLE CONFIG
####################

# widget for killing line, and piping it from the kill ring to pbcopy
function copy-kill-whole-line {
  zle kill-whole-line
  echo -n $CUTBUFFER | xsel -b
}
zle -N copy-kill-whole-line

bindkey '^@' copy-kill-whole-line # `ctrl + space`
bindkey '^[[1;5A' copy-kill-whole-line # `ctrl + up`

####################
# END ZLE CONFIG
####################

# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.helpers.sh
