#!/bin/env perl

# must be executed from clon10 as clasrun
use lib ("/home/epics/PERL/lib/perl5/site_perl/5.005/sun4-solaris/");
use Pezca; 

open(EC5, "<ec5_mf5.dat");

while(<EC5>) {
    chop;
    @line = split;
    $rec = 'B_hv_'.$line[0].'.DVO';
    $dmv = $line[8];

    print "rec: $rec dmv $dmv\n";
    $errcode = Pezca::PutDouble($rec,   $dmv);
    $enable = 'B_hv_'.$line[0].'.CEO';
    $errcode = Pezca::PutDouble($enable,   1);
}






