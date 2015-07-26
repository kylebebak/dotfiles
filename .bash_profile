# in zsh, this is not sourced by default. instead, ~/.zshrc is sourced, so that file has a line which sources this one

# echo $PATH, echo $PYTHONPATH, echo $R_HOME, etc
# a given environment variable need only be exported once, and then extra paths can be appended to it



#-----------------------------------------------------------------
# path environment variables
#-----------------------------------------------------------------

# shell

# user bin
PATH="${PATH}:/Users/kylebebak/bin"

# postgres
PATH="${PATH}:/Applications/SQL/Postgres.app/Contents/MacOS/bin"

# mamp
PATH="${PATH}:/Applications/MAMP/Library/bin"

# solr
PATH="${PATH}:/opt/solr-5.2.0/bin"

# make sure /usr/local/bin occurs before /usr/bin in $PATH
PATH="/usr/local/bin:${PATH}"

export PATH




# java

# export JAVA_HOME=$(/usr/libexec/java_home)

# setting and exporting java CLASSPATH in .bash_profile isn't necessary, because you can simply place .jar files in /Library/Java/Extensions and they are added automatically to the classpath

# adding a directory to the classpath can be done as follows

# CLASSPATH=.:/Users/kylebebak/Desktop/Dropbox/Programming/Eclipse/javaLibraries/*
# export CLASSPATH





# python

PYTHONPATH="/usr/local/lib/python2.7/site-packages"
PYTHONPATH="${PYTHONPATH}:/Library/Python/2.7/site-packages"
PYTHONPATH="${PYTHONPATH}:/Users/kylebebak/Library/Python/2.7/lib/python/site-packages"
# PYTHONPATH="${PYTHONPATH}:/usr/local/Cellar/phpsh/1.3/lib/python2.7/site-packages/phpsh"


export PYTHONPATH


# virtualenv
export WORKON_HOME="$HOME/.virtualenvs"
source /usr/local/bin/virtualenvwrapper.sh



# so that Gnuplot can use the x11 terminal
export GNUTERM=x11
# export GNUTERM=aqua




# ruby

# rbevn
eval "$(rbenv init -)"






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

alias ff='find . 2>/dev/null | ggrep -E'

alias ll='ls -lAh'

# copy path of working directory
alias cpwd='printf `pwd` | pbcopy'


	#----------------------------------------
	# shortcuts
	#----------------------------------------
alias root='cd /Users/kylebebak/Desktop/Dropbox/Programming/htdocs'
alias code='cd /Users/kylebebak/Desktop/Dropbox/Programming'
alias temp='cd /Users/kylebebak/Desktop/temp'
alias tuts='cd /Users/kylebebak/Desktop/Tutorials'
alias bin='cd /Users/kylebebak/Dropbox/Programming/__bin'


	#----------------------------------------
	# app shortcuts
	#----------------------------------------
alias mdown='open -a MacDown'
alias chrome='open -a "Google Chrome"'
alias sbl='open -a "Sublime Text"'




	#----------------------------------------
	# shells and interpreters
	#----------------------------------------
# so that mamp's version of php can be easily called from the command line, php5.2.17/ php5.3.14/ php5.4.4/
alias phpmamp='/Applications/MAMP/bin/php/php5.5.14/bin/php'

# create a command line alias for the mysql bundled with MAMP
alias mysql='/Applications/MAMP/Library/bin/mysql'
# another possibility: ln -s /Applications/MAMP/Library/bin/mysql /usr/bin/mysql

alias jc='javac *.java'

alias p='python'
alias p2='python'
alias p3='python3'
alias ip='ipython --no-confirm-exit'
alias ip2='/usr/local/bin/ipython --no-confirm-exit'
alias ip3='ipython3 --no-confirm-exit'


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






