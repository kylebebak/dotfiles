alias gp='git push'
alias gf='git fetch'
alias gl='git pull'
alias glr='git pull --rebase'
alias gs='git status'
alias gst='git stash'
alias gsp='git stash pop'
alias gb='git branch'
alias gco='git checkout'
alias gc='git commit'
alias gm='git merge'
alias gd='git diff'
alias gdm='git diff --merge-base'
alias ga='git add'
alias gr='git rebase'
alias gcp='git cherry-pick'
alias ghh="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
alias gw="git worktree"

gco_merge() {
  local base_branch="${1:-main}"
  local branch="${2:-HEAD}"
  git reset --soft $(git merge-base "$base_branch" "$branch")
}

alias hd='hunk diff'
hdm() {
  local base_branch="${1:-main}"
  local branch="${2:-HEAD}"
  hunk diff $(git merge-base "$base_branch" "$branch")
}
