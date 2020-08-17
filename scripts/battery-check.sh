#!/bin/sh

level=$(acpi -b | grep -Eo '[0-9][0-9]?%' | grep -Eo '[0-9][0-9]?')
charging=$(acpi -b | grep Charging)

while [ $level > 50 ]
do 
	sleep 600s	# waits 10 minutes to avoid pointless power consumption	
	level=$(acpi -b | grep -Eo '[0-9][0-9]?%' | grep -Eo '[0-9][0-9]?')
done

while [ $level > 20 ]
do 
	sleep 120s	# waits 2 minutes since the battery is under 50%	
	level=$(acpi -b | grep -Eo '[0-9][0-9]?%' | grep -Eo '[0-9][0-9]?')
done

while [ $level <= 20 ] and [ $charging != $null ] 
do
	sleep 60s
	notify-send "Battery low: $level%" -u critical
	level=$(acpi -b | grep -Eo '[0-9][0-9]?%' | grep -Eo '[0-9][0-9]?')
	charging=$(acpi -b | grep Charging)

