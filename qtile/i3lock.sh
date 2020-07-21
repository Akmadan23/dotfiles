#!/bin/bash
# Credits to BoBomann18 on github: https://github.com/BoBomann18/dotfiles

tmpbg="/tmp/background.png"
icon="/home/azadahmadi/.config/qtile/images/lock_icon.png"
(( $# )) && { icon=$1; }

sleep 1s
maim "$tmpbg"
# scrot "$tmpbg"

convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
convert "$tmpbg" -blur 100% "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
i3lock -i "$tmpbg"
