#!/bin/env perl
$file_arg = $ARGV[0];
$group_arg = $ARGV[1];
$change_arg = $ARGV[2];
open(INPUT, "$file_arg.dat");
$nmf = 0;
$ncard = 0;
$nrec = 0;
while ($line=<INPUT>) {
    $nrec++;
    chop($line);
    @field = split(/\s+/,$line);
    $label = @field[0];
    $group = @field[1];
    $enable = @field[2];
    $arcnet = @field[3];
    $mainframe = @field[4];
    $slot = @field[5];
    $sub = @field[6];
    $channel = @field[7];
    $demand_voltage = @field[8];
    $pv = "B_hv_$label";
    if ($group == $group_arg) {
	$caget = `caget $pv.DVI`;
	print $caget;
        chop($caget);
	@gfield = split(/\s+/,$caget);
	$oldv = $gfield[1];
	if ($oldv == 0) {
	    print "$pv is zero. No change made.\n";
	}
	else {		        
	    if ($oldv > 0) {
		$newv = $oldv + $change_arg;
	    }
	    else {
		$newv = $oldv - $change_arg;
	    }
	    if ($oldv*$newv < 0) {
		print "Requested change would change sign of $pv. No change made.\n";
	    }
	    else {
		$caput = `caput $pv.DVO $newv`;
		print $caput;
		sleep 1;
	    }
	}
    }
}				# while
close(INPUT);
