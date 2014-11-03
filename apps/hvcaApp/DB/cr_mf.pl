#!/bin/env perl 

# Clean up the output files.
$fdat="cr_mf.dat";
$fgrp="cr_mf.grp";
unlink $fdat, $fgrp;

# Global variables
$grp=0;
@mf_list = ();

#---------------------------------------------------------------#
# Don't touch anything above this if unsure that you are doing. #
#---------------------------------------------------------------#

#Usage: make_mf(ARCNET#,"list of cards installed");
#Example: make_mf(1,"1 2 3 7-12");
# NOTE: Must be only one call to make_mf per mainframe.

# make_mf(1,"2-5");
# make_mf(1,"0 1 6 7");
# make_mf(1,"8-11");
# make_mf(1,"12-15");     <----- till Oct. 23, 2008;  -> FC.lecroyhv7
# make_mf(2,"0 2 4-6 8 9"); <--- till Jan. 18, 2009;  B51465 -> lecroyhv9
# make_mf(2,"2 3 4");   <-------      Feb. 18, 2009;  B67561 from REPAIR
# make_mf(2,"0-15");    <-------      Mar. 04, 2009;  B67561 full test
# make_mf(2,"0-10");    <-------      Mar. 06, 2009;  B67561 2/3 test
# make_mf(2,"0 1");     <-------      Mar. 13, 2009;  B67561 2*1461P loaded
# make_mf(2,"0-9");     <-------      Apr. 08, 2009;  B52331 from REPAIR
make_mf(2,"0-8");    ###<-------      Dec. 06, 2010;  one spare -> TOF
# make_mf(3,"3 6");  <---------- till June 20, 2008;  3 & 6 -> cr.5
# make_mf(3,"3 6");       <----- till Oct. 23, 2008;  -> FC.lecroyhv1
# make_mf(4,"4 8");  <---------- till June 20, 2008;  4 -> cr.5
# make_mf(4,"8");    <---------- till July 10, 2008;  8 going to REPAIR
# make_mf(5,"1 2 5 10");  <----- till June 20, 2008;  5 & 10 -> cr.3
# make_mf(5,"1 2 3 4 6"); <----- till July 10, 2008;  1 going to REPAIR
# make_mf(5,"2 3 4 6");   <----- till July 17, 2008;  B50123 -> 1
# make_mf(5,"1 2 3 4 6"); <-----      July 17, 2008;  B50123 back to REPAIR
# make_mf(5,"2 3 4 6");   <----- till Jan. 18, 2009;  B52361->lecroyhv9->UVC
# make_mf(5,"0-15");       <----      Feb. 13, 2009;  B52348 from REPAIR
# make_mf(5,"0-10");       <----      Mar. 04, 2009;  B52348 2/3 test
# make_mf(5,"0-5 11-15");  <----      Mar. 06, 2009;  B52348 2/3 test
# make_mf(5,"0-8 11-15");  <----      Mar. 13, 2009;  B52348 look for bad 1461
make_mf(5,"0 1");    ###<-------      Apr. 08, 2009;  B52348 2*1461N loaded
# make_mf(7,"14");      <-------      Feb. 13, 2009;  B11885 from REPAIR
# make_mf(7,"0 1");     <-------      Mar. 04, 2009;  B11885 test 2*1461P
# make_mf(7,"0-10");    <-------      Mar. 13, 2009;  B11885 2/3 test
# make_mf(7,"0-15");    <-------      Apr. 08, 2009;  B52342 from REPAIR
# make_mf(7,"0-7");     <-------      June 15, 2010;  look for Hung HV Card
# make_mf(7,"8 9 12-15");  <----      July 06, 2010;  still look: no beeps
# make_mf(7,"6-9 12-14");  <----      July 28, 2010;  still look: beeps
# make_mf(7,"7-9 12-14");  <----      Aug. 03, 2010;  still look: some beeps
# make_mf(7,"6 8 9 12-14");<----      AugXS. 03, 2010;  still look: some beeps
make_mf(7,"1-14");   ###<-------      Aug. 06, 2010;  all 1461 B67561->B52361
make_mf(4,"2 3");    ###<-------      Feb. 15, 2011;  B52345 w.B49911,B51507

print "--------------------------------------------------------\n";
#---------------------------------------------------------------#
# Don't touch anything below this if unsure that you are doing. #
#---------------------------------------------------------------#
sub make_mf{
    ($mf,$cards) = @_;
    $grp++; # group numbers are sequential numbers starting from 1
    print "--------------------------------------------------------\n";

    # check if mainframe already used, then warn and skip
    foreach my $i (@mf_list) {
	if ($i == $mf ) { 
	    print "Warning: Duplicate Mainframe id. Skipping generation of data for this mf_id = $mf\n"; 
	    return;
	};
    }
    push (@mf_list, $mf); # add this MF to the list for further comparisions

    print "group = $grp mf = $mf cards = '$cards' mf_list = @mf_list\n";

    # write group information file
    open(GRP,">>$fgrp");
    print GRP "$grp CR_$mf\n";
    close(GRP);

    # write channel information file
    open(DAT,">>$fdat");
    $_ = expand_numbers("$cards"); # expand x-y kind of sequences
    @cards = split(' ',$_);
    for $card (@cards){
	print "\tcard = $card cards = @cards\n";
	print DAT "CR${mf}_${card}_$_             $grp 1 99  $mf $card 02 $_ -2200.0   1.5   1.3   121.5   486.0 -2550.0 -2500.0\n" 
	    foreach qw(00 01 02 03 04 05 06 07 08 09 10 11); # assuming all boards have 12 channels
    }
    close(DAT);
}
#--------------------------------------------------------
sub expand_numbers{
    $out ="";
    $_ = join(' ',@_);
#    print "expand_numbers() \$_ = $_\n";
    for ( split(' ',$_) ){
	if (!/-/) { # if just a single  number then append to output string
	    $out .= sprintf(" %02d", $_);
	} else { # if x-y number then expand the list from x to y
	    ($x1, $x2) = split(/-/);
	    foreach $x ($x1..$x2){
		$out .= sprintf(" %02d", $x);
	    }
	}
    }
#    print "expand_numbers() output = $out\n";
    return $out;
}

