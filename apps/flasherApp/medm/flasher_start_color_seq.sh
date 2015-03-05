#!/bin/bash
#
# Steps for running the [blue|red] sequence.
#

# Assign PV prefixes
TOP="B_HPS_ECAL_FLASHER_TOP"
BOT="B_HPS_ECAL_FLASHER_BOT"

usage() { echo "Usage: $0 -c <blue|red>" 1>&2; exit 1; }

while getopts "c:" arg; do
	case $arg in
	c) 
		COLOR="$(echo ${OPTARG} | tr '[:upper:]' '[:lower:]')"
	   	;;
	*)
		usage
		;;
	esac
done
shift $((OPTIND-1))

# Color and Clock must be defined
if [ -z "${COLOR}" ]; then
	usage
fi

# Fix capitalization for usage later
if [ "$COLOR" = "blue" ]; then
	COLOR="Blue"
elif [ "$COLOR" = "red" ]; then
	COLOR="Red"
else
	usage
fi

# Setup TOP
caput ${TOP}:SET_COLOR $COLOR
caput -S ${TOP}:DATA_FILE_LOAD HPSFlasher1${COLOR}Channels.dat
./flasher_load_chan_file.sh "$TOP"

	
# Setup BOT
caput ${BOT}:SET_COLOR $COLOR
caput -S ${BOT}:DATA_FILE_LOAD HPSFlasher2${COLOR}Channels.dat
./flasher_load_chan_file.sh "$BOT"

#START TOP AND BOT
./flasher_start_top.sh
./flasher_start_bot.sh

exit 0
