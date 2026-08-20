#-----------------------------------------------------------------
# docker functions and aliases
#-----------------------------------------------------------------
alias dks='docker stop $(docker ps -aq)'

dksh() {
  docker exec -it $1 ${2:-bash}
}

# no reason to use docker-compose anymore, https://docs.docker.com/compose/migrate/
alias docker-compose='docker compose'

#-----------------------------------------------------------------
# fzf, including pick-git; https://github.com/kylebebak/pick-git
#-----------------------------------------------------------------
alias gbp="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function branch"
alias gtp="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function tag"
alias ghp="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function commit"
alias grp="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function commit_reflog"
alias gfp="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function file"

alias gbpf="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function branch_file"
alias ghpf="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function commit_file"
alias grpf="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function commit_reflog_file"
alias gpf="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function file_commit"

alias gbc="pick-git --shell /bin/bash --rcfile ~/.git_aliases --function branch_compare"

alias fzfm='fzf --multi --bind ctrl-a:select-all --bind ctrl-s:deselect-all'

function fzfd() {
  find $1 -type f | fzf
}

function gww() {
  # https://git-scm.com/docs/git-worktree
  cd "$(git rev-parse --show-toplevel)"
  git worktree add -b $1 .worktrees/$1
}

#-----------------------------------------------------------------
# ripgrep
#-----------------------------------------------------------------
alias rga='rg --smart-case --hidden --no-ignore'
alias rgh='rg --smart-case --hidden'
alias rg='rg --smart-case'

#-----------------------------------------------------------------
# other
#-----------------------------------------------------------------
alias ports='lsof -nP | rg listen'
alias process='ps -ef | fzf'

alias ll='ls -alF'

alias tl='tmux ls'
alias tn='tmux new -s'
alias ta='tmux attach-session -t'
alias tk='tmux kill-session -t'

# After creating venv in home directory with `uv venv`, we can activate it and use this as "system python"
alias ap='source ~/.venv/bin/activate'

alias ip='ipython --no-confirm-exit'
alias oxf="oxfmt -c ~/.oxfmtrc.json"

#-----------------------------------------------------------------
# youtube-music-dl
#-----------------------------------------------------------------
export YMD_OUTPUT_DIR="$HOME/Google Drive/My Drive/Music"

#-----------------------------------------------------------------
# navidrome
#-----------------------------------------------------------------
# IMPORTANT: DataFolder and CacheFolder must live on the local disk.
# Also, SQLite cannot run on the Google Drive virtual filesystem
export ND_MUSICFOLDER="$HOME/Google Drive/My Drive/Music"
export ND_DATAFOLDER="$HOME/.local/share/navidrome"
export ND_CACHEFOLDER="$HOME/.cache/navidrome"

# Scan on startup, but don't checksum every file
export ND_SCANSCHEDULE="@every 24h"

export ND_ADDRESS=localhost

export ND_SCANNER_PURGEMISSING=always
