#!/bin/env perl
#===============================================================================
# Author:	Krister Bruhwel
# Date:		July 2002
# Purpose:	page some sukka
#
#===============================================================================

use Getopt::Long;

$PRIMARY_ON_CALL  = "584-5245";

GetOptions("help", "h", "m=s", "pgNum=s@", "deb=s@");

#take care of command line flags and set defaults
if ($opt_help)   { printHelp(); exit(); }
if ($opt_h)      { printHelp(); exit(); }
if (!@opt_pgNum) { @opt_pgNum = ($PRIMARY_ON_CALL);}
if ($opt_m) { $message   = $opt_m; } else { print "need a message ...\n"; exit(); }

foreach $pagerNum (@opt_pgNum) {
	$pagerNum =~ s/\@page.metrocall.com//g;
	$pagerNum =~ s/757-//g;
	$pagerNum =~ s/^757//g;
	$pagerNum =~ s/-//g;
	$pagerNum = "757$pagerNum\@page.metrocall.com";

	mail ($pagerNum, $message);
	mail_author ($pagerNum, $message);

	print "Pager Number: \t$pagerNum\nMessage: \t$message\n\n";
	print "Job Complete.\n";

}

#in the end its all just email
#===============================================================================
sub mail {
        $add = $_[0];
        $mes = $_[1];

	open (MAIL, "|/usr/lib/sendmail -t -f bruhwel\@jlab.org")
	      or die "No mail today, can't open a pipe to sendmail";
	print MAIL "To: $add\n";
	print MAIL "Subject: Auto_Page \n";
	print MAIL "Content-type: text/plain\n\n";
	print MAIL "$mes \n";

	close (MAIL);
}

# help type stuff (ya right)
#===============================================================================
sub printHelp {
	print "\nsendOnCallMessage.pl -pgNum [number] -m [message]\n\n";
	print "Multiple -pgNum's can be used at once\n";
	print "If no -pgNum flag is used, it defaults to the oncall's number.\n\n";
	exit();
} 
sub mail_author {
        $add = $_[0];
        $mes = $_[1];

	open (MAIL, "|/usr/lib/sendmail -t -f bruhwel\@jlab.org")
	      or die "No mail today, can't open a pipe to sendmail";
	print MAIL "To: bruhwel\@jlab.org\n";
	print MAIL "Subject: Auto_Page Sent \n";
	print MAIL "Content-type: text/plain\n\n";
	print MAIL "sent [$mes] to [$add]\n";

	close (MAIL);
}

