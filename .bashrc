# sensible bash
if [ -f ~/bin/sensible.bash ]; then
    source ~/bin/sensible.bash
fi

# git completion
if [ -f ~/bin/git-completion.bash ]; then
    source ~/bin/git-completion.bash
fi

# basic aliases
alias ls="ls --color=auto"
alias l="ls"
alias ll="ls -la"
alias sl="ls"
alias cd..="cd .."
alias ..="cd .."
alias mkdir="mkdir -p"
alias xo="xdg-open"
alias taskg="sh -c 'cd && taskell'"
alias wtr="curl v2.wttr.in/Pecs"

function find-large-files {
    find $1 -xdev -type f -size +100M  -exec du -h {} \;
}

function psgrep() {
    ps axuf | grep -v grep | grep "$@" -i --color=auto;
}

function get-ip() {
    ip route get "$(ip route show to 0/0 | grep -oP '(?<=via )\S+')" | grep -oP '(?<=src )\S+'
}

function ss() {
  sh -c '\
    cd /home/barna/work/flexbox/flexbox-warehouse-api && \
    AWS_PROFILE=dev IS_LOCAL=true /home/barna/work/flexbox/flexbox-warehouse-api/startServer'
}

# Git prompt
GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_THEME=Single_line_Minimalist
GIT_PROMPT_SHOW_UNTRACKED_FILES=no
source ~/dotfiles/bashgitprompt/gitprompt.sh

# Environment variables
export PATH=$PATH:$HOME/bin
# export CHROME_BIN="/usr/bin/chromium-browser"
export EDITOR=vim
export VISUAL=vim
# export BROWSER="$CHROME_BIN"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk/"
export CAPACITOR_ANDROID_STUDIO_PATH="/opt/android-studio/bin/studio.sh"

# export CDPATH=.:/home/barna/work
# export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig
export ANDROID_HOME=/home/barna/Android/Sdk

# load nvm & setup it's path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # load nvm bash_completion

# android
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT
# avdmanager, sdkmanager
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
# adb, logcat
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
# emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
