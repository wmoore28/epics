#!/bin/env perl

use Getopt::Long;
use lib ('/home/epics/PERL/lib/site_perl/5.6.0/sun4-solaris');
use Pezca;

#-----------------------------------------------------------------------
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Author:        Krister Bruhwel
# Start Date:    November 2001
# Program:       pagePolTarg.pl
#
# Purpose:
# 	This script was made for the alarm hander on call paging signal.
#	When an alarm is generated on the alarm handler screen this 
#	script is called.  It will page the oncall in intervals so that 
#	they will hopefully respond.  The intervals do two things.  One
#	is pester the oncall, and two is to take care of the paging 
#	company dropping a page.  This will increase the odds of getting
#	through. I have found that if pages are sent too fast, the company
#	drops them anyway.  Keep your intervals kinda long, and test it.
#	I like the default of 10 minutes.
#
#	Added lockfiles due to the EPICS alarm handler filter not working
#	right.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
#   pagePolTarg.pl { ... Options }
#        -sig [signal]                 // default = "no_signal"
#        -grp [group]                  // default = "no_group"
#        -m [message]                  // default = "no_message"
#        -t [time interval in minutes] // default = "10"
#        -n [number of pages to send]  // default = "2"
#        -default                      // set = page defaults pri & sec 
#        -debug                        // set = no pages.  stdout
#        -l [logFile]                  // default = "pager_alarm_log"
#        -pgNum [pagerNumber]          // default = primary & secondary 
#               multiple -pgNum tags maybe used 
#               most phone number formats are OK
#		 -message                      //test the pager
#       The user may put the tags in any order they wish.
#
#  example:
#  pagePolTarg.pl -s "Torus" -m "PI1022=HIGH" -pgNum "num1" -pgNum "num2"
#  pagePolTarg.pl -d -s "Torus" -m "PI1022=HIGH" -pgNum "num1"
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#-----------------------------------------------------------------------

$PRIMARY_ON_CALL   = "584-5772";
#$SECONDARY_ON_CALL = "584-5772";
$AUTHORS_NUMBER    = "584-7868";
$DEFAULT_LOG       = "/home/epics/log/oncall_pager/pager_alarm_log";

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# START MAIN
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

GetOptions("help", "h", "pgNum=s@", "grp=s", "sig=s", 
           "m=s", "t=i", "n=i", "l=s", "default", "debug", "message");

#take care of command line flags and set defaults
if ($opt_help)   { printHelp(); exit(); }
if ($opt_h)      { printHelp(); exit(); }
if (!@opt_pgNum) { @opt_pgNum = ($PRIMARY_ON_CALL);}
if ($opt_grp) { $group   = $opt_grp;} else { $group    = "no_group"; }
if ($opt_sig) { $signal  = $opt_sig;} else { $signal   = "no_signal"; }
if ($opt_m) { $message   = $opt_m; } else { $message   = "no_message"; }
if ($opt_t) { $sleepTime = $opt_t; } else { $sleepTime = 10; }
if ($opt_n) { $num_pages = $opt_n; } else { $num_pages = 2; }
if ($opt_l) { $logF = $opt_l;      } else { $logF      = $DEFAULT_LOG; }
if ($opt_default){push(@opt_pgNum,$PRIMARY_ON_CALL,$SECONDARY_ON_CALL);} 
if ($opt_debug) { $DEBUG = "TRUE"; } else { $DEBUG = "FALSE"; }
if ($opt_message) { 
	push(@opt_pgNum, $AUTHORS_NUMBER); 

	if ($message eq "no_message") {$message = "test";}

	foreach $pagerNum (@opt_pgNum) {
		$pagerNum =~ s/\@page.metrocall.com//g;		
		$pagerNum =~ s/757-//g;		
		$pagerNum =~ s/^757//g;		
		$pagerNum =~ s/-//g;		
		$pagerNum = "757$pagerNum\@page.metrocall.com";

		mail ("alarm_handler", $message, $pagerNum);
	}
	logIt ($logF, "alarm_handler", $message, 
                      "NULL", "NULL");
	exit();
}

#get the signals value 
if ($signal eq "no_signal") {
	$sigVal = "NULL";
}
else {
	($error, $sigVal) = Pezca::GetDouble("$signal.VAL");
	($error, $sigSVR) = Pezca::GetDouble("$signal.SEVR");
	#print "SVR = $sigSVR\n";
	$sigVal = sprintf("%.3f", $sigVal);
}

#bail if valid lock file or auto bail is set
$tmpDir = "/tmp/";

#unless (opendir(TMP, $tmpDir)) { 
#	mkdir($tmpDir);
#}
#else {
#	closedir(TMP);
#}

$lockFile = $tmpDir.$signal."_".$sigSVR.".Ptarg_LOCK";

$bailFile = $tmpDir."auto_bail";

$oneHour = 3600;	# 1_hr = 3600_seconds
$bailTime = 900;    #15 minutes

if    (-e $bailFile && (time()-(stat($bailFile))[9] < $bailTime)) {
	open  LL_FILE, ">> $tmpDir/lockLog" or die "cant open locklog\n";
	$logTime = localtime(time);
	print LL_FILE "[Bailing] $logTime, sig = $signal, sevr = $sigSVR {Auto Bail Set}\n";
	close LL_FILE;
	exit(0);
}
elsif (-e $lockFile && (time()-(stat($lockFile))[9] < $oneHour)) {
	open  LL_FILE, ">> $tmpDir/lockLog" or die "cant open locklog\n";
	$logTime = localtime(time);
	print LL_FILE "[Bailing] $logTime, sig = $signal, sevr = $sigSVR\n";
	close LL_FILE;
	exit(0);
}
else {
	open  FILE, "> $lockFile" or die "can NOT open $lockFile\n";
	close FILE;

	open  LL_FILE, ">> $tmpDir/lockLog" or die "cant open locklog\n";
	$logTime = localtime(time);
	print LL_FILE "[Writing] $logTime, sig = $signal, sevr = $sigSVR\n";
	close LL_FILE;
}

