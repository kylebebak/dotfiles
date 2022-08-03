eval "$(/opt/homebrew/bin/brew shellenv)"

PATH="${HOME}/.nvm/current/bin:$PATH"
export PATH

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
