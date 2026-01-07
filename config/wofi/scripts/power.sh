#!/usr/bin/env bash

function double_check {
    case $(printf "Yes, $1\nCancel" | wofi -dj -L3 -W20%) in
        Yes,*) eval "${2-$1}" ;;
        Cancel) echo "Canceled" ;;
    esac
}

# icon_path="/usr/share/icons/Adwaita/symbolic/actions"
icon_path="/usr/share/icons/breeze-dark/actions/32"

# items=("Shut down" "Reboot" "Suspend" "Hibernate" "Log out" "Lock screen")
items=(\
    "img:$icon_path/system-shutdown.svg:text:Shut down" \
    "img:$icon_path/system-reboot.svg:text:Reboot" \
    "img:$icon_path/system-suspend.svg:text:Suspend" \
    "img:$icon_path/system-hibernate.svg:text:Hibernate" \
    "img:$icon_path/system-log-out.svg:text:Log out" \
    "img:$icon_path/system-lock-screen.svg:text:Lock screen" \
)

choice="$(printf '%s\n' "${items[@]}" | wofi -dj -L7 -W20% -k /dev/null)"

case "$choice" in
    *"Shut down")    double_check 'shut down' 'shutdown now'         ;;
    *"Reboot")       double_check reboot                             ;;
    *"Suspend")      systemctl suspend                               ;;
    *"Hibernate")    systemctl hibernate                             ;;
    *"Log out")      double_check 'log out' 'hyprctl dispatch exit'  ;;
    *"Lock screen")  hyprlock                                        ;;
esac
