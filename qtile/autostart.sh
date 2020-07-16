#!/bin/sh
picom -f
feh --bg-scale ~/.config/qtile/wallpaper.jpg
xrandr | grep HDMI-1 > ~/.config/qtile/temp.txt
