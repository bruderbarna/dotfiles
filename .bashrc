# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias ll="ls --color=auto -la"
alias cd..="cd .."
alias ..="cd .."

export GOPATH=$HOME/go

GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_THEME=Single_line_Minimalist
source ~/dotfiles/bashgitprompt/gitprompt.sh

