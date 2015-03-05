#!/bin/bash

# Assign PV prefixes
TOP="B_HPS_ECAL_FLASHER_TOP"
BOT="B_HPS_ECAL_FLASHER_BOT"

usage() { echo "Usage: $0 <0|1|off|on>" 1>&2; exit 1; }

if [ -z "$1" ]; then
	usage
else
	ON_OFF="$(echo $1 | tr '[:upper:]' '[:lower:]')"
	if [ "$ON_OFF" = "on" ] || [ "$ON_OFF" = "1" ]; then
		ON_OFF=1
	elif [ "$ON_OFF" = "off" ] || [ "$ON_OFF" = "0" ]; then
		ON_OFF=0
	else
		usage
	fi
fi

for card in $TOP, $BOT
do
	for i in `seq 0 224`
	do
		caput ${card}:SELECTED_CHANNEL $i
		caput ${card}:SWITCH_SELECTED_LED $ON_OFF
	done
done

exit 0
