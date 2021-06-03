# search history, filtering first with grep, then with pick
# doesn't use xargs because xargs removes quotes from strings!
function _fzf__hist() {
  command=$(history | tail -r | fzf | awk '{$1=$1};1' | cut -d ' ' -f 2-)
  echo -n "$command" | pbcopy
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


alias hist='_fzf__hist'
