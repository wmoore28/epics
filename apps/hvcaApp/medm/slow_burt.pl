#!/bin/env perl

use lib ("/home/freyberg/PERL/lib/perl5/site_perl/5.005/sun4-solaris/");
use Pezca; 

$snap_file = $ARGV[0];

open(IN, "< $snap_file");

$header = 1;
while(<IN>) {
    if ($header == 0) {
	chomp;
	($chan, $burt_on, $val) = split;
	$err = Pezca::PutDouble($chan,$val);
	if ($err) {
	    sleep 10;
	    print "$err\n";
	    $err = Pezca::PutDouble($chan,$val);
	}
	    
    }
    if (/--- End BURT header/) {
	$header = 0;
    }
}
