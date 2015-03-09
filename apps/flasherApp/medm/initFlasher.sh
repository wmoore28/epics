#!/bin/sh
#These commands need to be run when the IOC is started. Add as required.

#look at the Manual, and $EPICS/apps/iocBoot/iocFlasher/flasher.db to see channels.

PREFIX="/usr/clas12/hps/prod/apps/flasherApp/medm"

##This lot for the TOP module
##Set the default init files (in user space)
caput -S B_HPS_ECAL_FLASHER_TOP:SEQ_FILE ${PREFIX}/HPSFlasher1DefaultSeq.sh
caput -S B_HPS_ECAL_FLASHER_TOP:DATA_FILE_LOAD ${PREFIX}/HPSFlasher1BlueChannels.dat
caput -S B_HPS_ECAL_FLASHER_TOP:DATA_FILE_SAVE ${PREFIX}/HPSFlasher1SavedChannels.dat

##x and  y cord tables for TOP modules LED index goes from 2->223 
#caput -a B_HPS_ECAL_FLASHER_TOP:X_TABLE 224 999 999 23 23 23 23 23 22 22 22 22 22 21 21 21 21 21 20 20 20 20 20 19 19 19 19 19 18 18 18 18 18 17 17 17 17 17 16 16 16 16 16 15 15 15 15 15 14 14 14 14 14 13 13 13 13 13 12 12 12 12 12 11 11 11 11 11 10 10 10 10 10 9 9 9 9 9 8 8 8 8 8 7 7 7 7 7 6 6 6 6 6 5 5 5 5 5 4 4 4 4 4 3 3 3 3 3 2 2 2 2 2 1 1 -2 -1 1 1 1 -1 -2 -1 -1 -1 -3 -3 -2 -2 -3 -4 -4 -4 -3 -4 -5 -5 -5 -5 -6 -6 -6 -6 -7 -7 -7 -7 -8 -8 -8 -8 -9 -9 -9 -10 -9 -10 -10 -10 -11 -11 -11 -11 -11 -12 -12 -12 -12 -12 -13 -13 -13 -13 -13 -14 -14 -14 -14 -14 -15 -15 -15 -15 -15 -16 -16 -16 -16 -16 -17 -17 -17 -17 -17 -18 -18 -18 -18 -18 -19 -19 -19 -19 -19 -20 -20 -20 -20 -20 -21 -21 -21 -21 -21 -22 -22 -22 -22 -22 -23 -23 -23 -23 -23

#caput -a B_HPS_ECAL_FLASHER_TOP:Y_TABLE 224 999 999 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 2 5 4 3 4 1 5 4 3 2 1 5 4 3 2 2 5 4 3 3 2 5 4 3 2 5 4 3 2 2 5 4 3 3 2 5 4 4 3 2 5 5 4 3 2 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1

caput -a B_HPS_ECAL_FLASHER_TOP:X_TABLE 224 999 999 23 23 23 23 23 22 22 22 22 22 21 21 21 21 21 20 20 20 20 20 19 19 19 19 19 18 18 18 18 18 17 17 17 17 17 16 16 16 16 16 15 15 15 15 15 14 14 14 14 14 13 13 13 13 13 12 12 12 12 12 11 11 11 11 11 10 10 10 10 10 9 9 9 9 9 8 8 8 8 8 7 7 7 7 7 6 6 6 6 6 5 5 5 5 5 4 4 4 4 4 3 3 3 3 3 2 2 2 2 2 1 1 -2 -1 1 1 1 -1 -2 -1 -1 -1 -3 -3 -2 -2 -3 -4 -4 -4 -3 -4 -5 0 -5 -5 -5 -6 -6 -6 -6 -7 -7 -7 -7 -8 -8 -8 -8 -9 -9 -9 -10 -9 -10 -10 -10 -11 -11 -11 -11 -11 -12 -12 -12 -12 -12 -13 -13 -13 -13 -13 -14 -14 -14 -14 -14 -15 -15 -15 -15 -15 -16 -16 -16 -16 -16 -17 -17 -17 -17 -17 -18 -18 -18 -18 -18 -19 -19 -19 -19 -19 -20 -20 -20 -20 -20 -21 -21 -21 -21 -21 -22 -22 -22 -22 -22 -23 -23 -23 -23 -23

caput -a B_HPS_ECAL_FLASHER_TOP:Y_TABLE 224 999 999 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 2 5 4 3 4 1 5 4 3 2 1 5 4 3 2 2 5 4 3 3 2 5 0 4 3 2 5 4 3 2 2 5 4 3 3 2 5 4 4 3 2 5 5 4 3 2 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1 5 4 3 2 1

##Set to overwrite mode
caput B_HPS_ECAL_FLASHER_TOP:SET_OWR 1

##Set trigger to internal
caput B_HPS_ECAL_FLASHER_TOP:SET_CLOCK INT

##Load the channels widths and amplitudes from the default file
${PREFIX}/loadFlasherChannelsFromFile.sh B_HPS_ECAL_FLASHER_TOP

