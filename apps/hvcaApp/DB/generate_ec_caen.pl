#!/bin/env perl

unlink("ec_caen.dat");
open(OUT,">ec_caen.dat");

$group=0;
$mf=4;
$slot=8;
$ch=0;


for $group (2..2) {
    $fn="ec".$group.".dat";
    open(DAT,$fn );
    while ($line = <DAT>){
	chop($line);
	print "$line\n";
	($name,$rest) = split/ /,$line;
#	$name =~ s/_//g;
	if ($slot<16) {
	    printf OUT "%s      %02d 1 01 %02d %02d 03 %02d -1548.0   1.5   1.3    61.0    61.0 -2550.0 -2500.0\n"
		,$name,$group,$mf,$slot,$ch;
	}
	$ch++;
	if ($ch==24) {
		$ch=0;
		$slot++;
	}
	if ($slot==16){
		$slot=0;
		$mf++;
	}
    }
    close(DAT);
}
close(OUT);
