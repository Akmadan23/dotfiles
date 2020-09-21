#!/bin/sh

if [ -z $(xrandr | grep "HDMI-1 disconnected") ]; then
	echo connected > ~/.config/qtile/.hdmi.txt
	xrandr --output eDP-1 --mode 1600x900 --pos 0x0 --rotate normal --output HDMI-1 --primary --mode 1920x1080 --pos 1600x0 --rotate normal
	# xrandr --output eDP-1 --mode 1600x900 --pos 0x0 --rotate normal --output HDMI-1 --primary --mode 1360x768 --pos 1600x0 --rotate normal
else
	echo disconnected > ~/.config/qtile/.hdmi.txt
	xrandr --output eDP-1 --mode 1600x900 --rotate normal --output HDMI-1 --off
fi
