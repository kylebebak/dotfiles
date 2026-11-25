# Interactive shells only. PATH changes belong in ~/.zprofile.

####################
# Oh My Zsh
####################

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

# Also runs compinit, so completion does not need to be initialized again below.
source $ZSH/oh-my-zsh.sh

# http://zsh.sourceforge.net/Doc/Release/Options.html
setopt extended_glob

####################
# History
####################

# Pin history to the real file, so subshells like kubie that set ZDOTDIR to a temp dir don't disable shared history
export HISTFILE="$HOME/.zsh_history"

# Share history between zsh sessions; press enter in any session to pull in
# the latest from $HISTFILE. (Oh My Zsh also enables this by default.)
setopt share_history

# Don't keep duplicate commands, commands starting with a space, or extra blanks.
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

# Number of commands to remember in memory (in-session)
export HISTSIZE=50000
# Number of commands to save to the history file
export SAVEHIST=50000

####################
# Tools
####################

# fzf: https://github.com/junegunn/fzf
# Provides ctrl+r history search, ctrl+t file search and alt+c directory jump.
source <(fzf --zsh)

# Pull in history written by other shells before fzf builds its list,
# so ctrl+r sees commands from other terminals immediately.
_fzf_history_widget_fresh() {
  builtin fc -RI
  fzf-history-widget
}
zle -N _fzf_history_widget_fresh
bindkey -M emacs '^R' _fzf_history_widget_fresh

# https://github.com/ajeetdsouza/zoxide
# Smarter `cd`: `z <partial-name>` jumps to frequently used directories.
eval "$(zoxide init zsh)"

source ~/.git_aliases.zsh
source ~/.helpers.zsh

# fnm (node version manager): switches node version per directory.
# The default node on PATH comes from ~/.zprofile.
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

####################
# Prompt
####################

# robbyrussell look, split over two lines.
# Line 1: last path segment and git info (git_prompt_info uses the theme's git:(branch) ✗ format).
# Line 2: green arrow, red when the last command failed.
setopt PROMPT_SUBST
PROMPT=$'%B%F{cyan}%c%f%b $(git_prompt_info)\n%B%(?.%F{green}.%F{red})➜%f%b '

####################
# Work
####################

# Work-specific; source files in ~/.work, if dir exists.
# Keep this last: these files may add to PATH (e.g. openjdk) and set tokens.
for f in ~/.work/*(-.N); do source "$f"; done
unset f

# Remove duplicate PATH entries added above (also set in ~/.zprofile).
typeset -U path PATH
