#!/bin/bash
#
# ecalRampCtrl.sh
# 
# ECAL Ramp Control - uses ramp up/down
#
# Author: Wesley Moore
# Date:   Dec 2014
#

if [ $# -eq 0 ]; then
	echo "Usage: $0 [0|1]"
	exit 1
else
	ramp=$1
fi

for loc in TOP BOT; do
	for chan in `seq -w 1 26`; do
		# ex. B_hv_ECAL_TOP_01_CHHV
		caput B_hv_ECAL_${loc}_${chan}_CHHV $ramp
	done
done

exit 0
