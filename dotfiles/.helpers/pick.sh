# pick and yank functions
#---------------------------------------------

# find a process and copy the PID
alias _pick__psp="ps -ef | pick | awk '{print \$2}' | xargs echo -n | pbcopy"


# search history, filtering first with grep, then with pick
# doesn't use xargs because xargs removes quotes from strings!
function _pick__hist(){
  command=$(history | tail -r | grep -iE $* | pick | awk '{$1=$1};1' | cut -d ' ' -f 2-)
  echo -n "$command" | pbcopy
}

function _yank__recent_hist(){
  if [[ -z "$1" ]]; then
    num_lines=10
  else
    num_lines=$1
  fi
  history | tail "-$num_lines" -r | yank
}

function _pick__recent_hist(){
  if [[ -z "$1" ]]; then
    num_lines=20
  else
    num_lines=$1
  fi
  # get everything but first column
  command=$(history | tail "-$num_lines" -r | pick | awk '{$1=$1};1' | cut -d ' ' -f 2-)
  # use `echo -n` to remove trailing newline char
  echo -n "$command" | pbcopy
}

function _pick__jump() {
  cd "`pick-helpers --function jump $*`"
}


# aliases
#---------------------------------------------

# all of the git functions in this file are now provided by `pick-git`, https://github.com/kylebebak/pick-git
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


alias psp='_pick__psp'
alias dp='docker ps | yank'

alias hist='_pick__hist'
alias yh='_yank__recent_hist'
alias ph='_pick__recent_hist'

alias cdp='cd $(find . -type d | pick)'
alias pcp='pick | tr -d '\''\n'\'' | pbcopy' # pipe a list of options, pick one, remove trailing new line, smoke that pcp
alias jp='_pick__jump'
