#!/bin/sh

# Single/dual monitor detection
if xrandr | grep -q "DP2-1 connected"; then
    xrandr \
        --output eDP1   --mode 1600x900     --pos 0x180 \
        --output DP2-1  --mode 1920x1080    --pos 1600x0 --primary
elif xrandr | grep -q "HDMI1 connected"; then
    xrandr --output eDP1 --mode 1600x900 --pos 0x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 1600x0 --rotate normal
else
    xrandr --output eDP1 --mode 1600x900 --rotate normal --output HDMI1 --off --output DP2-1 --off
fi
