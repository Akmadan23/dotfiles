#!/bin/sh
picom -f &
nm-applet &
feh --bg-scale ~/.config/qtile/images/wallpaper.jpg
xrandr | grep HDMI-1 > ~/.config/qtile/.hdmi/temp.txt
xinput --set-prop "Synaptics tm2964-001" "libinput Natural Scrolling Enabled" 1
