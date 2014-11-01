#!/bin/env perl

use Pezca; 

foreach $file (@ARGV) {
open(DAT, "< $file");

while(<DAT>) {
    chop;
    @line = split;
    $rec = 'B_hv_'.$line[0].'_DV';
    $rec_rbck = 'B_hv_'.$line[0].'_property.G';
    $dmv = $line[8];

    ($errcode, $dmv_rbck) = Pezca::GetDouble($rec_rbck);
    ($errcode, $dmv_setv) = Pezca::GetDouble($rec);
    $diff = $dmv - $dmv_rbck;
    if (abs($diff) > 5) {
	print "$rec Dat value: $dmv  Set value: $dmv_setv  ReadBack value: $dmv_rbck\n";
	$errcode = Pezca::PutDouble($rec, $dmv);
    }
    if ($dmv_rbck == 0) {
	print "$rec 0000 Dat value: $dmv  Set value: $dmv_setv  ReadBack value: $dmv_rbck 0000\n";
	$errcode = Pezca::PutDouble($rec, $dmv);
    }
}
}



























