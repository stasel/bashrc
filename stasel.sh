#!/bin/sh

###################################
#          Common Unix            #
###################################
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# unix shortcuts
alias ll="ls -lahG"
alias c="clear"
alias h='cd'
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias snano="sudo nano"
alias p="ping 1.1.1.1"

# git shortcuts
alias st="git status"
alias ck="git checkout"
alias br="git branch"
alias cm="git commit"
alias lg="git log"
alias pu="git push"

function cheat() {
    curl cht.sh/$1
}

function myip() {
    local localIP=$(ifconfig | grep broadcast | sed -E 's/^[^0-9]+([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}).+$/\1/g')
    echo -e "Local IP\t ${localIP:-N/A}"
    local remoteIP=$(curl -sLf --max-time 5 ipconfig.me/ip || echo "N/A")
    echo -e "Remote IP\t ${remoteIP}"
}

alias btc="curl -sL https://api.coindesk.com/v1/bpi/currentprice/BTC.json | python -c \"import sys, json; price = json.load(sys.stdin)['bpi']['USD']['rate_float']; print '1 BTC = {0:.0f} USD'.format(price)\""
alias updaterc="bash <(curl -sSL https://raw.githubusercontent.com/stasel/bashrc/master/install.sh) && source ~/.stasel.sh"

###################################
#            macOS                #
###################################
if [ -x "$(command -v say)" ]; then
    function spell() {
        local word=$(echo $1 | sed 's/./&. /g')
        say $word -r 150
    }
fi

if [ -x "$(command -v mDNSResponder)" ]; then
    alias flush-dns="sudo killall -HUP mDNSResponder && echo 'Flushed DNS'"
fi

if [[ "$OSTYPE" == "darwin"*  ]]; then
    function x() {
        local xcworkspace=$(find . -iregex '.*\.xcworkspace' -maxdepth 1 -print -quit)
        echo ${xcworkspace}
        open ${xcworkspace}
    }
fi

###################################
#            Linux                #
###################################
if [ -x "$(command -v systemd-resolve)" ]; then
    alias flush-dns="sudo systemd-resolve --flush-caches && echo 'Flushed DNS'"
fi

if [ -x "$(command -v apt)" ]; then
    alias up="sudo apt update && sudo apt upgrade -y"
fi

if [ -x "$(command -v x11vnc)" ]; then
    function vnc() {
        x11vnc -display :0 -noxrecord -noxfixes -noxdamage -forever -passwd $1 -rfbport 5900
    }
fi

###################################
#         Raspberry pi            #
###################################
if [ -f /opt/vc/bin/vcgencmd ]; then
	alias pitemp="while true; do /opt/vc/bin/vcgencmd measure_temp; sleep 1; done"
fi
