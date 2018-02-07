# get N most recently modified files within current directory and all subdirectories
function mrm() {
  bold=`tput bold`
  normal=`tput sgr0`

  find . -type f -print0 | xargs -0 stat -f "%m %N" | sort -rn | head -$1 | while read line
  do
    read -r tmst filepath <<< "$line"
    echo "`date -r ${tmst}`     `dirname ${filepath}`/${bold}`basename ${filepath}`${normal}"
  done
}


function copyhist() {
  history | tail -r | pbcopy
}

function dum() {
  du -m $1 | sort -n | tail -n ${2:-10}
}

# tar -zxvf Code.tar.gz
alias archivecode='cd $HOME && tar -zcvf Code.tar.gz Code && mv Code.tar.gz GoogleDrive'
