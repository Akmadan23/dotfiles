#!/bin/sh

killall \
    xob \
    picom \
    pasystray

conky &                 # conky widgets
# dunst &                 # notification manager
xfce4-notifyd &         # notification manager
picom -f &              # compositor
lxpolkit &              # simple policykit authentication agent
nm-applet &             # network manager
flameshot &             # screenshot tool
parcellite &            # clipboard manager
blueman-applet &        # bluetooth manager
pasystray --include-monitors & # pulseaudio tray icon

xss-lock -l -- i3lock-fancy &
xwallpaper --zoom ~/.config/qtile/background.jpg

# handmade power management script
kill -9 "$(pgrep -f $HOME/git-repos/scripts/battery-check)"
~/git-repos/scripts/battery-check &

# xob volume bar
kill -9 "$(pgrep -f $HOME/.config/xob/pulse-volume-watcher.py)"
~/.config/xob/pulse-volume-watcher.py | xob -s default -t 2000 &
