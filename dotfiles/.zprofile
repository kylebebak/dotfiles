# This runs before .zshrc; for Sublime Text to pick up changes to path, they should be made here, not in .zshrc
# make sure /usr/local/bin occurs before /usr/bin in $PATH
PATH="/usr/local/bin:${PATH}"

# make sure this shows up before /usr/local/bin in $PATH
PATH="${HOME}/.local/bin:${PATH}"

if [[ -f /opt/homebrew/bin/brew ]]; then
  # Doesn't error on older versions of brew
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

PATH="/opt/homebrew/bin:$PATH"

PATH="${HOME}/.nvm/current/bin:$PATH"
export PATH

# rust
PATH="$HOME/.cargo/bin:$PATH"
