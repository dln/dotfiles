#!/bin/bash
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

. $HOME/.bashrc
xsetroot -solid \#78909C
xmodmap $HOME/.Xmodmap
feh --bg-fill $HOME/Images/desktop.jpg || true
setxkbmap -option ctrl:nocaps,grp:switch,grp_led:scroll us,se
exec dwm
