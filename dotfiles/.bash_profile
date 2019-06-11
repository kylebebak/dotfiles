# in zsh, this is not sourced by default. instead, ~/.zshrc is sourced, so that file has a line which sources this one

#-----------------------------------------------------------------
# path environment variables
#-----------------------------------------------------------------

# postgres.app
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# make sure /usr/local/bin occurs before /usr/bin in $PATH
PATH="/usr/local/bin:${PATH}"

# make sure this shows up before /usr/local/bin in $PATH
PATH="${HOME}/.local/bin:${PATH}"

# my bin
PATH="${PATH}:${HOME}/Code/bin/lse"
PATH="${PATH}:${HOME}/Code/bin/math"
PATH="${PATH}:${HOME}/Code/bin/pick-helpers"

# node
PATH="$PATH:/usr/local/opt/node@8/bin"
# we can run nvm without having to load it on shell startup; check out dotfiles/.helpers/nvm.sh

# go, https://golang.org/doc/code.html
# https://dmitri.shuralyov.com/blog/18
GOPATH_0=$HOME/Code/go
export GOPATH=$GOPATH_0
PATH=$PATH:/usr/local/go/bin
PATH=$PATH:$GOPATH_0/bin

# rbevn
PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

# add RVM to PATH for scripting, make sure this is the last PATH variable change
PATH="$PATH:$HOME/.rvm/bin"

# remove duplicates
PATH=`echo -n $PATH | awk -v RS=: '!($0 in a) {a[$0]; printf("%s%s", length(a) > 1 ? ":" : "", $0)}'`
export PATH


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# android
export ANDROID_HOME=/usr/local/opt/android-sdk


#-----------------------------------------------------------------
# ALIASES
#-----------------------------------------------------------------


#----------------------------------------
# UNIX
#----------------------------------------
alias lf="ls -l | egrep -v '^d'"
alias ldir="ls -l | egrep '^d'"

alias diff='diff -Bb'

alias grep='grep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn} -E'
alias ggrep='ggrep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn} -E'

alias ports='sudo lsof -nP | grep -i listen'
alias process='ps -ef | grep -i'

alias ff='find . 2>/dev/null | ggrep -E'
alias fd='find . type -d 2>/dev/null -name'

alias ll='ls -lAh'

# copy path of working directory
alias cpwd='echo -n `pwd` | pbcopy'


#----------------------------------------
# app shortcuts
#----------------------------------------
alias chrome='open -a "Google Chrome"'
alias sbl='open -a "Sublime Text"'


#----------------------------------------
# shells and interpreters
#----------------------------------------
alias ip='ipython --no-confirm-exit'


#----------------------------------------
# git
#----------------------------------------
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias gm='git merge'
alias gh="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
alias gco='git checkout'
alias gk='gitk --all&'
alias gx='gitx --all'
alias grs='git remote show origin'
alias gall='git add -u :/ && git add .'
alias gpp='git push origin HEAD'
alias cdg='cd $(git rev-parse --show-toplevel)'


#----------------------------------------
# tmux
#----------------------------------------
alias tl='tmux ls'
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'


#----------------------------------------
# redis
#----------------------------------------
alias redis='redis-server /usr/local/etc/redis.conf'


#-----------------------------------------------------------------
# run custom startup scripts
#-----------------------------------------------------------------
# load notes init script for tab completions
which notes >/dev/null && . "$( notes -i )"


#-----------------------------------------------------------------
# custom shell options
#-----------------------------------------------------------------
# enables moving forward in reverse-i-search, ctrl+s
stty -ixon


#-----------------------------------------------------------------
# autojump
#-----------------------------------------------------------------
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh


#-----------------------------------------------------------------
# helper functions
#-----------------------------------------------------------------
for f in ~/.helpers/*; do source $f; done
