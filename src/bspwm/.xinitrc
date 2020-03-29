xrdb -merge ~/.Xresources

xset r rate 190 50

compton -b &
sxhkd &
nitrogen --restore &
exec bspwm

