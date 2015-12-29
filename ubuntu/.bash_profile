# in zsh, this is not sourced by default. instead, ~/.zshrc is sourced, so that file has a line which sources this one

alias diff='diff -Bb'

alias grep='grep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn} -E'

alias ports='lsof -nP | grep -i listen'
alias process='ps -ef | grep -i'

alias ff='find . 2>/dev/null | grep -E'

alias ll='ls -lAh'
alias cpwd='printf `pwd` | pbcopy'



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

