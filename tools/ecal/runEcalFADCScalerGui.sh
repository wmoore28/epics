#!/bin/sh
cd /usr/clas12/hps/prod/tools/ecal/EcalScalerGui
xterm -title "ECAL FADC Scaler GUI" -e root -l run_fadc_scalers.C &
exit
