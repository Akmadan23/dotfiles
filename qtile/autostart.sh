#!/bin/sh

conky &                 # conky widgets
dunst &					# notification manager
picom -f & 				# compositor
lxpolkit & 				# simple policykit authentication agent
nm-applet &				# network manager
flameshot &				# screenshot tool
parcellite &			# clipboard manager
blueman-applet &		# bluetooth manager

xss-lock &
# xss-lock -l -- i3lock-fancy &
xwallpaper --zoom ~/.config/qtile/background.jpg

# handmade power management script
kill -9 "$(pidof -s /bin/sh \"$HOME\"/git-repos/scripts/battery-check)"
"$SCRIPTS"/battery-check &

# xob volume bar
killall xob
"$HOME"/.config/xob/pulse-volume-watcher.py | xob -s default -t 2000 &
