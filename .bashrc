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

if [ -f ~/.bash_completion.d/complete_alias ]; then
	source ~/.bash_completion.d/complete_alias
fi

HISTSIZE=100000
HISTFILESIZE=200000

export CLAUDE_CODE_TMUX_TRUECOLOR=1

# basic aliases
alias ls="ls --color=auto"
alias l="ls"
alias ll="ls -lah"
alias sl="ls"
alias cd..="cd .."
alias ..="cd .."
alias xo="xdg-open"
alias k="kubectl"
alias d="docker"
complete -F _complete_alias d
alias tf="terraform"
complete -F _complete_alias tf

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
export CHROME_BIN="/usr/bin/google-chrome-stable"
export BROWSER="$CHROME_BIN"
export EDITOR=vim
export VISUAL=vim
export JAVA_HOME="/usr/lib/jvm/default"
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_HOME="$HOME/Android/Sdk"
export PATH=$PATH:$ANDROID_HOME/platform-tools

if ! command -v fzf &>/dev/null; then
  echo "WARNING: fzf is not installed" >&2
else
  source /usr/share/fzf/key-bindings.bash 2>/dev/null || true
  source /usr/share/fzf/completion.bash 2>/dev/null || true
fi

export FLYCTL_INSTALL="/home/barna/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
complete -F __start_flyctl fly

eval "$(direnv hook bash)"

# complete -C /usr/bin/terraform terraform

# pnpm
export PNPM_HOME="/home/barna/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[[ -f ~/.secrets ]] && source ~/.secrets

export DOCKER_BUILDKIT=1

# fnm (node version manager)
eval "$(fnm env --use-on-cd --shell bash)"
