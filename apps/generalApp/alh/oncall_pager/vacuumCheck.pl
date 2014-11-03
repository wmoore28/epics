#!/bin/env perl

use Getopt::Long;
use lib ('/home/epics/PERL/lib/site_perl/5.6.0/sun4-solaris');
use Pezca;

$ENV{EPICS_CA_ADDR_LIST}="129.57.96.7 129.57.163.255 129.57.208.90";

$DEFAULT_LOG = "/home/epics/log/oncall_pager/vacuumCheck.log";

@pageNumbers = ("584-5245");
#@pageNumbers = ("584-7868");
#@pageNumbers = ("584-7868", "584-7275", "584-5245");


#PG2013
($error, $PI2013_val) = Pezca::GetDouble("PI2013.VAL");

if ($PI2013_val < 0.98 || $PI2013_val > 3.5) {
	#print "value = $PG3031_val\n";

	foreach $pagerNum (@pageNumbers) {
			$pagerNum =~ s/\@page.metrocall.com//g;		
			$pagerNum =~ s/757-//g;		
			$pagerNum =~ s/^757//g;		
			$pagerNum =~ s/-//g;		
			$pagerNum = "757$pagerNum\@page.metrocall.com";

			mail ("Torus N2 Pressure Warning", "PI2013=$PI2013_val", $pagerNum);

	}
	

	#mail ("Torus Vacuum Warning", "PG3031=$PG3031_val $pagerNum", "bruhwel\@jlab.org");

	$message = "Warning PI2013: $PI2013_val";
	logIt($message);

}
else {
	#print "OK\n";
	$message = "STAT OK PI2013: $PI2013_val";
	logIt($message);
}


#PG3031
($error, $PG3031_val) = Pezca::GetDouble("PG3031.VAL");

if ($PG3031_val > -4.0) {
	#print "value = $PG3031_val\n";

	foreach $pagerNum (@pageNumbers) {
			$pagerNum =~ s/\@page.metrocall.com//g;		
			$pagerNum =~ s/757-//g;		
			$pagerNum =~ s/^757//g;		
			$pagerNum =~ s/-//g;		
			$pagerNum = "757$pagerNum\@page.metrocall.com";

			mail ("Torus Vacuum Warning", "PG3031=$PG3031_val", $pagerNum);

	}
	

	#mail ("Torus Vacuum Warning", "PG3031=$PG3031_val $pagerNum", "bruhwel\@jlab.org");

	$message = "Warning PG3031: $PG3031_val";
	logIt($message);

}
else {
	#print "OK\n";
	$message = "STAT OK PG3031: $PG3031_val";
	logIt($message);
}


#PI1028
($error, $PI1028_val) = Pezca::GetDouble("PI1028.VAL");

if ($PI1028_val < 1.0 || $PI1028_val > 1.45) {
	#print "value = $PI1028_val\n";

	foreach $pagerNum (@pageNumbers) {
			$pagerNum =~ s/\@page.metrocall.com//g;		
			$pagerNum =~ s/757-//g;		
			$pagerNum =~ s/^757//g;		
			$pagerNum =~ s/-//g;		
			$pagerNum = "757$pagerNum\@page.metrocall.com";

			mail ("Torus 1.2 Tank Warning", "PI1028=$PI1028_val", $pagerNum);

	}
	

	#mail ("Torus Vacuum Warning", "PI1028=$PI1028_val $pagerNum", "bruhwel\@jlab.org");

	$message = "Warning PI1028: $PI1028_val";
	logIt($message);

}
else {
	#print "OK\n";
	$message = "STAT OK PI1028: $PI1028_val";
	logIt($message);
}


