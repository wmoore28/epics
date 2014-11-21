#!/bin/sh -f

SCRIPT_DIR=`dirname $0` ; export SCRIPT_DIR
HARPFILE_DIR=/home/epics/DATA/HARP_SCANS; export HARPFILE_DIR
echo +-------------------------------------------------------------------------
echo "|                       Starting HARP SCAN PROGRAM                      |"
echo +-------------------------------------------------------------------------
echo "\n"
harp_dir=$1;
HARPARGS="1200 800 HARP_2_WIRE 13 40.0 55.0 20.0 30.0"
java -cp "$SCRIPT_DIR/../lib/*:$SCRIPT_DIR/../dist/*" org.jlab.harp.gui.HarpScanGUIFULL $harp_dir
#java -cp "$SCRIPT_DIR/../lib/*:$SCRIPT_DIR/../dist/*" org.jlab.harp.gui.HarpScanGUIFULL $HARPARGS
