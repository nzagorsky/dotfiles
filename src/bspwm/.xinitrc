mkdir -p ~/.cache/bspwm; touch ~/.cache/bspwm/log

eval $("ssh-agent")
/bin/ls ~/.ssh/id_rsa* | grep -v .pub | xargs -L1 ssh-add

bspwm >> $HOME/.cache/bspwm/log
