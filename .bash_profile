# in zsh, this is not sourced by default. instead, ~/.zshrc is sourced, so that file has a line which sources this one


#-----------------------------------------------------------------
# path environment variables
#-----------------------------------------------------------------

# shell

# user bin
PATH="${PATH}:~/bin"

# make sure /usr/local/bin occurs before /usr/bin in $PATH
PATH="/usr/local/bin:${PATH}"

# custom bin
PATH="$HOME/Dropbox/Programming/__bin/math:$PATH"
PATH="$HOME/Dropbox/Programming/__bin/notes:$PATH"
PATH="$HOME/Dropbox/Programming/__bin/other:$PATH"



# java

# setting and exporting java CLASSPATH isn't necessary, because you can place .jar files in /Library/Java/Extensions



# python

# virtualenv
export WORKON_HOME="$HOME/.virtualenvs"
source /usr/local/bin/virtualenvwrapper.sh



# ruby

# rbevn
PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"



export PATH



#-----------------------------------------------------------------
# ALIASES
#-----------------------------------------------------------------

	#----------------------------------------
	# OSX
	#----------------------------------------
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'


	#----------------------------------------
	# UNIX
	#----------------------------------------
alias lf="ls -l | egrep -v '^d'"
alias ldir="ls -l | egrep '^d'"

alias diff='diff -Bb'

alias grep='grep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn} -E'
alias ggrep='ggrep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn} -E'

alias sed='sed -E'
alias gsed='gsed -r'

alias ports='lsof -nP | grep -i listen'
alias process='ps -ef | grep -i'

alias ff='find . 2>/dev/null | ggrep -E'

alias ll='ls -lAh'

# copy path of working directory
alias cpwd='printf `pwd` | pbcopy'


	#----------------------------------------
	# shortcuts
	#----------------------------------------
alias code='cd ~/Dropbox/Programming'


	#----------------------------------------
	# app shortcuts
	#----------------------------------------
alias chrome='open -a "Google Chrome"'
alias sbl='open -a "Sublime Text"'




	#----------------------------------------
	# shells and interpreters
	#----------------------------------------

alias jc='javac *.java'

alias p='python'
alias ip='ipython --no-confirm-exit'


	#----------------------------------------
	# git
	#----------------------------------------
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias gh="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
alias go='git checkout'
alias gk='gitk --all&'
alias gx='gitx --all'
alias grs='git remote show origin'
alias gall='git add -u :/ && git add .'
alias gpp='git push origin HEAD'


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
# custom shell functions
#-----------------------------------------------------------------
source ~/.custom_functions.sh
