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
