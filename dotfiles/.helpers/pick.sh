#-----------------------------------------------------------------
# pick
#-----------------------------------------------------------------


# helper to print and execute command string
function _pick__echo_and_execute(){
  echo $1
  eval $1
}


# git functions
#---------------------------------------------

# helper to get full path to repo root
function _pick__repository_root(){
  echo $(git rev-parse --show-toplevel)
}

# helper to get the current branch
function _pick__current_branch(){
  echo $(git rev-parse --abbrev-ref HEAD)
}

# helper to pick a branch, local or remote. trims leading whitespace, and "*" if necessary
function _pick__pick_branch(){
  echo $(git branch -a | pick | sed 's/^\*//'| xargs echo)
}

# helper to pick a commit hash
function _pick__pick_commit(){
  echo $(git log --pretty=format:'%h %ad | %s%d [%an]' --date=short "$@" | pick | cut -d ' ' -f1)
}

# helper to pick a commit hash from the reflog
function _pick__pick_commit_reflog(){
  echo $(git reflog --all --date=short | pick | cut -d ' ' -f1)
}

# helper to pick a file from the index
function _pick__pick_file(){
  echo $(git ls-tree -r master --name-only | pick)
}


# pick a branch and pass it to `command`, or copy the branch name
# USAGE: gbp [command]
function _pick__gbp(){
  branch=$(_pick__pick_branch)
  if [ $# -eq 0 ]; then echo -n $branch | pbcopy; return; fi
  _pick__echo_and_execute "$* $branch"
}

# pick a branch, compare files with current state of working directory, pick one of these files and diff or show it
# USAGE: gbpf [-s]
function _pick__gbpf(){
  cd $(_pick__repository_root) # cd into root of repo, otherwise git diff for file won't work
  other=$(_pick__pick_branch)
  gitfile=$(git diff --name-only $other | pick)
  echo -n $gitfile | pbcopy # copy filename

  if [[ "$@" == *"-s"* ]]; then
    _pick__echo_and_execute "git show ${other}:${gitfile}"
  else
    _pick__echo_and_execute "git diff ${other} -- ${gitfile}"
  fi
}


# pick a commit and pass it to `command`, or copy the commit hash
# USAGE: ghp [command]
function _pick__ghp(){
  commit=$(_pick__pick_commit)
  if [ $# -eq 0 ]; then echo -n $commit | pbcopy; return; fi
  _pick__echo_and_execute "$* $commit"
}

# pick a commit, compare files with current state of working directory, pick one of these files and diff or show it
# USAGE: ghpf [-s]
function _pick__ghpf(){
  cd $(_pick__repository_root) # cd into root of repo, otherwise git diff for file won't work
  commit=$(_pick__pick_commit)
  gitfile=$(git diff --name-only ${commit} | pick)
  echo -n $gitfile | pbcopy # copy filename

  if [[ "$@" == *"-s"* ]]; then
    _pick__echo_and_execute "git show ${commit}:${gitfile}"
  else
    _pick__echo_and_execute "git diff ${commit}:${gitfile} ${gitfile}"
  fi
}


# pick a commit from the reflog and pass it to `command`, or copy the commit hash.
# USAGE: grp [command]
function _pick__grp(){
  commit=$(_pick__pick_commit_reflog)
  if [ $# -eq 0 ]; then echo -n $commit | pbcopy; return; fi
  _pick__echo_and_execute "$* $commit"
}

# pick a commit from the reflog, compare files with current state of working directory, pick one of these files and diff or show it
# USAGE: ghpf [-s]
function _pick__grpf(){
  cd $(_pick__repository_root) # cd into root of repo, otherwise git diff for file won't work
  commit=$(_pick__pick_commit_reflog)
  gitfile=$(git diff --name-only ${commit} | pick)
  echo -n $gitfile | pbcopy # copy filename

  if [[ "$@" == *"-s"* ]]; then
    _pick__echo_and_execute "git show ${commit}:${gitfile}"
  else
    _pick__echo_and_execute "git diff ${commit}:${gitfile} ${gitfile}"
  fi
}


# find out how far ahead or behind `this` branch is compared with `other`. pass `-b` to pick both branches
# USAGE: gbc [-b]
function _pick__gbc(){
  if [[ "$@" == *"-b"* ]]; then
    this=$(_pick__pick_branch)
  else
    this=$(_pick__current_branch)
  fi
  other=$(_pick__pick_branch)
  _pick__echo_and_execute "git rev-list --left-right --count ${this}...${other}"
}

# see all commits on `this` branch that are not on `other`, and vice versa. pass `-b` to pick both branches
# USAGE: gbca [-b]
function _pick__gbca(){
  if [[ "$@" == *"-b"* ]]; then
    this=$(_pick__pick_branch)
  else
    this=$(_pick__current_branch)
  fi
  other=$(_pick__pick_branch)
  _pick__echo_and_execute "git log --stat ${other}..${this} && git log --stat ${this}..${other}"
}


# pick any file from index, then find all commits for this file. pick a commit and diff file against HEAD or [-s]how file
# USAGE: gpf [-s]
function _pick__gpf() {
  cd $(_pick__repository_root)
  gitfile=$(_pick__pick_file)
  echo -n $gitfile | pbcopy # copy filename

  commit=$(_pick__pick_commit --follow -- ${gitfile})
  if [[ "$@" == *"-s"* ]]; then
    _pick__echo_and_execute "git show ${commit}:${gitfile}"
  else
    _pick__echo_and_execute "git diff ${commit}:${gitfile} ${gitfile}"
  fi
}


# other functions
#---------------------------------------------

# find a process and copy the PID
alias _pick__psp="ps -ef | pick | awk '{print \$2}' | xargs echo -n | pbcopy"


# search history, filtering first with grep, then with pick
function _pick__hist(){
  $(history | tail -r | grep -iE $* | pick | xargs | cut -d ' ' -f 2- | xargs | tr -d '\n' | pbcopy)
}

function _yank__hist(){
  if [[ -z "$1" ]]; then
    num_lines=10
  else
    num_lines=$1
  fi
  history | tail "-$num_lines" -r | yank
}


# aliases
#---------------------------------------------

# all of the git functions in this file are now provided by `pick-git`, https://github.com/kylebebak/pick-git
alias gbp="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function branch"
alias ghp="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function commit"
alias grp="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function commit_reflog"
alias gfp="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function file"

alias gbpf="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function branch_file"
alias ghpf="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function commit_file"
alias grpf="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function commit_reflog_file"
alias gpf="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function file_commit"

alias gbc="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function branch_compare"


alias psp="_pick__psp"
alias hist="_pick__hist"
alias yh="_yank__hist"

alias cdp='cd $(find . -type d | pick)'
