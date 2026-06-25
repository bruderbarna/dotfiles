#!/bin/bash

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

_warn_missing() { echo "WARNING: $1 is not installed" >&2; }

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
alias tf="terraform"

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

export FLYCTL_INSTALL="/home/barna/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="/home/barna/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# fnm
if command -v fnm &>/dev/null; then
  eval "$(fnm env --use-on-cd --shell bash)"
else
  _warn_missing fnm
fi

# direnv
if command -v direnv &>/dev/null; then
  eval "$(direnv hook bash)"
else
  _warn_missing direnv
fi

# fzf
if command -v fzf &>/dev/null; then
  source /usr/share/fzf/key-bindings.bash 2>/dev/null || true
  source /usr/share/fzf/completion.bash 2>/dev/null || true
else
  _warn_missing fzf
fi

# ----------------------------
# Completions
# ----------------------------

if command -v kubectl &>/dev/null; then
  source <(kubectl completion bash)
  complete -F _complete_alias k
fi

if command -v terraform &>/dev/null; then
  complete -C terraform terraform
  complete -F _complete_alias tf
fi

if command -v flyctl &>/dev/null; then
  source <(flyctl completion bash)
  complete -F __start_flyctl fly
fi

complete -F _complete_alias d

[[ -f ~/.secrets ]] && source ~/.secrets

export DOCKER_BUILDKIT=1
