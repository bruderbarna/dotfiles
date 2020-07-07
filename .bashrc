# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# sensible bash
if [ -f ~/bin/sensible.bash ]; then
    source ~/bin/sensible.bash
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
alias mutt="neomutt"
alias taskg="sh -c 'cd && taskell'"
alias wtr="curl v2.wttr.in/Pecs"

# quick navigation (cabi section)
alias cabi="cd ~/work/cabiofbiz/"
alias eh="cd ~/work/cabi-eventhub/"
alias mob="cd ~/work/cabiofbiz/mobile/"
alias tab="cd ~/work/cabiofbiz/tabletparty/"
alias lib="cd ~/work/cabiofbiz/lib/angular-components/"
alias sd="cd ~/work/cabiofbiz/vsstylistdashboard/"
alias rso="cd ~/work/cabionline/"
alias rsc="cd ~/work/cabionline/wordpress/wp-content/themes/cabi/"
alias rsa="cd ~/work/cabionline/wordpress/wp-content/themes/cabi/assets/js/ngApp/"
alias rsl="cd ~/work/cabionline/wordpress/wp-content/themes/cabi/assets/js/angular-components/"
alias cdo="cd ~/work/cabi-docker/"
alias cad="cd ~/work/cabi-docs/"
alias est="cd ~/work/cabi-docs/estimations/"

# cabi run/build aliases
alias gomob="mob && npm start"
alias gotab="tab && npm start"
alias gotablib="tab && npm run compile-components-dev"
alias goft="gotablib && gotab"
alias ol="docker logs -f --tail 5000 cabi-ofbiz"
alias rsol="docker stop cabi-ofbiz && cabi && docker start cabi-ofbiz && ol"
alias rol="docker stop cabi-ofbiz && cabi && ant build && docker start cabi-ofbiz && ol"
alias el="docker logs -f --tail 5000 cabi-eventhub"
alias rel="docker restart cabi-eventhub && el"
alias up="cdo && ./up.sh"
alias gosdlib="sd && npm run compile-components-dev"
alias mvsd="sd && npm run build-dev && cp -r dist/* ../hot-deploy/cabi/webapp/vsstylistdashboard/"
alias fsdb="gosdlib && mvsd"
alias wrs="rsc && (grunt & npm run watch-components & npm run watch)"
alias brslib="rsl && npm run build-dev"
alias brsnga="rsc && npm run build-dev"
alias brs="brslib && brsnga"
alias brsp="rsl && npm run build && rsc && npm run build"
alias otw="rsl && rm -rf src && cp -r ~/work/cabiofbiz/lib/angular-components/src ."
alias wto="cabi && cd lib/angular-components && rm -rf src && cp -r ~/work/cabionline/wordpress/wp-content/themes/cabi/assets/js/angular-components/src ."
alias dct="cabi && git checkout -- framework/base/config/ofbiz-containers.xml framework/common/config/general.properties framework/entity/config/entityengine.xml framework/webapp/config/url.properties hot-deploy/cabi/config/store.properties && cd - > /dev/null"

# vpn aliases
alias cabiu="nmcli con up id cabi"
alias cabid="nmcli con down id cabi"
alias sonu="nmcli con up id sonrisa"
alias sond="nmcli con down id sonrisa"
alias nkpu="nmcli con up id nkp"
alias nkpd="nmcli con down id nkp"
alias homeu="nmcli con up id home"
alias homed="nmcli con down id home"

# docker
alias d="docker"
alias dp="docker ps"
alias dpa="docker ps -a"
alias ectl="docker exec -it videoconference-ejabberd-server /opt/ejabberd-18.01/bin/ejabberdctl"

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

function dsm {
    nohup xdg-open "zoommtg://zoom.us/join?action=join&confno=8839829581" >& /dev/null &
}

function find-large-files {
    find $1 -xdev -type f -size +100M  -exec du -h {} \;
}

function psgrep() {
    ps axuf | grep -v grep | grep "$@" -i --color=auto;
}

function get-ip() {
    ip route get "$(ip route show to 0/0 | grep -oP '(?<=via )\S+')" | grep -oP '(?<=src )\S+'
}

# Git prompt
GIT_PROMPT_ONLY_IN_REPO=0
GIT_PROMPT_THEME=Single_line_Minimalist
GIT_PROMPT_SHOW_UNTRACKED_FILES=no
source ~/dotfiles/bashgitprompt/gitprompt.sh

# load git subrepo commands (https://github.com/ingydotnet/git-subrepo)
source /home/barna/bin/git-subrepo/.rc

# Environment variables
export PATH=$HOME/bin/go1.14:$PATH:$HOME/bin:$HOME/go/bin
export CHROME_BIN="/usr/bin/chromium-browser"
export EDITOR=vim
export BROWSER="$CHROME_BIN"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64/"
export CDPATH=.:/home/barna/work
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig

# load nvm & setup it's path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # load nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # load nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
