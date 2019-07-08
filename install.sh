#!/bin/sh

function addSourceIfNeeded() {
    local rcpath=$1
    if [ -f $rcpath ] && ! grep -q 'source .stasel.sh' $rcpath ; then 
        echo $'\n# stasel additions\nsource .stasel.sh\n' >> $rcpath
        echo "Installed aliases to $rcpath"
    fi
}

addSourceIfNeeded "$HOME/.zshrc"
addSourceIfNeeded "$HOME/.bashrc"

curl -SsL https://raw.githubusercontent.com/stasel/bashrc/master/stasel.sh > ~/.stasel.sh
echo "Done. Use the following command to apply the changes now"
echo "  source ~/.stasel.sh"
