#!/bin/sh

notification() {
	notify-send "Min: $(cpufreqctl-azadahmadi min get), \
		Max: $(cpufreqctl-azadahmadi max get), \
		Turbo: $(cpufreqctl-azadahmadi turbo get)"
}

if [[ "$@" = "low" ]]; then
	cpufreqctl-azadahmadi min 20
	cpufreqctl-azadahmadi max 50
	cpufreqctl-azadahmadi turbo 0
	notification

elif [[ "$@" = "normal" ]]; then
	cpufreqctl-azadahmadi min 20
	cpufreqctl-azadahmadi max 80
	cpufreqctl-azadahmadi turbo 1
	notification
elif [[ "$@" = "high" ]]; then
	cpufreqctl-azadahmadi min 50
	cpufreqctl-azadahmadi max 100
	cpufreqctl-azadahmadi turbo 1
	notification
else
	echo "Select a valid mode between low, normal and high"
fi