#PI8210
#($error, $PI8210_val) = Pezca::GetDouble("PI8210.VAL");
#
#if ($PI8210_val < 1020) {
#	print "value = $PI8210_val\n";
#
#	foreach $pagerNum (@pageNumbers) {
#			$pagerNum =~ s/\@page.metrocall.com//g;		
#			$pagerNum =~ s/757-//g;		
#			$pagerNum =~ s/^757//g;		
#			$pagerNum =~ s/-//g;		
#			$pagerNum = "757$pagerNum\@page.metrocall.com";
#
#			mail ("Warning Buffer Dewer", "PI8210=$PI8210_val", $pagerNum);
#
#	}
#	
#
#	#mail ("Buffer Dewer Warning PI8210", "PI8210=$PI8210_val $pagerNum", "bruhwel\@jlab.org");
#
#	$message = "Warning Buffer Dewer: $PI8210_val";
#	logIt($message);
#
#}
#else {
#	#print "OK\n";
#	$message = "STAT OK PI8210: $PI8210_val";
#	logIt($message);
#}

#LL2014
#($error, $LL2014_val) = Pezca::GetDouble("LL2014.VAL");
#if ($LL2014_val < 10) {
#	#print "value = $LL2014_val\n";
#
#	foreach $pagerNum (@pageNumbers) {
#			$pagerNum =~ s/\@page.metrocall.com//g;		
#			$pagerNum =~ s/757-//g;		
#			$pagerNum =~ s/^757//g;		
#			$pagerNum =~ s/-//g;		
#			$pagerNum = "757$pagerNum\@page.metrocall.com";
#
#			mail ("Warning N2 Level", "LL2014=$LL2014_val", $pagerNum);
#
#	}
#	

#	#mail ("Buffer Dewer Warning LL2014", "LL2014=$LL2014_val $pagerNum", "bruhwel\@jlab.org");

#	$message = "Warning N2 Level: $LL2014_val";
#	logIt($message);

#}
#else {
#	#print "OK\n";
#	$message = "STAT OK LL2014: $LL2014_val";
#	logIt($message);
#}

#PI2013
#($error, $PI2013_val) = Pezca::GetDouble("PI2013.VAL");
#if ($PI2013_val < 1.02) {
##print "value = $PI2013_val\n";
#
#	foreach $pagerNum (@pageNumbers) {
#			$pagerNum =~ s/\@page.metrocall.com//g;		
#			$pagerNum =~ s/757-//g;		
#			$pagerNum =~ s/^757//g;		
#			$pagerNum =~ s/-//g;		
#			$pagerNum = "757$pagerNum\@page.metrocall.com";
#
#			mail ("Warning N2 Press", "PI2013=$PI2013_val", $pagerNum);
#
#	}
#	
#
#	#mail ("Buffer Dewer Warning PI2013", "PI2013=$PI2013_val $pagerNum", "bruhwel\@jlab.org");
#
#	$message = "Warning N2 Press: $PI2013_val";
#	logIt($message);
#
#}
#else {
#	#print "OK\n";
#	$message = "STAT OK PI2013: $PI2013_val";
#	logIt($message);
#}
#
sub mail {
	$sys = $_[0];
	$mes = $_[1];
	$add = $_[2];

	open (MAIL, "|/usr/lib/sendmail -t -f bruhwel\@jlab.org") 
	  or die "No mail today, can't open a pipe to sendmail";
	print MAIL "To: $add\n";
	print MAIL "Subject: $sys \n";
	print MAIL "Content-type: text/plain\n\n";
	print MAIL "$mes \n";

	close (MAIL);
#print "----------------------------------------\n";
#	print "To: $add\n";
#	print "Subject: $sys \n";
#	print "Content-type: text/plain\n\n";
#	print "$mes \n";
#	print "----------------------------------------\n";
}

sub logIt {
	$logMessage = $_[0];
	$logFile    = $DEFAULT_LOG; 

	$time = localtime();
	$logRecord = "$time\t$logMessage\n";

	open (LOGFILE, ">>$logFile")
	     or die "Can't open $logFile for appending";

	print LOGFILE $logRecord;	

	close (LOGFILE);

}


