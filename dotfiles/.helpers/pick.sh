#-----------------------------------------------------------------
# pick
#-----------------------------------------------------------------


# helper to print and execute command string
function _echo_and_execute(){
  echo $1
  eval $1
}


# git functions
#---------------------------------------------

# helper to get the current branch
function _current_branch(){
  echo $(git rev-parse --abbrev-ref HEAD)
}

# helper to pick a branch, local or remote. trims leading whitespace, and "*" if necessary
function _pick_branch(){
  echo $(git branch -a | pick | sed 's/^\*//'| xargs echo)
}

# helper to pick a commit hash
function _pick_commit(){
  # `tr -d` to remove non-ascii chars, these chars cause strange bug with multi-line pick output
  echo $(git log --pretty=format:'%h %ad | %s%d [%an]' --date=short | tr -d '\200-\377' | pick | cut -d ' ' -f1)
}


# SYNOPSIS: pick a branch and do something with it, or copy the branch name
# USAGE: gbp go, gbp git merge, gbp gd --name-only, ...
function gbp(){
  branch=$(_pick_branch)
  if [ $# -eq 0 ]; then echo -n $branch | pbcopy; return; fi
  _echo_and_execute "$* $branch"
}

# pick other, compare files with current, then pick one of these files
function gbpf(){
  cd $(git rev-parse --show-toplevel) # cd into root of repo, otherwise git diff for file won't work
  other=$(_pick_branch)
  _echo_and_execute "git diff $other --name-only | pick | xargs git diff $other --"
}


# SYNOPSIS: pick a past commit on this branch and do something with it, or copy the commit hash
# USAGE: ghp go, ghp gd --name-only, ...
function ghp(){
  commit=$(_pick_commit)
  if [ $# -eq 0 ]; then echo -n $commit | pbcopy; return; fi
  _echo_and_execute "$* $commit"
}

# pick a past commit, pick a file that has changed since that commit, see the differences
function ghpf(){
  cd $(git rev-parse --show-toplevel) # cd into root of repo, otherwise git diff for file won't work
  commit=$(_pick_commit)
  gitfile=$(git diff --name-only ${commit} | pick)
  _echo_and_execute "git diff ${commit}:${gitfile} ${gitfile}"
}


# find out how far ahead or behind `this` is compared with `other`
function gbc(){
  if [ $# -eq 0 ]; then
    this=$(_current_branch)
  else
    this=$(_pick_branch)
  fi
  other=$(_pick_branch)
  _echo_and_execute "git rev-list --left-right --count ${this}...${other}"
}

# see all commits on `this` that are not on `other`, and vice versa
function gbca(){
  if [ $# -eq 0 ]; then
    this=$(_current_branch)
  else
    this=$(_pick_branch)
  fi
  other=$(_pick_branch)
  _echo_and_execute "git log --stat ${other}..${this} && git log --stat ${this}..${other}"
}

# pick a file that has changed since last commit
alias gdp="git diff --name-only | pick | xargs git diff"


# other functions
#---------------------------------------------

# find a process ID and copy it to the clipboard
alias psp="ps -ef | pick | awk '{print \$2}' | xargs echo -n | pbcopy"


# search history, filtering first with grep, then with pick
function hist(){
  $(history | tail -r | grep -E $* | pick | xargs | cut -d ' ' -f 2- | xargs | tr -d '\n' | pbcopy)
}
