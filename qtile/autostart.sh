#!/bin/sh

killall conky
dunst &                 # notification daemon
conky &                 # desktop widgets
picom -f &              # compositor
lxpolkit &              # simple policykit authentication agent
nm-applet &             # network manager
flameshot &             # screenshot tool
parcellite &            # clipboard manager
blueman-applet &        # bluetooth manager

# pulseaudio tray icon
killall pasystray
pasystray --include-monitors &

# setting primary monitor
xrandr --output DP2-1 --primary

# lock screen and wallpaper
xss-lock -l -- i3lock-fancy &
xwallpaper --zoom ~/.config/qtile/background.jpg

# handmade power management script
pkill -f ~/git-repos/scripts/battery-check
~/git-repos/scripts/battery-check &

# xob volume bar
pkill -f ~/.config/xob/pulse-volume-watcher.py
~/.config/xob/pulse-volume-watcher.py | xob -s default -t 2000 &
