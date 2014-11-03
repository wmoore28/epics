#!/bin/env perl

# convert snap file to ec?.dat file

for ($i=1; $i<7; $i++) {
    $snap_file = 'ec'.$i.'.snap';
    $dat_file = 'ec'.$i.'.dat';
    open(SNAP, "<../snap/$snap_file");
    open(DAT, "<../db/$dat_file");
    open(NEW_DAT, ">$dat_file");

    while (<SNAP>) {
	chomp;
	s/^\s+//;
	($chan, $dvo) = split;
	$DVO{$chan} = $dvo;
    }
    close(SNAP);
    while (<DAT>) {
	chomp;
	s/^\s+//;
	@line = split;
	$chan = 'B_hv_'.$line[0].'.DVO';
	print "$chan old: $line[8]  new: $DVO{$chan} \n";
	$line[8] = $DVO{$chan};
	print NEW_DAT "@line\n";
    }
    close(DAT);
    close(NEW_DAT);
    if ($i == 5) {
	open(DAT, "<../db/ec5_mf5.dat");
	open(NEW_DAT, "> ec5_mf5.dat");
	while (<DAT>) {
	    chomp;
	    s/^\s+//;
	    @line = split;
	    $chan = 'B_hv_'.$line[0].'.DVO';
	    $line[8] = $DVO{$chan};
	    print NEW_DAT "@line\n";
	}
	close(DAT);
    }
}
