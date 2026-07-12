# ----------------------------
# Completion
# ----------------------------

autoload -U +X bashcompinit && bashcompinit

# --- docker ---
docker_installed=false
command -v docker >/dev/null 2>&1 && docker_installed=true

if $docker_installed; then
  if [ ! -f "$HOME/.docker/completions/_docker" ]; then
    if [ ! -f "$HOME/.docker/completions" ]; then
      mkdir -p "$HOME/.docker/completions"
    fi
    docker completion zsh > "$HOME/.docker/completions/_docker"
  fi
  FPATH="$HOME/.docker/completions:$FPATH"
fi

# --- kubectl ---
kubectl_installed=false
command -v kubectl >/dev/null 2>&1 && kubectl_installed=true

if $kubectl_installed; then
  # kubectl completion supports "zsh"
  if [ ! -f "$HOME/.kubectl/completions/_kubectl" ]; then
    if [ ! -f "$HOME/.kubectl/completions" ]; then
      mkdir -p "$HOME/.kubectl/completions"
    fi
    kubectl completion zsh > "$HOME/.kubectl/completions/_kubectl"
  fi
  FPATH="$HOME/.kubectl/completions:$FPATH"
fi

# --- terraform ---
terraform_installed=false
command -v terraform >/dev/null 2>&1 && terraform_installed=true

if $terraform_installed; then
  if [ ! -f "$HOME/.terraform/completions/_terraform" ]; then
    if [ ! -f "$HOME/.terraform/completions" ]; then
      mkdir -p "$HOME/.terraform/completions"
    fi
    terraform completion zsh > "$HOME/.terraform/completions/_terraform"
  fi
  FPATH="$HOME/.terraform/completions:$FPATH"
fi

# --- init zsh completion ---
autoload -Uz compinit
compinit

# --- compdefs ---
if $docker_installed; then
  compdef d=docker
fi
if $kubectl_installed; then
  compdef k=kubectl
fi
# tf compdef already set above, but keeping it here is harmless:
if $terraform_installed; then
  compdef tf=terraform
fi

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

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"          ]] && bindkey -- "${key[Home]}"          beginning-of-line
[[ -n "${key[End]}"           ]] && bindkey -- "${key[End]}"           end-of-line
[[ -n "${key[Insert]}"        ]] && bindkey -- "${key[Insert]}"        overwrite-mode
[[ -n "${key[Backspace]}"     ]] && bindkey -- "${key[Backspace]}"     backward-delete-char
[[ -n "${key[Delete]}"        ]] && bindkey -- "${key[Delete]}"        delete-char
[[ -n "${key[Up]}"            ]] && bindkey -- "${key[Up]}"            up-line-or-history
[[ -n "${key[Down]}"          ]] && bindkey -- "${key[Down]}"          down-line-or-history
[[ -n "${key[Left]}"          ]] && bindkey -- "${key[Left]}"          backward-char
[[ -n "${key[Right]}"         ]] && bindkey -- "${key[Right]}"         forward-char
[[ -n "${key[PageUp]}"        ]] && bindkey -- "${key[PageUp]}"        beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"      ]] && bindkey -- "${key[PageDown]}"      end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}"     ]] && bindkey -- "${key[Shift-Tab]}"     reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

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
  "$HOME/go/bin"

  $path
)

export PATH

# ----------------------------
# Build tool wrappers
# ----------------------------

mvn() {
  if [[ -x ./mvnw ]]; then
    ./mvnw "$@"
  else
    printf '\033[1;33m\n  ⚠  WARNING: no ./mvnw — using global mvn\n\033[0m' >&2
    command mvn "$@"
  fi
}

gradle() {
  if [[ -x ./gradlew ]]; then
    ./gradlew "$@"
  else
    printf '\033[1;33m\n  ⚠  WARNING: no ./gradlew — using global gradle\n\033[0m' >&2
    command gradle "$@"
  fi
}

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
alias vim='nvim'

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

# setopt PROMPT_SUBST

# ZSH_THEME_GIT_PROMPT_PREFIX=" ["
# ZSH_THEME_GIT_PROMPT_SUFFIX="]"
# ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
# ZSH_THEME_GIT_PROMPT_BRANCH="%F{cyan}"
# ZSH_THEME_GIT_PROMPT_STAGED="%F{red}●%f"
# ZSH_THEME_GIT_PROMPT_CONFLICTS="%F{red}✖%f"
# ZSH_THEME_GIT_PROMPT_CHANGED="%F{blue}✚%f"
# ZSH_THEME_GIT_PROMPT_BEHIND="%F{cyan}↓%f"
# ZSH_THEME_GIT_PROMPT_AHEAD="%F{cyan}↑%f"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{cyan}…%f"
# ZSH_THEME_GIT_PROMPT_STASHED="%F{blue}⚑%f"
# ZSH_THEME_GIT_PROMPT_CLEAN="%F{green}✔%f"

ZSH_GIT_PROMPT_SHOW_STASH=1

PROMPT='%(?:%F{green}✔%f:%F{red}✘%f) %F{white}%D{%H:%M:%S}%f %F{cyan}%~%f $(gitprompt)%# '

# ----------------------------
# fnm
# ----------------------------

if command -v fnm &>/dev/null; then
  eval "$(fnm env --use-on-cd --shell zsh)"
else
  _warn_missing fnm
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
# Secrets
# ----------------------------

[[ -f ~/.secrets ]] && source ~/.secrets

# ----------------------------
# Sdkman init
# ----------------------------

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# ----------------------------
# Sdkman init
# ----------------------------

export CLOUDSMITH_REPOSITORY=114-aiis_general-d

# ----------------------------
# Homebrew
# ----------------------------

# export HOMEBREW_PREFIX=~/.local/Homebrew


# ----------------------------
# fnm
# ----------------------------

export PATH="/Users/barna.bruder/.local/state/fnm_multishells/24880_1783519281633/bin":$PATH
export FNM_MULTISHELL_PATH="/Users/barna.bruder/.local/state/fnm_multishells/24880_1783519281633"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_DIR="/Users/barna.bruder/.local/share/fnm"
export FNM_LOGLEVEL="info"
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_COREPACK_ENABLED="false"
export FNM_RESOLVE_ENGINES="true"
export FNM_ARCH="arm64"
rehash

# ----------------------------
# tmux url select
# ----------------------------

export TMUX_URL_SELECT_CLIP_CMD=pbcopy
export TMUX_URL_SELECT_OPEN_CMD=open
