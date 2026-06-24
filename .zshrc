
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' max-errors 2 not-numeric
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -e

OS="$(uname -s)"

# --- aliases ---
alias ls="ls --color=auto"
alias l="ls"
alias ll="ls -lah"
alias sl="ls"
alias cd..="cd .."
alias ..="cd .."
alias k="kubectl"
alias d="docker"
alias tf="terraform"

if [[ "$OS" == "Darwin" ]]; then
  alias xo="open"
  alias htop="open -a Neohtop"   # opens neohtop GUI, returns shell immediately
else
  alias xo="xdg-open"
fi

# --- PATH ---
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/dotfiles/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# --- OS-specific ---
if [[ "$OS" == "Darwin" ]]; then
  [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="/opt/homebrew/opt/curl/bin:$PATH"   # brew curl over macOS system curl
  export JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null)"
  export CHROME_BIN="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
else
  export JAVA_HOME="/usr/lib/jvm/default"
  export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig
  export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH"
  export CHROME_BIN="/usr/bin/google-chrome-stable"
fi

export BROWSER="$CHROME_BIN"
export EDITOR=vim
export VISUAL=vim
export DOCKER_BUILDKIT=1
export CLAUDE_CODE_TMUX_TRUECOLOR=1

# Android SDK
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_HOME="$HOME/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# flyctl
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# Rust/Cargo
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# fnm (node version manager — respects .nvmrc / .node-version)
eval "$(fnm env --use-on-cd --shell zsh)"

# direnv
eval "$(direnv hook zsh)"

# fzf
if [[ "$OS" == "Darwin" ]]; then
  source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" 2>/dev/null || true
  source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2>/dev/null || true
else
  [[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
fi

# Git prompt
export GIT_PROMPT_ONLY_IN_REPO=0
export GIT_PROMPT_THEME=Single_line_Minimalist
export GIT_PROMPT_SHOW_UNTRACKED_FILES=no
source "$HOME/dotfiles/bashgitprompt/gitprompt.sh"

# secrets (API keys — keep out of dotfiles)
[[ -f ~/.secrets ]] && source ~/.secrets
