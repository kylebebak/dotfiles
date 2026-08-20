# Dotfiles

My dotfiles. Most important is `.zshrc`. Honorable mention for `.tmux.conf`.

## Local

To ensure the dotfiles are sourced correctly, clone this repo **into your home directoy** and run the following command:

```sh
cd $HOME && ln -s -f dotfiles/dotfiles/.* ./
```

This will symlink all of the dotfiles into your home directory.

Run `find -L $HOME -maxdepth 1 -type l -print` to list broken sym links.

## `.config`

```sh
mkdir -p ~/.config/mpv
ln -s -f ~/dotfiles/config/mpv/* ~/.config/mpv/

mkdir -p ~/.config/ghostty
ln -s -f ~/dotfiles/config/ghostty/* ~/.config/ghostty/
```

## ZLE

ZLE is the **zsh line editor**, and [this post](http://sgeb.io/posts/2014/04/zsh-zle-custom-widgets/) explains how to get the most out of it. Used for e.g. `copy-kill-whole-line`, see `dotfiles/.zshrc`.

## To install

- `zsh`
- `ripgrep`
- `fzf`
- `zoxide`
- `tmux`
- `fd`
- `bat`
- `delta`
- `jq`
- `uv`
- `fnm`
- `mpv`

## `git`

First, run `cp dotfiles/.gitconfig-template dotfiles/.gitconfig` to create `.gitconfig`, which is ignored, from the template.

## Repos

My repos are under:

- https://github.com/kylebebak
- https://github.com/fortana-co
- https://github.com/brigada-mx

## Signing commits

Add the following to `dotfiles/.gitconfig`:

```toml
[user]
  email = ...
  name = ...
  signingkey = ...

[commit]
  gpgsign = true

[gpg]
  program = /opt/homebrew/bin/gpg
# Path to gpg executable
```

## Multiple SSH keys

In `~/.ssh/config`:

```
Host github.com
  HostName github.com
  IdentityFile ~/.ssh/<work_ssh_key>
  IdentitiesOnly yes

# Personal GitHub account
Host github-personal
  HostName github.com
  IdentityFile ~/.ssh/<personal_ssh_key>
  IdentitiesOnly yes
```

Then run something like `git remote set-url origin git@github-personal:kylebebak/dotfiles.git`. This configures `git` to use personal SSH key when interacting with `kylebebak/dotfiles.git`.

## `mpv`

Don't install with `brew`, it includes too much cruft. Install app bundle from https://github.com/mpv-player/mpv/releases, then run `ln -s "/Applications/mpv.app/Contents/MacOS/mpv" ~/.local/bin/mpv` to get the CLI. It must be "unquarantined" via **Privacy & Security** settings.

Remove it from quarantined apps: `xattr -d com.apple.quarantine /Applications/mpv.app`

## `fnm`

```sh
fnm install <version>
fnm default <version>
npm install -g oxlint  # Installed under ${HOME}/.local/share/fnm/aliases/default/bin
```
