#!/bin/bash

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# sensible bash
if [ -f ~/bin/sensible.bash ]; then
	source ~/bin/sensible.bash
fi

source /usr/share/bash-completion/bash_completion

# basic aliases
alias ls="ls --color=auto"
alias l="ls"
alias ll="ls -lah"
alias sl="ls"
alias cd..="cd .."
alias ..="cd .."
alias xo="xdg-open"
alias k="kubectl"

# alias mpv="mpv --sub-paths=\"Subs\""

# Git prompt
export GIT_PROMPT_ONLY_IN_REPO=0
export GIT_PROMPT_THEME=Single_line_Minimalist
export GIT_PROMPT_SHOW_UNTRACKED_FILES=no
source $HOME/dotfiles/bashgitprompt/gitprompt.sh

# Environment variables
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/dotfiles/scripts
export PATH=$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:/opt/android-sdk/platform-tools
export PATH=$PATH:/opt/android-sdk/tools
export PATH=$PATH:/opt/android-sdk/cmdline-tools/latest/bin
export CHROME_BIN="/usr/bin/google-chrome-stable"
export BROWSER="$CHROME_BIN"
export EDITOR=vim
export VISUAL=vim
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig

export ANDROID_HOME=/opt/android-sdk

if [ -f ~/.fzf.bash ]; then
	source ~/.fzf.bash
fi

source /home/barna/.config/op/plugins.sh

# load nvm & setup it's path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # load nvm bash_completion
