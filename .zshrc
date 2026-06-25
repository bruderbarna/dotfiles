# ----------------------------
# Completion
# ----------------------------

autoload -Uz compinit
compinit

zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' max-errors 2 not-numeric
zstyle ':completion:*' menu select

# ----------------------------
# History
# ----------------------------

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=200000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

bindkey -e

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
# fnm
# ----------------------------

eval "$(fnm env --use-on-cd --shell zsh)"

# ----------------------------
# direnv
# ----------------------------

eval "$(direnv hook zsh)"

# ----------------------------
# fzf
# ----------------------------

if ! command -v fzf &>/dev/null; then
  echo "WARNING: fzf is not installed" >&2
else
  if [[ "$OS" == "Darwin" ]]; then
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" 2>/dev/null || true
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2>/dev/null || true
  else
    source /usr/share/fzf/key-bindings.zsh 2>/dev/null || true
    source /usr/share/fzf/completion.zsh 2>/dev/null || true
  fi
fi

# ----------------------------
# Completions
# ----------------------------

command -v kubectl >/dev/null && source <(kubectl completion zsh)
command -v terraform >/dev/null && complete -o nospace -C terraform terraform
command -v flyctl >/dev/null && source <(flyctl completion zsh)

# ----------------------------
# Secrets
# ----------------------------

[[ -f ~/.secrets ]] && source ~/.secrets