##Load the default sequence
${PREFIX}/HPSFlasher1DefaultSeq.sh B_HPS_ECAL_FLASHER_TOP

##Flag that INIT has taken place
caput B_HPS_ECAL_FLASHER_TOP:IOC_INIT 1


##This lot for the Bottom module - comment in when that module is set up.
##
##Set the default init files (in user space)
caput -S B_HPS_ECAL_FLASHER_BOT:SEQ_FILE ${PREFIX}/HPSFlasher2DefaultSeq.sh
caput -S B_HPS_ECAL_FLASHER_BOT:DATA_FILE_LOAD ${PREFIX}/HPSFlasher2BlueChannels.dat
caput -S B_HPS_ECAL_FLASHER_BOT:DATA_FILE_SAVE ${PREFIX}/HPSFlasher2SavedChannels.dat

#caput -a B_HPS_ECAL_FLASHER_BOT:X_TABLE 224 999 999 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 -19 -19 -19 -18 -18 -18 -18 -18 -17 -17 -17 -17 -17 -16 -16 -16 -16 -16 -15 -15 -15 -15 -15 -14 -14 -14 -14 -14 -13 -13 -13 -13 -13 -12 -12 -12 -12 -12 -11 -11 -11 -11 -11 -10 -10 -10 -10 -9 -8 -9 -9 -9 -8 -7 -8 -7 -8 -6 -7 -7 -5 -6 -5 -6 -4 -5 -6 -4 -5 -3 -3 -4 -3 -4 -2 -2 -3 -2 -1 -2 -1 -1 -1 1 -1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 4 4 4 4 4 5 5 5 5 5 6 6 6 6 6 7 7 7 7 7 8 8 8 8 8 9 9 9 9 9 10 10 10 10 10 11 11 11 11 11 12 12 12 12 12 13 13 13 13 13 14 14 14 14 14 15 15 15 15 15 16 16 16 16 16 17 17 17 17 17 18 18 18 18 18 19 19 19 19 19 20 20 20 20 20 21 21 21 21 21 22 22 22 22 22 23 23 23 23 23

#caput -a B_HPS_ECAL_FLASHER_BOT:Y_TABLE 224 999 999 -6 -6 -6 -6 -6 -6 -6 -6 -6 -6 -6 -6 -6 -6 -6 -6 -6 -6 -6 -6 -6 -6 -6 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -5 -4 -4 -3 -2 -5 -5 -3 -2 -2 -5 -4 -3 -3 -3 -4 -4 -3 -2 -2 -5 -5 -4 -3 -2 -5 -4 -4 -2 -2 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -3 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1

caput -a B_HPS_ECAL_FLASHER_BOT:X_TABLE 224 999 999 -23 -23 -23 -23 -23 -22 -22 -22 -22 -22 -21 -21 -21 -21 -21 -20 -20 -20 -20 -20 -19 -19 -19 -19 -19 -18 -18 -18 -18 -18 -17 -17 -17 -17 -17 -16 -16 -16 -16 -16 -15 -15 -15 -15 -15 -14 -14 -14 -14 -14 -13 -13 -13 -13 -13 -12 -12 -12 -12 -12 -11 -11 -11 -11 -11 -10 -10 999 -10 -10 -9 -8 -9 -9 -9 -8 -7 -8 -7 -8 -6 -7 -7 -5 -6 -5 -6 -4 -5 -6 -4 -5 -3 -3 -4 -3 -4 -2 -2 -3 -2 -1 -2 -1 -1 -1 1 -1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 4 4 4 4 4 5 5 5 5 5 6 6 6 6 6 7 7 7 7 7 8 8 8 8 8 9 9 9 9 9 10 10 10 10 10 11 11 11 11 11 12 12 12 12 12 13 13 13 13 13 14 14 14 14 14 15 15 15 15 15 16 16 16 16 16 17 17 17 17 17 18 18 18 18 18 19 19 19 19 19 20 20 20 20 20 21 21 21 21 21 22 22 22 22 22 23 23 23 23 23 
caput -a B_HPS_ECAL_FLASHER_BOT:Y_TABLE 224 999 999 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 999 -3 -2 -5 -4 -4 -3 -2 -5 -5 -3 -2 -2 -5 -4 -3 -3 -3 -4 -4 -3 -2 -2 -5 -5 -4 -3 -2 -5 -4 -4 -2 -2 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -3 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 -5 -4 -3 -2 -1 

##Set to overwrite mode
caput B_HPS_ECAL_FLASHER_BOT:SET_OWR 1

##Set trigger to internal
caput B_HPS_ECAL_FLASHER_BOT:SET_CLOCK EXT

##Load the channels widths and amplitudes from the default file
${PREFIX}/loadFlasherChannelsFromFile.sh B_HPS_ECAL_FLASHER_BOT

##Load the default sequence
${PREFIX}/HPSFlasher2DefaultSeq.sh B_HPS_ECAL_FLASHER_BOT

##Flag that INIT has taken place
caput B_HPS_ECAL_FLASHER_BOT:IOC_INIT 1
