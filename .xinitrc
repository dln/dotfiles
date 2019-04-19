#!/bin/bash
xsetroot -solid \#99aab0
xmodmap $HOME/.Xmodmap
setxkbmap -option ctrl:nocaps,grp:switch,grp_led:scroll us,se
alacritty -e tmux attach -t0 &
xcalib $HOME/.config/B140QAN02_0.icm
exec $HOME/bin/dwm
