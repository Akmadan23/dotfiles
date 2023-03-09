#!/usr/bin/env bash
brightness_file="/sys/class/backlight/intel_backlight/brightness"
max_brightness_file="/sys/class/backlight/intel_backlight/max_brightness"
read max_value < $max_brightness_file

while :; do
    inotifywait -qq -e modify $brightness_file
    # cat $brightness_file
    read current_value < $brightness_file
    echo $(($current_value * 100 / $max_value))
done
