#!/bin/sh

x=$(xrandr | grep "HDMI-1 disconnected")
y=""

if [ $x == $y ] 
then
	echo connected > ~/.config/qtile/hdmi.txt
else
	echo disconnected > ~/.config/qtile/hdmi.txt
fi