#-----------------------------------------------------------------
# docker functions and aliases
#-----------------------------------------------------------------
alias dkp='docker ps | yank'
alias dks='docker stop $(docker ps -aq)'
alias dk='docker-compose'

dksh() {
  docker exec -it $1 /bin/bash
}

dkash() {
  docker exec -it $1 /bin/ash
}

dkl() {
  if [ -z "$1" ]; then
    echo "No container supplied"
    return 1
  fi

  outfile=${1}_container_logs.txt
  docker logs $1 &> ~/Desktop/${outfile}
  echo ~/Desktop/$outfile
}
