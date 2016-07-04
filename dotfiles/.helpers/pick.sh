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
  # `tr -d` to remove non-ascii chars, these chars cause strange bug with multi-line pick output
  echo $(git log --pretty=format:'%h %ad | %s%d [%an]' --date=short | tr -d '\200-\377' | pick | cut -d ' ' -f1)
}


# SYNOPSIS: pick a branch and pass it to `command`, or copy the branch name
# USAGE: gbp [command]
function gbp(){
  branch=$(_pick__pick_branch)
  if [ $# -eq 0 ]; then echo -n $branch | pbcopy; return; fi
  _pick__echo_and_execute "$* $branch"
}

# pick a branch, compare files with current state of working directory, pick one of these files and diff or show it
# USAGE: gbpf [-s]
function gbpf(){
  cd $(git rev-parse --show-toplevel) # cd into root of repo, otherwise git diff for file won't work
  other=$(_pick__pick_branch)
  gitfile=$(git diff $other --name-only | pick)

  if [[ "$@" == *"-s"* ]]; then
    _pick__echo_and_execute "git show ${other}:${gitfile}"
  else
    _pick__echo_and_execute "git diff ${other} -- ${gitfile}"
  fi
}


# SYNOPSIS: pick a commit and pass it to `command`, or copy the commit hash
# USAGE: ghp [command]
function ghp(){
  commit=$(_pick__pick_commit)
  if [ $# -eq 0 ]; then echo -n $commit | pbcopy; return; fi
  _pick__echo_and_execute "$* $commit"
}

# pick a commit, compare files with current state of working directory, pick one of these files and diff or show it
# USAGE: ghpf [-s]
function ghpf(){
  cd $(git rev-parse --show-toplevel) # cd into root of repo, otherwise git diff for file won't work
  commit=$(_pick__pick_commit)
  gitfile=$(git diff --name-only ${commit} | pick)

  if [[ "$@" == *"-s"* ]]; then
    _pick__echo_and_execute "git show ${commit}:${gitfile}"
  else
    _pick__echo_and_execute "git diff ${commit}:${gitfile} ${gitfile}"
  fi
}


# find out how far ahead or behind `this` branch is compared with `other`. pass `-b` to pick both branches
# USAGE: gbc [-b]
function gbc(){
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
function gbca(){
  if [[ "$@" == *"-b"* ]]; then
    this=$(_pick__pick_branch)
  else
    this=$(_pick__current_branch)
  fi
  other=$(_pick__pick_branch)
  _pick__echo_and_execute "git log --stat ${other}..${this} && git log --stat ${this}..${other}"
}


# other functions
#---------------------------------------------

# find a process ID and copy it to the clipboard
alias psp="ps -ef | pick | awk '{print \$2}' | xargs echo -n | pbcopy"


# search history, filtering first with grep, then with pick
function hist(){
  $(history | tail -r | grep -E $* | pick | xargs | cut -d ' ' -f 2- | xargs | tr -d '\n' | pbcopy)
}


