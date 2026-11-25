# Login shells only. On macOS, terminal emulators start login shells, so this
# runs once per terminal window, before .zshrc. Put PATH changes here, not in
# .zshrc, so GUI apps launched from a login shell (e.g. Sublime Text) see them.

# Drop duplicate PATH entries, in all shells that read this file.
typeset -U path PATH

PATH="/usr/local/bin:$PATH"

PATH="$HOME/.local/bin:$PATH"

# Homebrew: adds /opt/homebrew/{bin,sbin}
if [[ -f /opt/homebrew/bin/brew ]]; then
  # Doesn't error on older versions of brew
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# fnm's default node, so GUI apps and non-interactive shells get a node.
# .zshrc also runs `fnm env` for per-directory version switching.
PATH="$HOME/.local/share/fnm/aliases/default/bin:$PATH"

# rust
PATH="$HOME/.cargo/bin:$PATH"

# Default path for go toolchain (e.g. go, gofmt)
PATH="/usr/local/go/bin:$PATH"
# Default location of "tools"/executables installed by go
PATH="$HOME/go/bin:$PATH"

export PATH
