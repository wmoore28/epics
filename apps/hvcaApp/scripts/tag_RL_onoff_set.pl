#!/bin/env perl

use Pezca;

@sc_files = ("$ENV{APP}/hvca/db/tagger_t.dat");

$R_or_L = $ARGV[0];
$hv     = $ARGV[1];

if ($R_or_L eq R) {
    $end = 'R';
} else {
    $end = 'L';
}
foreach $f (@sc_files) {
    open(IN, $f);
    while(<IN>) {
	if (/\d\d$end/) {
	    @line = split;
	    $channel = 'B_hv_'.$line[0].'_DV';
	    $error = Pezca::PutDouble($channel, $hv);
	    print "$channel $hv\n";
	    $channel = 'B_hv_'.$line[0].'_CE';
	    $error = Pezca::PutDouble($channel, 1);
	    print "$channel  ON\n";
	} else {
	    @line = split;
	    $channel = 'B_hv_'.$line[0].'_CE';
	    $error = Pezca::PutDouble($channel, 0);
	    print "$channel  OFF\n";
	}
    }
    close IN;
}
