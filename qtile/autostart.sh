#!/bin/sh

# launching apps only if there are no istances already running
pidof -q conky          || conky &                          # desktop widgets
pidof -q dunst          || dunst &                          # notification daemon
pidof -q picom          || picom -f &                       # compositor
pidof -q lxpolkit       || lxpolkit &                       # authentication agent
pidof -q flameshot      || flameshot &                      # screenshot tool
pidof -q parcellite     || parcellite &                     # clipboard manager
pidof -q nm-applet      || nm-applet &                      # network manager
pidof -q blueman-applet || blueman-applet &                 # bluetooth manager
pidof -q pasystray      || pasystray --include-monitors &   # pulseaudio tray icon
pidof -q xss-lock       || xss-lock -l -- i3lock-fancy &    # lock screen manager

# setting wallpaper
xwallpaper --zoom ~/.config/qtile/background.jpg

# xmodmap settings
xmodmap ~/.Xmodmap

# handmade power management script
pkill -f ~/git-repos/scripts/battery-check
~/git-repos/scripts/battery-check &

# xob volume bar
pkill -f ~/.config/xob/pulse-volume-watcher.py
~/.config/xob/pulse-volume-watcher.py | xob -s default -t 2000 &
