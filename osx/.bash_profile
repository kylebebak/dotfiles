# in zsh, this is not sourced by default. instead, ~/.zshrc is sourced, so that file has a line which sources this one

#-----------------------------------------------------------------
# path environment variables
#-----------------------------------------------------------------

# make sure /usr/local/bin occurs before /usr/bin in $PATH
PATH="/usr/local/bin:${PATH}"

# make sure this shows up before /usr/local/bin in $PATH
PATH="${HOME}/.local/bin:${PATH}"

PATH="/usr/local/sbin:${PATH}"

# my bin
PATH="${PATH}:${HOME}/Code/bin"

# postgres.app
PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# node
# we can run nvm without having to load it on shell startup; check out osx/.helpers/nvm.sh
# node installed with brew, `brew install node@12`
PATH="/usr/local/opt/node@14/bin:$PATH"
export NVM_SYMLINK_CURRENT=true

# go, https://golang.org/doc/code.html, https://dmitri.shuralyov.com/blog/18
export GOPATH=$HOME/go
PATH=$PATH:/usr/local/go/bin
PATH=$PATH:$GOPATH/bin

# lua, https://www.lua.org/download.html
PATH=$PATH:/usr/local/lua-5.4.3/src

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
alias grep='grep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn} -E'

# copy path of working directory
alias cpwd='echo -n `pwd` | pbcopy'

alias chrome='open -a "Google Chrome"'
alias sbl='open -a "Sublime Text"'
alias vscode='open -a "Visual Studio Code"'

source ~/.git_aliases

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
source ~/.helpers.sh
for f in ~/.helpers/*; do source $f; done
