mkdir -p ~/.logs; touch ~/.logs/bspwm

eval $("ssh-agent")
/bin/ls ~/.ssh/id_rsa* | grep -v .pub | xargs -L1 ssh-add

bspwm >> $HOME/.logs/bspwm
