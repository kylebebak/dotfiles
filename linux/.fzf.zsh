# Setup fzf
# ---------

# wget http://mirrors.kernel.org/ubuntu/pool/universe/f/fzf/fzf_0.20.0-1_amd64.deb
# sudo dpkg -i fzf_0.20.0-1_amd64.deb

# mkdir ~/opt/fzf/shell
# cd ~/opt/fzf/shell
# wget https://raw.githubusercontent.com/junegunn/fzf/master/shell/completions.zsh
# wget https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${HOME}/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${HOME}/opt/fzf/shell/key-bindings.zsh"
