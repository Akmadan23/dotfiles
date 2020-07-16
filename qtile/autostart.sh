#!/bin/sh
feh --bg-scale ~/.config/qtile/wallpaper.jpg
picom -f &
xrandr | grep HDMI-1 > ~/.config/qtile/temp.txt
