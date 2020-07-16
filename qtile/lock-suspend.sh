#!/bin/bash
# Credits to BoBomann18 on github: https://github.com/BoBomann18/dotfiles

tmpbg='/tmp/lockscreen.png' 
icon='/home/azadahmadi/.config/qtile/lock_icon.png'

(( $# )) && { icon=$1; }

# scrot "$tmpbg"
gnome-screenshot -f "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
i3lock -i "$tmpbg"
systemctl suspend # added this line to the standard script to suspend
