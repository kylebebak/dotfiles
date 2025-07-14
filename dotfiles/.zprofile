if [[ -f /opt/homebrew/bin/brew ]]; then
  # Doesn't error on older versions of brew
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

PATH="/opt/homebrew/bin:$PATH"

PATH="${HOME}/.nvm/current/bin:$PATH"
export PATH
