# Dotfiles

My dotfiles. The ones worth looking at are `.tmux.conf`, `.bash_profile` and the ones in `.helpers`.

## Local

To ensure the dotfiles are sourced correctly, clone this repo __into your home directoy__ and run the following command:

~~~sh
cd $HOME && ln -s -f dotfiles/dotfiles/.* ./
~~~

This will symlink all of the dotfiles into your home directory.


## Remote

I wrote an [Ansible role](https://github.com/kylebebak/ansible-tmux) for deploying a tricked out version of `tmux` to Linux boxes running Ubuntu. It's worth a look.


## Helpers

The most interesting ones use [pick](https://github.com/thoughtbot/pick) to create `git` utilify functions that leverage fuzzy select.


- `gbp [command]`: Pick a branch and pass it to `command` (`gbp git checkout`, `gbp git merge`, etc). If command is not passed, pick and copy branch name.
- `gbpf [-s]`: Pick a branch, pick a modified file from this branch, and diff it. If `-s` is passed, invoke `git show` on the file.

- `ghp [command]`: Pick a past commit and pass it to `command`. If command is not passed, pick and copy commit hash.
- `ghpf [-s]`: Pick a commit, pick a modified file from this commit, and diff it. If `-s` is passed, invoke `git show` on the file.

- `gbc [-b]`: Pick a branch and find out how far ahead or behind (number of commits) it is compared with current branch. If `-b` is passed, pick both branches.
- `gbca [-b]`: Like `gbc`, but shows names and hashes of commits.
