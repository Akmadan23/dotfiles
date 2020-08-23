#!/bin/sh

kill -9 $(pidof bin/sh /home/azadahmadi/.config/scripts/battery-check.sh)

while :; do
	if [ $(acpi -b | grep -Eo '[0-9][0-9][0-9]?%' | grep -Eo '[0-9][0-9][0-9]?') -gt 40 ]; then
		while [ $(acpi -b | grep -Eo '[0-9][0-9][0-9]?%' | grep -Eo '[0-9][0-9][0-9]?') -gt 50 ]; do 
			sleep 600s; done

	elif [ $(acpi -b | grep -Eo '[0-9][0-9][0-9]?%' | grep -Eo '[0-9][0-9][0-9]?') -gt 20 ]; then
		while [ $(acpi -b | grep -Eo '[0-9][0-9][0-9]?%' | grep -Eo '[0-9][0-9][0-9]?') -gt 20 ]; do 
			sleep 120s; done

	else
		while [ $(acpi -b | grep -Eo '[0-9][0-9][0-9]?%' | grep -Eo '[0-9][0-9][0-9]?') -le 20 -a $(acpi -b | grep " Charging") != $null ]; do
			sleep 60s; notify-send "Battery low: $(acpi -b | grep -Eo '[0-9][0-9][0-9]?%' | grep -Eo '[0-9][0-9][0-9]?')%" -u critical; done
	fi
done

