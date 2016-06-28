# Dotfiles

My dotfiles. The ones worth looking at are `.tmux.conf`, `.bash_profile` and `.custom_functions`.

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


`gbp <command>`: Pick a branch and pass it to `command` (`gbp git checkout`, `gbp git merge`, ...)
`gbpf`: Pick a branch, pick a modified file from this branch, and diff it

`ghp <command>`: Pick a past commit and pass it to `command`
`ghpf`: Pick a past commit, pick a modified file from this commit, and diff it

`gbc <optional_arg>`: Pick a branch and find out how far ahead or behind (number of commits) it is compared with current branch. If __any__ optional_arg is passed, pick both branches
`gbca <optional_arg>`: Like `gbc`, but shows names and hashes of commits

`gdp`: Pick a file that has been modified since the last commit, and diff it
