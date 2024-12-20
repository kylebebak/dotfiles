# Dotfiles

My dotfiles. Most important is `.zshrc`. Honorable mention for `.tmux.conf`.

## Local

To ensure the dotfiles are sourced correctly, clone this repo **into your home directoy** and run the following command:

```sh
cd $HOME && ln -s -f dotfiles/dotfiles/.* ./
```

This will symlink all of the dotfiles into your home directory.

Run `find -L $HOME -maxdepth 1 -type l -print` to list broken sym links.

## ZLE and iTerm

ZLE, the **zsh line editor**, is very cool, and [this post](http://sgeb.io/posts/2014/04/zsh-zle-custom-widgets/) explains how to get the most out of it. If you use `zsh` it's worth a read.

To define some keyboard input as a shortcut for invoking a ZLE widget, it helps to know what **escape sequence** is sent by a given keyboard input. To find out, use `od -c`. `od` is the BSD **octal, decimal, hex, ASCII dump**. Run it, and try pressing one of the following key combinations:

- <kbd>shift</kbd> + <kbd>some_key</kbd>
- <kbd>ctrl</kbd> + <kbd>some_key</kbd>
- <kbd>alt</kbd> + <kbd>some_key</kbd>
- <kbd>super</kbd> + <kbd>some_key</kbd>

Or:

- <kbd>shift</kbd> + <kbd>ctrl</kbd> + <kbd>arrow_key</kbd>
- <kbd>shift</kbd> + <kbd>option</kbd> + <kbd>arrow_key</kbd>
- <kbd>fn</kbd> + <kbd>arrow_key</kbd>
- <kbd>fn</kbd> + <kbd>ctrl</kbd> + <kbd>arrow_key</kbd>
- <kbd>fn</kbd> + <kbd>option</kbd> + <kbd>arrow_key</kbd>

If one of these combinations doesn't send anything, you can always use iTerm2 to have it send any escape sequence you like. Go to **Preferences > Profiles > Keys**, choose a key combo, and instruct it to **Send Escape Sequence**.

Then you can edit your `.zshrc` file to catch this escape sequence, and have it invoke a widget.

## To install

- `zsh`
- `ripgrep`
- `fzf`
- `zoxide`
- `tmux`
- `broot`
- `delta`
- `node`
- `yarn`
- `poetry`
- `pyenv`
- `nvm`
- `mpv`

## `git`

First, run `cp dotfiles/.gitconfig-template dotfiles/.gitconfig` to create `.gitconfig`, which is ignored, from the template.

### Repos

My repos are under:

- https://github.com/kylebebak
- https://github.com/fortana-co
- https://github.com/brigada-mx

### Signing commits

Add the following to `dotfiles/.gitconfig`:

```
[user]
  email = ...
  name = ...
  signingkey = ...

[commit]
  gpgsign = true
```

### Multiple SSH keys

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

```sh
mkdir -p ~/.config/mpv
ln -s -f ~/dotfiles/mpv/* ~/.config/mpv/
```
