#!/bin/sh

# Single/dual monitor detection
if [ -z $(xrandr | grep "HDMI1 disconnected") ]; then
    xrandr --output eDP1 --mode 1600x900 --pos 0x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 1600x0 --rotate normal
else
    xrandr --output eDP1 --mode 1600x900 --rotate normal --output HDMI1 --off
fi
