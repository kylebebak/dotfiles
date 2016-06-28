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

