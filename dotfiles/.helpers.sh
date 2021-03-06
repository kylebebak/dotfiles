#-----------------------------------------------------------------
# docker functions and aliases
#-----------------------------------------------------------------
alias dkp='docker ps | yank'
alias dks='docker stop $(docker ps -aq)'
alias dk='docker-compose'

dksh() {
  docker exec -it $1 /bin/bash
}

#-----------------------------------------------------------------
# fzf, including pick-git; https://github.com/kylebebak/pick-git
#-----------------------------------------------------------------
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

function ff() {
  find "${1:-.}" 2>/dev/null | fzf
}

#-----------------------------------------------------------------
# other
#-----------------------------------------------------------------
alias ports='lsof -nP | grep -i listen'
alias process='ps -ef | fzf'

function port() {
  lsof -i tcp:$1
}

alias ll='ls -alF'

alias tl='tmux ls'
alias tn='tmux new -s'
alias ta='tmux attach -t'
alias tk='tmux kill-session -t'

alias ip='ipython --no-confirm-exit'
