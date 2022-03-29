#!/bin/sh

# launching apps only if there are no istances already running
pidof -q conky          || conky &              # desktop widgets
pidof -q dunst          || dunst &              # notification daemon
pidof -q picom          || picom -bf &          # compositor
pidof -q lxpolkit       || lxpolkit &           # authentication agent
pidof -q clipmenud      || clipmenud &          # clipboard manager
pidof -q nm-applet      || nm-applet &          # network manager
pidof -q blueman-applet || blueman-applet &     # bluetooth manager
pidof -q light-locker   || light-locker &       # lock screen using lightdm
pidof -q pasystray      || pasystray --include-monitors --notify=all & # pulseaudio tray icon

# setting wallpaper
xwallpaper --zoom ~/.config/qtile/background.jpg &
