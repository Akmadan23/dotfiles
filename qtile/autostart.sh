#!/bin/sh

picom -f &
nm-applet &
flameshot &
parcellite &
xss-lock -l -- lock-script &
feh --bg-scale ~/.config/qtile/images/wallpaper.jpg
