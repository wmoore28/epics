#!/bin/bash
#
# Stop all 
#

# Assign PV prefixes
TOP="B_HPS_ECAL_FLASHER_TOP"
BOT="B_HPS_ECAL_FLASHER_BOT"

for P in $TOP $BOT
do
	caput ${P}:SEQ_START 0
	caput ${P}:GET_LEDS.SCAN 0
	caput ${P}:GET_SEQUENCE 0
done

exit 0
