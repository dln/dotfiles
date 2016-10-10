#!/bin/bash
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

. $HOME/.bashrc

xsetroot -solid \#010101

xmodmap $DOTFILES/.Xmodmap
setxkbmap -option ctrl:nocaps,grp:switch,grp_led:scroll us,se

if [ "$HOSTNAME" = "dredd" ]; then 
  redshift -l 59.29:18.01 -t 5800:4500 &
  xautolock -time 3 -detectsleep -locker $DOTFILES/bin/lockscreen &
  (sleep 0.1 && xautolock -locknow) &
fi

st -e tmux attach -t 0 &

exec dwm