#write to a log file
logIt ($logF, $group, $message, $signal, $sigVal);

#time needs to be in seconds
$sleepTimeSec = $sleepTime*60;

#page the victim
for ($i=0; $i<$num_pages; $i++) {
	if ($i != 0) {
		($error, $sigSVR_2) = Pezca::GetDouble("$signal.SEVR");
		if($sigSVR != $sigSVR_2) { next; }
		else {
			($error, $sigVal) = Pezca::GetDouble("$signal.VAL");
			($error, $sigSVR) = Pezca::GetDouble("$signal.SEVR");
	
			$sigVal = sprintf("%.3f", $sigVal);
		}
					
		if ($DEBUG eq "TRUE") {
			print "sigSVR   = $sigSVR\n";
			print "sigSVR_2 = $sigSVR_2\n\n";
		}

	}

	$thisMessage = $message . " - Val = $sigVal";
	
	foreach $pagerNum (@opt_pgNum) {
		$pagerNum =~ s/\@page.metrocall.com//g;		
		$pagerNum =~ s/757-//g;		
		$pagerNum =~ s/^757//g;		
		$pagerNum =~ s/-//g;		
		$pagerNum = "757$pagerNum\@page.metrocall.com";

		mail ($group, $thisMessage, $pagerNum);
	}
	if ($DEBUG eq "TRUE") {
	    print "\n**********************************\n";	
		print "* would sleep for $sleepTime min ...  \n";
	    print "**********************************\n\n";	
		print "sigSVR   = $sigSVR\n";
		print "sigSVR_2 = $sigSVR_2\n";
		#$sigSVR_2 = "1";
		print "secondary page check ...\n";
		sleep (5);
	}
	else { sleep ($sleepTimeSec); }
}

#email the author for a heads up
$group = "On Call Pager: " . $group;
$ltime = localtime();
$thisMessage = $thisMessage . " \t[$ltime]";  
mail ($group, $thisMessage, "bruhwel\@jlab.org");

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# END MAIN
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#/////////////////////////////////////////////////////////////////////

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# SUB FUNCTIONS
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# logIt()
#---------------------------------------------------------------------
# Log the alarm for future reference

sub logIt {
	$logFile    = $_[0];
	$logGroup   = $_[1];
	$logMessage = $_[2];
	$sigName    = $_[3];
	$sigValue   = $_[4];

	$time = localtime();
	$logRecord = "$time\t$logGroup\t$logMessage\t$sigName=$sigValue\n";

	open (LOGFILE, ">>$logFile")
	     or die "Can't open $logFile for appending";

	print LOGFILE $logRecord;	

	close (LOGFILE);

	if ($DEBUG eq "TRUE") {
		print "LOGGING TO FILE ...\n";
		print "\t Entry: $logRecord\n";
	}
}

# mail()
#---------------------------------------------------------------------
# Open a pipe to sendmail and mail the victim.  The paging company
# turns it into a page.

sub mail {
	$sys = $_[0];
	$mes = $_[1];
	$add = $_[2];

	if ($DEBUG eq "TRUE") {
		print "WOULD HAVE SENT A PAGE ...\n";
		print "\tMessage:\n";
		print "\t\t To:      $add\n";
		print "\t\t Subject: $sys\n";
		print "\t\t Message: $mes\n";
	}
	else {
		open (MAIL, "|/usr/lib/sendmail -t -f bruhwel\@jlab.org") 
	      or die "No mail today, can't open a pipe to sendmail";
		print MAIL "To: $add\n";
		print MAIL "Subject: $sys \n";
		print MAIL "Content-type: text/plain\n\n";
		print MAIL "$mes \n";

		close (MAIL);
	}
}

# printHelp()
#---------------------------------------------------------------------
# True to its name, it prints all the help the user could ever want
# or need.

sub printHelp {
	print "\npagePolTarg.pl { ... Options }\n";
	print "\n\t -sig [signal]                 // default = \"no_subject\"";
	print "\n\t -grp [group]                  // default = \"no_group\"";
	print "\n\t -m [message]                  // default = \"no_message\"";
	print "\n\t -n [number of pages sent]     // default = \"2\"";
	print "\n\t -t [time interval in minutes] // default = \"10\"";
	print "\n\t -l [logFile]                  // default = \"pager_alarm_log\"";
	print "\n\t -default                      // set = page defaults pri & sec"; 
	print "\n\t -debug                        // set = no pages.  stdout"; 
	print "\n\t -pgNum [pagerNumber]          // default = $PRIMARY_ON_CALL and $SECONDARY_ON_CALL";
	print "\n\t        multiple -pgNum tags maybe used so all your buddies can have fun";
	print "\n\t        most phone number formats are OK";
	print "\n\t -message                      //test the system";
	print "\n\tThe user may put the tags in any order they wish.";
	print "\n\nPurpose:\n\tThis script will page the oncall with a time ";
	print "interval in between pages.";  
	print "\n\tIt is usually called from an EPICS alarm handler.";
	print "\n\nexamples:";
	print "\n This will page 584-1111 and 584-2222:";
	print "\n   pagePolTarg.pl -s \"Torus\" -m \"PI1022=HIGH\" -pgNum \"584-1111\" -pgNum \"584-2222\"";
	print "\n This will page the Primary & Secondary oncall and 584-2222:";
	print "\n   pagePolTarg.pl -d -s \"Torus\" -m \"PI1022=HIGH\" -pgNum \"584-2222\"\n\n";
}
