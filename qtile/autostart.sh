#!/bin/sh

# launching apps only if there are no istances already running
pgrep -x conky          || conky &              # desktop widgets
pgrep -x dunst          || dunst &              # notification daemon
pgrep -x picom          || picom -bf &          # compositor
pgrep -x lxpolkit       || lxpolkit &           # authentication agent
pgrep -x clipmenud      || clipmenud &          # clipboard manager
pgrep -x nm-applet      || nm-applet &          # network manager
pgrep -x blueman-applet || blueman-applet &     # bluetooth manager
pgrep -x light-locker   || light-locker &       # lock screen using lightdm
pgrep -x pasystray      || pasystray --include-monitors --notify=none & # pulseaudio tray icon
pgrep -x ejectsy        || ejectsy &

# handmade power management script
pkill -f "$SCRIPTS/battery-check"
"$SCRIPTS/battery-check" &

# setting wallpaper
xwallpaper --zoom ~/.config/qtile/background.jpg &
