# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

# Pin history to the real file, so subshells like kubie that set ZDOTDIR to a temp dir don't disable shared history
export HISTFILE="$HOME/.zsh_history"

source $ZSH/oh-my-zsh.sh

# http://zsh.sourceforge.net/Doc/Release/Options.html
setopt extended_glob

# This opt shares history between zsh sessions, hit enter in any session to pull in latest from $HISTFILE
setopt share_history  # Enabled by default with https://github.com/ohmyzsh/ohmyzsh

setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

# We can remove entries from $HISTFILE, then run this function
function reload_hist() {
  # Clear history, reload session, reload history
  history -p
  source ~/.zshrc
  fc -R $HISTFILE
}

# Number of commands to remember in memory (in-session)
export HISTSIZE=50000
# Number of commands to save to the history file
export SAVEHIST=50000

# fzf: https://github.com/junegunn/fzf
source <(fzf --zsh)

# Pull in history written by other shells before fzf builds its list
_fzf_history_widget_fresh() {
  builtin fc -RI
  fzf-history-widget
}
zle -N _fzf_history_widget_fresh
bindkey -M emacs '^R' _fzf_history_widget_fresh

compinit

# https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

source ~/.git_aliases.zsh
source ~/.helpers.zsh

# fnm
FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "$(fnm env --shell zsh)"
fi

####################
# ZLE
####################

# http://sgeb.io/posts/2014/04/zsh-zle-custom-widgets/
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#index-bindkey

# `^` for `ctrl` and `\e` for `alt`

# disable or alter conflicting hotkeys: System Preferences > Keyboard > Shortcuts
# widget for killing line, and piping it from the kill ring to pbcopy
function copy-kill-whole-line {
  zle kill-whole-line
  echo -n $CUTBUFFER | pbcopy
}
zle -N copy-kill-whole-line

bindkey '^[[1;5A' copy-kill-whole-line # `ctrl + up_arrow`

# Default path for go toolchain (e.g. go, gofmt)
export PATH="/usr/local/go/bin:$PATH"
# Default location of "tools"/executabled installed by go
export PATH="$HOME/go/bin:$PATH"

####################
# Prompt
####################

# robbyrussell look, split over two lines.
# Line 1: last path segment and git info (git_prompt_info uses the theme's git:(branch) ✗ format).
# Line 2: green arrow, red when the last command failed.
setopt PROMPT_SUBST
PROMPT=$'%B%F{cyan}%c%f%b $(git_prompt_info)\n%B%(?.%F{green}.%F{red})➜%f%b '

# Work-specific; source files in ~/.work, if dir exists
for f in ~/.work/*(-.N); do source "$f"; done
unset f

# Remove duplicates
PATH=`echo -n $PATH | awk -v RS=: '!($0 in a) {a[$0]; printf("%s%s", length(a) > 1 ? ":" : "", $0)}'`
export PATH
