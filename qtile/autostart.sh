#!/bin/sh

dunst &					# notification manager
lxpolkit & 				# simple policykit authentication agent
picom -f & 				# compositor
nm-applet &				# network manager
flameshot &				# screenshot tool
parcellite &			# clipboard manager
blueman-applet &		# bluetooth manager

xss-lock -l -- i3lock-fancy &
xwallpaper --zoom ~/.config/qtile/images/wallpaper.jpg

# handmade power management script
kill -9 $(pidof -s /bin/bash /home/azadahmadi/.config/scripts/battery-check.sh)
~/.config/scripts/battery-check.sh &	

# xob volume bar
# killall xob
# kill -9 $(pidof -s python3 /home/azadahmadi/.config/xob/pulse-volume-watcher.py)
# ~/.config/xob/pulse-volume-watcher.py | xob -s default -t 2000 &

# Single/dual monitor detection
if [ -z $(xrandr | grep "HDMI-1 disconnected") ]; then
	echo connected > ~/.config/qtile/.hdmi.txt
	xrandr --output eDP-1 --mode 1600x900 --pos 0x0 --rotate normal --output HDMI-1 --primary --mode 1920x1080 --pos 1600x0 --rotate normal
	# xrandr --output eDP-1 --mode 1600x900 --pos 0x0 --rotate normal --output HDMI-1 --primary --mode 1360x768 --pos 1600x0 --rotate normal
else
	echo disconnected > ~/.config/qtile/.hdmi.txt
	xrandr --output eDP-1 --mode 1600x900 --rotate normal --output HDMI-1 --off
fi
