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
# FUNCTIONS (not in custom bin directory)
#-----------------------------------------------------------------
function countdown(){
   date1=$((`date +%s` + $1));
   while [ "$date1" -ne `date +%s` ]; do
     echo -ne "$(gdate -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
}

function count(){
  date1=`date +%s`;
   while true; do
    echo -ne "$(gdate -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
   done
}

# get difference between HEAD and previous commit
function gdiff(){
	git diff --name-only `git rev-parse HEAD` `git rev-parse HEAD~$1`
}

function gdiffall(){
	git diff `git rev-parse HEAD` `git rev-parse HEAD~$1`
}

# get N most recently modified files within current directory and all subdirectories
function mr(){
	bold=`tput bold`
	normal=`tput sgr0`

	find . -type f -print0 | xargs -0 stat -f "%m %N" | sort -rn | head -$1 | while read line
	do
		read -r tmst filepath <<< "$line"
		# echo "${bold}`date -r ${tmst}`${normal}      ${filepath}"
		echo "`date -r ${tmst}`     `dirname ${filepath}`/${bold}`basename ${filepath}`${normal}"
	done

}






