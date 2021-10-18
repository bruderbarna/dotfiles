#!/bin/bash

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# sensible bash
if [ -f ~/bin/sensible.bash ]; then
    source ~/bin/sensible.bash
fi

source ~/.onrivaenv.sh
source /usr/share/bash-completion/bash_completion

# basic aliases
alias ls="ls --color=auto"
alias l="ls"
alias ll="ls -lah"
alias sl="ls"
alias cd..="cd .."
alias ..="cd .."
alias mkdir="mkdir -p"
alias xo="xdg-open"
alias mutt="neomutt"
alias taskg="sh -c 'cd && taskell'"
alias wtr="curl v2.wttr.in/Pecs"

# onriva aliases
alias ob="cd ~/work/onvoya-business/ && HOME="$WORK" mvn install -Denv=local -Dmaven.test.skip -Dmaven.javadoc.skip -DskipTests=true && cd -"
alias ocb="cd ~/work/onvoya-business/ && HOME="$WORK" mvn clean install -Denv=local -Dmaven.test.skip -Dmaven.javadoc.skip -DskipTests=true && cd -"
alias is="HOME="$WORK" $IGNITE_HOME/bin/ignite1.sh $IGNITE_HOME/onvoya/config/startup.xml"
alias ol="tail -f $LOCAL_ONVOYA_APP_FOLDER_PATH/tomcat-7.0.62/logs/catalina.out"
ostart () {
  sed -i '/^\(ehcache\|cluster\|web\.server\.display\.node\|lucene\|net\)/d' "$LOCAL_ONVOYA_APP_FOLDER_PATH"/portal-ext.properties
  sed -i 's/^index.on.startup=true$/index.on.startup=false/' "$LOCAL_ONVOYA_APP_FOLDER_PATH"/portal-ext.properties
  WORK="$WORK" sh -c 'HOME="$WORK"; "$LOCAL_ONVOYA_APP_FOLDER_PATH"/tomcat-7.0.62/bin/startup.sh'
  is
}
alias os="ostart"
ost() {
    ps aux | grep onvoya-dir | grep -v 'grep' | grep -v 'tail -f.*catalina' | awk '{print $2}' | xargs kill;
}
alias ros="ost; sleep 5 && os"
alias rcbos="ost; ocb && sleep 5 && os"
alias rbos="ost; ob && sleep 5 && os"
alias onv="cd ~/work/onvoya-business"
alias onvf="cd ~/work/onvoya-business/onvoya-portal/portlets/onriva-frontend"
alias sb="cd ~/work/onriva-sandbox"
rbf () {
  rm -rf "$LOCAL_ONVOYA_APP_FOLDER_PATH"/tomcat-7.0.62/webapps/onriva-frontend/css/*
  rm -rf "$LOCAL_ONVOYA_APP_FOLDER_PATH"/tomcat-7.0.62/webapps/onriva-frontend/js/*
  WORK="$WORK" sh -c 'cd /home/barna/work/onvoya-business/onvoya-portal/portlets/onriva-frontend && HOME="$WORK"; yarn start:mvn'
}

# vpn aliases
alias sonu="nmcli con up id sonrisa"
alias sond="nmcli con down id sonrisa"
alias homeu="nmcli con up id home"
alias homed="nmcli con down id home"

# docker
alias d="docker"
alias dp="docker ps"
alias dpa="docker ps -a"
alias ectl="docker exec -it videoconference-ejabberd-server /opt/ejabberd-18.01/bin/ejabberdctl"

alias mpv="mpv --sub-paths=\"Subs\""

# Functions
# function sonu() {
#     nmcli con up id sonrisa
#     declare -a services=("sontime" "redmine" "discourse" "jenkins")
#     for service in "${services[@]}"; do
#         for i in $(dig +short $service.int.sonrisa.hu | sed '1d'); do
#             sudo ip route add "${i}" via 10.8.0.1 dev tun0;
#         done;
#     done
# }

function find-large-files {
    find $1 -xdev -type f -size +100M  -exec du -h {} \;
}

function psgrep() {
    ps axuf | grep -v grep | grep "$@" -i --color=auto;
}

function get-ip() {
    ip route get "$(ip route show to 0/0 | head -n 1 | grep -oP '(?<=via )\S+')" | grep -oP '(?<=src )\S+'
}

# Git prompt
GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_THEME=Single_line_Minimalist
GIT_PROMPT_SHOW_UNTRACKED_FILES=no
source ~/dotfiles/bashgitprompt/gitprompt.sh

# Environment variables
export PATH=$PATH:$HOME/bin
export CHROME_BIN="/usr/bin/google-chrome-stable"
export EDITOR=vim
export VISUAL=vim
export BROWSER="$CHROME_BIN"
export JAVA_HOME="/opt/openjdk-8u252-b09/"
export CDPATH=.:/home/barna/work
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig

# load nvm & setup it's path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # load nvm bash_completion

if [ -f ~/.fzf.bash ]; then
  source ~/.fzf.bash
fi

export WINEARCH=win32
export WINEPREFIX=~/.wine32

