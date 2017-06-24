# Dotfiles

My dotfiles. The ones worth looking at are `.tmux.conf`, `.bash_profile` and the ones in `.helpers` / `.zshhelpers`.


## Local
To ensure the dotfiles are sourced correctly, clone this repo __into your home directoy__ and run the following command:

~~~sh
cd $HOME && ln -s -f dotfiles/dotfiles/.* ./
~~~

This will symlink all of the dotfiles into your home directory.


## Remote
I wrote an [Ansible role](https://github.com/kylebebak/ansible-tmux) for deploying a tricked out version of `tmux` to Linux boxes running Ubuntu. It's worth a look.


## ZLE and iTerm
ZLE, the __zsh line editor__, is very cool, and [this post](http://sgeb.io/posts/2014/04/zsh-zle-custom-widgets/) explains how to get the most out of it. If you use `zsh` it's worth a read.

To define some keyboard input as a shortcut for invoking a ZLE widget, it helps to know what __escape sequence__ is sent by a given keyboard input. To find out, use `od -c`. `od` is the BSD __octal, decimal, hex, ASCII dump__. Run it, and try pressing one of the following key combinations:

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

If one of these combinations doesn't send anything, you can use always use iTerm2 to have it send any escape sequence you like. Go to __Preferences > Profiles > Keys__, choose a key combo, and instruct it to __Send Escape Sequence__.

Then you can edit your `.zshrc` file to catch this escape sequence, and have it invoke a widget. Check out how I've done this in `/dotfiles/.zshhelpers/zle.sh`.


## Helpers
The most interesting ones use [pick](https://github.com/thoughtbot/pick) to create `git` utilify functions that leverage fuzzy select.


- `gbp [command]`: Pick a branch and pass it to `command` (`gbp git checkout`, `gbp git merge`, etc). If command is not passed, pick and copy branch name.
- `gbpf [-s]`: Pick a branch, pick a modified file from this branch, and diff it. If `-s` is passed, invoke `git show` on the file.

- `ghp [command]`: Pick a past commit and pass it to `command`. If command is not passed, pick and copy commit hash.
- `ghpf [-s]`: Pick a commit, pick a modified file from this commit, and diff it. If `-s` is passed, invoke `git show` on the file.

- `gbc [-b]`: Pick a branch and find out how far ahead or behind (number of commits) it is compared with current branch. If `-b` is passed, pick both branches.
- `gbca [-b]`: Like `gbc`, but shows names and hashes of commits.

- `gpf [-c] [-s]`: Pick any file from index, then find all commits for this file. [-c]opy file path, or pick a commit and diff or [-s]how file.


## Node Modules
~~~sh
npm install -g markdown-html
npm install -g react-native-cli
npm install -g eslint
npm install -g eslint-plugin-react
npm install -g underscore-node
npm install -g moment
npm install -g json-server
npm install -g faucet
npm install -g babel-eslint
npm install -g rnpm
~~~
