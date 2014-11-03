#!/bin/env perl
$file_arg = $ARGV[0];
$group_arg = $ARGV[1];
$voltage_arg = $ARGV[2];
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
    $pv = "B_hv_$label"."_DV";
    if ($group == $group_arg) {
	$caput = `caput $pv $voltage_arg`;
	print $caput;	
        sleep 1;
    }
}				# while
close(INPUT);
