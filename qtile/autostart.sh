#!/bin/sh
picom -f &
nm-applet &
feh --bg-scale ~/.config/qtile/images/wallpaper.jpg
xrandr | grep HDMI-1 > ~/.config/qtile/temp.txt
