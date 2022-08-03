if [[ -f /opt/homebrew/bin/brew ]]; then
  # Doesn't error on older versions of brew
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

PATH="${HOME}/.nvm/current/bin:$PATH"
export PATH

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
