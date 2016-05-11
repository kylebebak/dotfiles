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
