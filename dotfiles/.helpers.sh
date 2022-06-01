#-----------------------------------------------------------------
# docker functions and aliases
#-----------------------------------------------------------------
alias dks='docker stop $(docker ps -aq)'

dksh() {
  docker exec -it $1 bash
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

alias fzfm='fzf --multi --bind ctrl-a:select-all --bind ctrl-s:deselect-all'

function fzfd() {
  find $1 -type f | fzf
}

#-----------------------------------------------------------------
# ripgrep
#-----------------------------------------------------------------
alias rgh='rg --smart-case --hidden --no-ignore'
alias rg='rg --smart-case'

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
alias ta='tmux attach-session -t'
alias tk='tmux kill-session -t'

alias ip='ipython --no-confirm-exit'
