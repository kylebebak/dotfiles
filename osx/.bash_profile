# in zsh, this is not sourced by default. instead, ~/.zshrc is sourced, so that file has a line which sources this one

#-----------------------------------------------------------------
# path environment variables
#-----------------------------------------------------------------

# make sure /usr/local/bin occurs before /usr/bin in $PATH
PATH="/usr/local/bin:${PATH}"

# make sure this shows up before /usr/local/bin in $PATH
PATH="${HOME}/.local/bin:${PATH}"

# my bin
PATH="${PATH}:${HOME}/Code/bin"

# postgres.app
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# node
# we can run nvm without having to load it on shell startup; check out osx/.helpers/nvm.sh
# node installed with brew, `brew install node@12`
PATH="/usr/local/opt/node@12/bin:$PATH"

# go, https://golang.org/doc/code.html, https://dmitri.shuralyov.com/blog/18
export GOPATH=$HOME/Code/go
PATH=$PATH:/usr/local/go/bin
PATH=$PATH:$GOPATH/bin

# python
eval "$(pyenv init -)"
PATH="$HOME/.poetry/bin:$PATH"

# ruby
# add RVM to PATH for scripting, make sure this is the last PATH variable change
PATH="$PATH:$HOME/.rvm/bin"

# rust
PATH="$HOME/.cargo/bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# remove duplicates
PATH=`echo -n $PATH | awk -v RS=: '!($0 in a) {a[$0]; printf("%s%s", length(a) > 1 ? ":" : "", $0)}'`
export PATH


#-----------------------------------------------------------------
# ALIASES
#-----------------------------------------------------------------
alias lf="ls -l | egrep -v '^d'"
alias ldir="ls -l | egrep '^d'"

alias diff='diff -Bb'

alias grep='grep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn} -E'

alias ports='lsof -nP | grep -i listen'
alias process='ps -ef | fzf'

function ff() {
  find "${1:-.}" 2>/dev/null | fzf
}

alias ll='ls -lAh'

# copy path of working directory
alias cpwd='echo -n `pwd` | pbcopy'

alias chrome='open -a "Google Chrome"'
alias sbl='open -a "Sublime Text"'
alias vscode='open -a "Visual Studio Code"'

alias ip='ipython --no-confirm-exit'

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

alias tl='tmux ls'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'

alias redis='redis-server /usr/local/etc/redis.conf'


#-----------------------------------------------------------------
# other
#-----------------------------------------------------------------
# load notes init script for tab completions
which notes >/dev/null && . "$( notes -i )"

# enables moving forward in reverse-i-search, ctrl+s
stty -ixon

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# helper functions
for f in ~/.helpers/*; do source $f; done
