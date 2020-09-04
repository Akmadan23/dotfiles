#!/bin/bash

while :; do
	if [ $(acpi -b | grep -Eo "Charging") = "Charging" ]; then
		if [ $(acpi -b | grep -Eo '[0-9][0-9][0-9]?%' | grep -Eo '[0-9][0-9][0-9]?') -gt 20 ]; then
			sleep 600s
		else
			sleep 120s
		fi
	else
		if [ $(acpi -b | grep -Eo '[0-9][0-9][0-9]?%' | grep -Eo '[0-9][0-9][0-9]?') -gt 40 ]; then
			sleep 600s
		elif [ $(acpi -b | grep -Eo '[0-9][0-9][0-9]?%' | grep -Eo '[0-9][0-9][0-9]?') -gt 20 ]; then
			sleep 120s
		else
			if [ $(acpi -b | grep -Eo "Charging") = "Charging" ]; then
				sleep 300s
			else
				notify-send "Battery low: $(acpi -b | grep -Eo '[0-9][0-9][0-9]?%' | grep -Eo '[0-9][0-9][0-9]?')%" -u critical
				sleep 60s
			fi
		fi
	fi
done

