# ----------------------------
# Completion
# ----------------------------

autoload -Uz compinit
compinit

zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' max-errors 2 not-numeric
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

# ----------------------------
# History
# ----------------------------

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=200000

# ----------------------------
# Opts
# ----------------------------

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

# ----------------------------
# Keybinds
# ----------------------------

bindkey -e

[[ -n ${terminfo[khome]} ]] && bindkey "${terminfo[khome]}" beginning-of-line
[[ -n ${terminfo[kend]}  ]] && bindkey "${terminfo[kend]}"  end-of-line
[[ -n ${terminfo[kdelete]}  ]] && bindkey "${terminfo[kdelete]}"  delete-char

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[3~' delete-char

# ----------------------------
# OS
# ----------------------------

OS="$(uname -s)"

# ----------------------------
# Helpers
# ----------------------------

_warn_missing() { echo "WARNING: $1 is not installed" >&2 }

# ----------------------------
# PATH
# ----------------------------

typeset -U path PATH

path=(
  "$HOME/bin"
  "$HOME/go/bin"
  "$HOME/dotfiles/scripts"
  "$HOME/.local/bin"
  "$HOME/.local/share/gem/ruby/3.0.0/bin"
  "$HOME/.fly/bin"
  "$HOME/.local/share/pnpm"
  $path
)

export PATH

# ----------------------------
# Aliases
# ----------------------------

alias ls='ls --color=auto'
alias l='ls'
alias ll='ls -lah'
alias sl='ls'
alias cd..='cd ..'
alias ..='cd ..'
alias k='kubectl'
alias d='docker'
alias tf='terraform'

if [[ "$OS" == "Darwin" ]]; then
  alias xo='open'
  alias htop='open -a Neohtop'
else
  alias xo='xdg-open'
fi

# ----------------------------
# Environment
# ----------------------------

export CLAUDE_CODE_TMUX_TRUECOLOR=1
export DOCKER_BUILDKIT=1

export EDITOR=vim
export VISUAL=vim

export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_HOME="$ANDROID_HOME"

path+=("$ANDROID_HOME/platform-tools")

export FLYCTL_INSTALL="$HOME/.fly"

if [[ "$OS" == "Darwin" ]]; then
  [[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

  export JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null)"
  export CHROME_BIN="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
else
  export JAVA_HOME="/usr/lib/jvm/default"
  export PKG_CONFIG_PATH="/usr/lib/x86_64-linux-gnu/pkgconfig"
  export CHROME_BIN="/usr/bin/google-chrome-stable"
fi

export BROWSER="$CHROME_BIN"

# ----------------------------
# Cargo
# ----------------------------

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# ----------------------------
# antidote
# ----------------------------

if [[ "$OS" == "Darwin" ]]; then
  _antidote_path="$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"
else
  _antidote_path="/usr/share/zsh-antidote/antidote.zsh"
fi

if [[ -f "$_antidote_path" ]]; then
  source "$_antidote_path"
  antidote load ~/.zsh_plugins.txt
else
  _warn_missing antidote
fi
unset _antidote_path

# ----------------------------
# Prompt
# ----------------------------

setopt PROMPT_SUBST

ZSH_THEME_GIT_PROMPT_PREFIX=" ["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_BRANCH="%F{cyan}"
ZSH_THEME_GIT_PROMPT_STAGED="%F{red}●%f"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%F{red}✖%f"
ZSH_THEME_GIT_PROMPT_CHANGED="%F{blue}✚%f"
ZSH_THEME_GIT_PROMPT_BEHIND="%F{cyan}↓%f"
ZSH_THEME_GIT_PROMPT_AHEAD="%F{cyan}↑%f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{cyan}…%f"
ZSH_THEME_GIT_PROMPT_STASHED="%F{blue}⚑%f"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{green}✔%f"

PROMPT='%(?:%F{green}✔%f:%F{red}✘%f) %F{white}%D{%H:%M:%S}%f %F{cyan}%~%f$(gitprompt) %# '

# ----------------------------
# fnm
# ----------------------------

if command -v fnm &>/dev/null; then
  eval "$(fnm env --use-on-cd --shell zsh)"
else
  _warn_missing fnm
fi

# ----------------------------
# direnv
# ----------------------------

if command -v direnv &>/dev/null; then
  eval "$(direnv hook zsh)"
else
  _warn_missing direnv
fi

# ----------------------------
# fzf
# ----------------------------

if command -v fzf &>/dev/null; then
  if [[ "$OS" == "Darwin" ]]; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" 2>/dev/null || true
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2>/dev/null || true
  else
    source /usr/share/fzf/key-bindings.zsh 2>/dev/null || true
    source /usr/share/fzf/completion.zsh 2>/dev/null || true
  fi
else
  _warn_missing fzf
fi

# ----------------------------
# Completions
# ----------------------------

autoload -U +X bashcompinit && bashcompinit

if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
  compdef k=kubectl
fi

if command -v terraform &>/dev/null; then
  complete -o nospace -C terraform terraform
  compdef tf=terraform
fi

if command -v flyctl &>/dev/null; then
  source <(flyctl completion zsh)
fi

compdef d=docker

# ----------------------------
# Secrets
# ----------------------------

[[ -f ~/.secrets ]] && source ~/.secrets
