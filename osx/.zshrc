# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(git poetry)

source $ZSH/oh-my-zsh.sh

# http://zsh.sourceforge.net/Doc/Release/Options.html
setopt extended_glob
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# https://github.com/Canop/broot (A new way to see and navigate directory trees)
source ~/Library/Preferences/org.dystroy.broot/launcher/bash/br

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
