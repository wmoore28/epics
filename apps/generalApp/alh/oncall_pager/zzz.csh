#!/bin/tcsh

# By nerses replacing perl

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Author:  Krister Bruhwel 
# started: December 2001
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This script uses a pipe to ps -ef, and then greps for alh.Config.  
# If the program is running, we do nothing.   However, if the program 
# is not running we check to see if clon02 has a windows manager up,
# and then start it.  It is ment to be called via cron.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
source ~/.cshrc
source ~/.login

ps -elo pid,args | grep alh | grep '/home/epics/log/oncall_pager pager.alhConfig' | grep -v grep >/dev/null

# nothing must be in between these lines
if ( $? == 0 ) then
    echo "pager.alhConfig is running: "`date`
else
    echo "pager.alhConfig is not running, starting it : "`date`
	#$ENV{DISPLAY} = "129.57.167.1:0.1";     #clon01
	#$ENV{DISPLAY} = "129.57.167.2:0.0";     #clon02
    setenv DISPLAY ":0.1"
	#$ENV{DISPLAY} = "129.57.32.196:0.0";

    setenv PATH "${PATH}:/home/epics/R3.13.4/epicsB/prod/app/general/alh/oncall_pager"
    setenv EPICS_CA_ADDR_LIST "129.57.96.7 129.57.163.255 129.57.208.90 129.57.57.188 129.57.96.81"

	#Check to see if a windows manager is running on clon02.
	# If theres no manager, we can't pop our program, and nobody
	# gets paged.  A lesson learned due to a power outage in the CH.

	#if ($err = `ssh -n primex\@clon02 ps -ef | grep dtsession`) {
#if ($err = `ssh -n primex\@clon02`) {
    echo DISPLAY = $DISPLAY
    cd ${APP}/general/alh/oncall_pager
    alh -s -m 200000 -l /home/epics/log/oncall_pager pager.alhConfig &
# nothing must be in between these lines
    if( $? == 0 ) then
	echo "... [started program]"
    else
	echo "ERROR: no dtsession on clon02, can't pop a window."
	echo `pageOnCall.pl -message -m "cannot open handler display on clon02"` 
    endif
endif
