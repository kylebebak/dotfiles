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


# get N most recently modified files within current directory and all subdirectories
function mrm(){
  bold=`tput bold`
  normal=`tput sgr0`

  find . -type f -print0 | xargs -0 stat -f "%m %N" | sort -rn | head -$1 | while read line
  do
    read -r tmst filepath <<< "$line"
    echo "`date -r ${tmst}`     `dirname ${filepath}`/${bold}`basename ${filepath}`${normal}"
  done
}


# make or remove link to <executable> in ~/.local/bin. i wrote this function when
# working on `notes`, so that could quickly enable the dev version for
# testing, and then disable it to avoid conflicts with the homebrew keg.
# this depends on ${HOME}/bin coming before /usr/local/bin in $PATH
function userbin(){
  bin="${HOME}/.local/bin"

  while test $# -gt 0; do
    exe=`basename $1`
    tgt="${bin}/${exe}"
    src="$(pwd)/$1"

    if [ -L $tgt ]; then
      rm $tgt
      echo "removed ${exe} from ${bin}"
      shift && continue
    fi

    if [ -f $src ]; then
      ln -s $src $tgt
      echo "linked ${src} to ${tgt}"
      shift && continue
    fi

    echo "the file ${src} doesn't exist"
    return 1
  done

  return 0
}


# pipes the results of the first arg, list_cmd. then to pick. then to the second arg,
# clean_cmd. then to xargs so they can be executed by the remaining arguments,
# collectively called $exec_cmd. the first arg in exec_cmd can be an alias.
# this function can be used to build other functions that fix any of the three args
# to create fast utility functions or aliases
function _pick(){
  if [ $# -lt 3 ]; then
    echo "you must pass a list_cmd, and clean_cmd, and an exec_cmd to this function"
    return
  fi

  list_cmd="$1"
  shift
  clean_cmd="$1"
  shift

  # check if first arg after list_cmd is alias
  alias $1 &>/dev/null
  if [ $? -ne 0 ]; then
    eval "$list_cmd | pick | $clean_cmd | xargs $*"
  else
    exec_cmd=$(alias $1 | cut -d "=" -f 2 | tr -d "'")
    shift # remove alias, which was expanded and assigned to $exec_cmd
    eval "$list_cmd | pick | $clean_cmd | xargs $exec_cmd $*"
  fi
}


# search history, filtering first with grep, then with pick
function hist(){
  $(history | tail -r | grep -E $* | pick | xargs | cut -d ' ' -f 2- | xargs | tr -d '\n' | pbcopy)
}


# git functions
#-----------------------------------------------------------------

# helper to get the current branch
function _current_branch(){
  echo $(git rev-parse --abbrev-ref HEAD)
}

# helper to pick a branch, local or remote. trims leading whitespace, and "*" if necessary
function _pick_branch(){
  echo $(git branch -a | pick | sed 's/^\*//'| xargs echo)
}


# SYNOPSIS: pick a branch and do something with it
# USAGE: gbp go, gbp git merge, gbp gd --name-only, ...
function gbp(){
  _pick "git branch -a" "cat" $*
}

# SYNOPSIS: pick a past commit on this branch and do something with it
# USAGE: ghp go, ghp gd --name-only, ...
function ghp(){
  _pick "git log --pretty=format:'%h %ad | %s%d [%an]' --date=short" "cut -d ' ' -f1" $*
}

# pick a file that has changed since last commit
alias gdp="git diff --name-only | pick | xargs git diff"

# pick other, compare files with current, then pick one of these files. this function only works from the root directory of the repo
function gdbp(){
  other=$(_pick_branch)
  git diff $other --name-only | pick | xargs git diff $other --
}

# find out how far ahead or behind `this` is compared with `other`
function gbc(){
  this=$(_pick_branch)
  other=$(_pick_branch)
  git rev-list --left-right --count ${this}...${other}
}

# see all commits on `this` that are not on `other`, and vice versa
function gbca(){
  this=$(_pick_branch)
  other=$(_pick_branch)
  git log --stat ${other}..${this} && \
  git log --stat ${this}..${other}
}
