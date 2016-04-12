# Dotfiles

My dotfiles. The ones worth looking at are `.tmux.conf`, `.bash_profile` and `.custom_functions`.

## Local

To ensure the dotfiles are sourced correctly, clone this repo __into your home directoy__ and run the following command:

~~~sh
cd $HOME && ln -s -f dotfiles/dotfiles/.* ./
~~~

This will symlink all of the dotfiles into your home directory.


## Remote

There is also a small Ansible playbook for configuring `tmux` on machines where `bash` is the login shell. The playbook will deploy `.tmux.conf` to the user's home directory on all of the machines in the inventory, and ensure that `tmux` can share history between sessions.

Simply run this playbook with `ansible-playbook` and pass an inventory and a `user` with ssh access to the remotes. The user doesn't need `sudo` privileges, because he only modifies files in his home directory.

~~~sh
ansible-playbook -u {user} -i {inventory} playbooks/tmux.yml
# or, specifying the hosts without an inventory file
# the list of hosts must be terminated with a comma!
ansible-playbook -u {user} -i "{host_a},{host_b}," playbooks/tmux.yml
~~~

