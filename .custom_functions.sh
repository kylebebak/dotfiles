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

# get difference between HEAD and previous commit
function gdiff(){
  git diff --name-only `git rev-parse HEAD` `git rev-parse HEAD~$1`
}

function gdiffall(){
  git diff `git rev-parse HEAD` `git rev-parse HEAD~$1`
}

# get N most recently modified files within current directory and all subdirectories
function mr(){
  bold=`tput bold`
  normal=`tput sgr0`

  find . -type f -print0 | xargs -0 stat -f "%m %N" | sort -rn | head -$1 | while read line
  do
    read -r tmst filepath <<< "$line"
    # echo "${bold}`date -r ${tmst}`${normal}      ${filepath}"
    echo "`date -r ${tmst}`     `dirname ${filepath}`/${bold}`basename ${filepath}`${normal}"
  done
}






