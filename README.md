# Dotfiles

My dotfiles. The ones worth looking at are `.zshrc`, `.bash_profile`, and the helpers in `.helpers` / `.zshhelpers`. Honorable mention for `.tmux.conf`.

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

If one of these combinations doesn't send anything, you can use always use iTerm2 to have it send any escape sequence you like. Go to **Preferences > Profiles > Keys**, choose a key combo, and instruct it to **Send Escape Sequence**.

Then you can edit your `.zshrc` file to catch this escape sequence, and have it invoke a widget. Check out how I've done this in `/dotfiles/.zshhelpers/zle.sh`.

## Helpers

The most interesting ones use [pick](https://github.com/thoughtbot/pick) and [yank](https://github.com/mptre/yank) to create fuzzy select utility functions.
