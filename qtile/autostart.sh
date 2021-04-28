#!/bin/sh

dunst &					# notification manager
lxpolkit & 				# simple policykit authentication agent
picom -f & 				# compositor
nm-applet &				# network manager
flameshot &				# screenshot tool
parcellite &			# clipboard manager
blueman-applet &		# bluetooth manager

xss-lock -l -- i3lock-fancy &
xwallpaper --zoom ~/.config/qtile/background.jpg

# handmade power management script
kill -9 $(pidof -s /bin/bash /home/azadahmadi/.config/scripts/battery-check)
~/.config/scripts/battery-check &

# xob volume bar
# killall xob
# kill -9 $(pidof -s python3 /home/azadahmadi/.config/xob/pulse-volume-watcher.py)
# ~/.config/xob/pulse-volume-watcher.py | xob -s default -t 2000 &
