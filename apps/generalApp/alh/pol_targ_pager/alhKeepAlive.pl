#!/bin/env perl

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Author:  Krister Bruhwel 
# started: December 2001
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This script uses a pipe to ps -ef, and then greps for alh.Config.  
# If the program is running, we do nothing.   However, if the program 
# is not running we check to see if clon02 has a windows manager up,
# and then start it.  It is ment to be called via cron.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

open(PS, "ps -ef |");
@lines = <PS>;
close(PS);

@results =  grep /alh .*pol_targ_pager*/, @lines;
foreach $l (@results) {
		print "$l\n";
}
$num = "\n$#results";

$ltime = localtime(time());

if ($num >=0) {
	print "polTargPager.alhConfig is running: $ltime\n";
}
else {
	print "polTargPager.alhConfig is not running, starting it : $ltime ";
	#$ENV{DISPLAY} = "129.57.167.1:0.1";      #clon01
	$ENV{DISPLAY} = "129.57.167.2:0.0";     #clon02
	#$ENV{DISPLAY} = "129.57.32.196:0.0";

	$ENV{PATH} = "$ENV{PATH}\:/home/epics/R3.13.4/epicsB/prod/app/general/alh/pol_targ_pager";
	$ENV{EPICS_CA_ADDR_LIST} = "129.57.96.7 129.57.163.255 129.57.208.90 129.57.57.188 129.57.96.81";

	#Check to see if a windows manager is running on clon02.
	# If theres no manager, we can't pop our program, and nobody
	# gets paged.  A lesson learned due to a power outage in the CH.

	#if ($err = `ssh -n primex\@clon02 ps -ef | grep dtsession`) {
#if ($err = `ssh -n primex\@clon02`) {
		$commandName = "alh -s -m 200000 $ENV{APP}/general/alh/pol_targ_pager/polTargPager.alhConfig";
		if(!system("$commandName &")){
		print "... [started program]\n";
	}
	else {
		print "ERROR: no dtsession on clon02, can't pop a window.\n";
		`pageOnCall.pl -message -m "cannot open handler display on clon02"` 
	}
}
