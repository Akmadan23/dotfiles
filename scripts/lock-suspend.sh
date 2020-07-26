#!/bin/bash
# Credits to BoBomann18 on github: https://github.com/BoBomann18/dotfiles

tmpbg="/tmp/lockscreen.png"
icon="/home/azadahmadi/.config/qtile/images/lock_icon.png"

(( $# )) && { icon=$1; }

sleep 1s
maim "$tmpbg"
# scrot "$tmpbg"

convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
convert "$tmpbg" -blur 10% "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
i3lock -i "$tmpbg"

sleep 1s
systemctl suspend # added this line to the standard script to suspend
