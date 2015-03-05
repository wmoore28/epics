#!/bin/bash
#
# Wrap this with xterm -e for use from MEDM.
#
# Author: wmoore
# Date:   Dec 2014
#

echo "Running ECAL FADC Scaler GUI (DiagGUI)..."
ssh clasrun@clondaq5 'cd $CODA/src/DiagGUI; ./DiagGUI ROCConfigHPS_SSP_only.txt'
