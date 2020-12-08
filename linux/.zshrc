# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

. /usr/share/autojump/autojump.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Aliases
alias ll='ls -alF'

alias gbp="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function branch"
alias gtp="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function tag"
alias ghp="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function commit"
alias grp="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function commit_reflog"
alias gfp="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function file"
alias gbpf="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function branch_file"
alias ghpf="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function commit_file"
alias grpf="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function commit_reflog_file"
alias gpf="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function file_commit"
alias gbc="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function branch_compare"

source ~/.git_aliases

alias yank="yank-cli -- xsel -b"

alias ta="tmux attach-session -t"

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

# Docker
alias dkp='docker ps | yank'
dksh() {
  docker exec -it $1 bash
}

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
