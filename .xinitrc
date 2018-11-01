#!/bin/bash
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xmodmap $HOME/.Xmodmap
setxkbmap -option ctrl:nocaps,grp:switch,grp_led:scroll us,se
alacritty -e tmux attach -t0 &
exec $HOME/bin/dwm
