#####!/bin/tcsh

#source ./setup_epics.csh
echo "Start SVT DAQ Setup GUI"
set cmd = ""
if($#argv == 0) then
    echo "Need to supply -x for execution or -e for edit"
else
	set cmd = $argv[1]
    #if($argv[1] == "x") then
	#set cmd = "-x"
	#echo "what"
    #else
	#echo "dfsd"
	#set cmd = ""
    #endif
    echo $cmd
    medm $cmd svtMap.adl &
    medm $cmd svtDpmStatus.adl &
    medm $cmd svtDpmLinkStatus.adl &    
    medm $cmd svtDaqSocketSetup.adl &
    medm $cmd svtTemp.adl &
    medm $cmd svtHybrid.adl &    
    medm $cmd svtHybSync.adl &    
    #medm $cmd svtFebMain.adl &
    #medm $cmd svtFlangeMain.adl &
    #medm $cmd svtBiasMain.adl &
    echo "Done"
endif

