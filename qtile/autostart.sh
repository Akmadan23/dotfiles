#!/bin/sh

dunst &					# notification manager
picom -f &				# compositor
nm-applet &				# network manager
flameshot &				# screenshot tool
parcellite &			# clipboard manager
volumeicon &			# volume icon tool
blueman-applet &		# bluetooth manager

xss-lock -l -- lock-script &
./$(~/.config/scripts/battery-check.sh) & # handmade power management script
feh --bg-scale ~/.config/qtile/images/wallpaper.jpg
