#!/bin/env perl

use Pezca;

@sc_files = ("$ENV{APP}/hvca/db/sc_south.dat",
	     "$ENV{APP}/hvca/db/sc_north.dat",
	     "$ENV{APP}/hvca/db/sc_space.dat");

$A_or_B = $ARGV[0];
$ON_or_OFF = $ARGV[1];

if ($ON_or_OFF =~ /off/) {
    $value = 0;
} else {
    $value = 1;
}

if ($A_or_B eq A) {
    $end = 'A';
} else {
    $end = 'B';
}
foreach $f (@sc_files) {
    open(IN, $f);
    while(<IN>) {
	if (/4\d$end/) {
	    @line = split;
	    $channel = 'B_hv_'.$line[0].'_CE';
	    $error = Pezca::PutDouble($channel, $value);
	    print "$channel $value\n";
	}
    }
    close IN;
}
