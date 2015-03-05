#!/bin/sh
cd /usr/clas12/hps/prod/tools/ecal/EcalScalerGui
xterm -title "ECAL DSC2 Scaler GUI" -e root -l run_dsc2_scalers.C &
exit
