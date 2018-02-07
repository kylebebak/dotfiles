#-----------------------------------------------------------------
# docker functions and aliases
#-----------------------------------------------------------------
alias dkp='docker ps | yank'
alias dk='docker-compose'

dksh() {
  docker exec -it $1 /bin/bash
}

dkash() {
  docker exec -it $1 /bin/ash
}
