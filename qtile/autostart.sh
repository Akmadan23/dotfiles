#!/bin/sh

dunst &					# notification manager
picom -f & 				# compositor
nm-applet &				# network manager
flameshot &				# screenshot tool
parcellite &			# clipboard manager
blueman-applet &		# bluetooth manager

xss-lock -l -- i3lock-fancy &
kill -9 $(pidof /bin/sh /home/azadahmadi/.config/scripts/battery-check.sh)
~/.config/scripts/battery-check.sh &	# handmade power management script
feh --bg-scale ~/.config/qtile/images/wallpaper.jpg
