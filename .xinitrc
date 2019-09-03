#!/bin/bash
xsetroot -solid \#99aab0 -cursor_name left_ptr
xmodmap $HOME/.Xmodmap
#compton --daemon -c -t -25 -l -25 --shadow-radius=25 --inactive-opacity 0.99 --inactive-dim 0.2 -e 0.7
setxkbmap -option ctrl:nocaps,grp:switch,grp_led:scroll us,se
xcalib $HOME/.config/B140QAN02_0.icm
alacritty -e tmux attach -t0 &
xrdb $HOME/.Xresources
hsetroot -solid \#99aab0
#exec $HOME/bin/2bwm
exec $HOME/bin/dwm
