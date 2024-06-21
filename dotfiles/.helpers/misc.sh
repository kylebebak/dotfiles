# Get N most recently modified files within current directory and all subdirectories
function mrm() {
  bold=`tput bold`
  normal=`tput sgr0`

  find . -type f -print0 | xargs -0 stat -f "%m %N" | sort -rn | head -$1 | while read line
  do
    read -r tmst filepath <<< "$line"
    echo "`date -r ${tmst}`     `dirname ${filepath}`/${bold}`basename ${filepath}`${normal}"
  done
}

# Get top $2 entries under directory $1 by disk usage
function dum() {
  du -m $1 | sort -n | tail -n ${2:-10}
}

# Get $1 most frequently modified files according to git log
function churn() {
  git log --format=format: --name-only --since=6.month \
 | egrep -v '^$' \
 | sort \
 | uniq -c \
 | sort -nr \
 | head -${1:-30}
}
