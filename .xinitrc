#!/bin/bash
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

. $HOME/.bashrc
xsetroot -solid \#202020
xmodmap $HOME/.Xmodmap
feh --bg-fill $HOME/Images/desktop.jpg || true
setxkbmap -option ctrl:nocaps,grp:switch,grp_led:scroll us,se
st tmux attach -t0 &
exec dwm
