#!/bin/env perl

#=============================================================================
# mk_req_frm_pager_alhConfig.pl 
# 
# Krister Bruhwel
# September 2002
#
# This script will make a burt req and snap file based off the pager alhConfig 
# file.
#
# Not for the average Joe so docs are week.  This is all ya need:
#
# run it and then rename the snap file for the set_oncall_pager.pl script.
#
#=============================================================================


$APP         = $ENV{APP};
$ALH_SOURCE  = "$APP/general/alh/oncall_pager/pager.alhConfig";
$REQ_FILE    = "onCallPager.req";
$SNAP_FILE   = "onCallPager.snap";

mk_req_file();

mk_snap_file();

print "\nall done.\n";


# SUB FUNCTIONS
# ###############################################################

sub mk_snap_file {
	print "\n\tmake a snap file? (y/n) ";
		
	$ans = <STDIN>;
	chomp ($ans);
	
	unless($ans =~ /y/i) {
		print "OK ... bailing\n";
		exit();
	}

	#  STDERR is piped to /dev/null because the req file has options
	#  that do not fit for every record type (known, OK errors).
  	#  It all works out, and the display is less confusing.  Look
	#  at em if ya want ... I just take a look-see at the snap file. 

	print "\n\t-> making $SNAP_FILE (piping STDERR to /dev/null)\n";
		
	open STDERR, '>/dev/null';
	
	`burtrb -f $REQ_FILE -o $SNAP_FILE`;

	close STDERR;
	
} 


sub mk_req_file {
	print "\n\tmake a req file? (y/n) ";
		
	$ans = <STDIN>;
	chomp ($ans);
		
	unless($ans =~ /y/i) {
		print "OK ... bailing\n";
		exit();
	}

	print "\n\t-> making $REQ_FILE\n";

	open (FILE, $ALH_SOURCE) or die "need the path to the alhConfig\n";
	@alh_file = <FILE>;
	chomp(@alh_file);
	close FILE;

	@lines = grep /sig=/, @alh_file;

	foreach $f (@lines) { 
		$f =~s/\$COMMAND  medm -x -attach -cmap -macro "sig=//g;
		$f =~ s/".* >> \/dev\/null.*$//g;

		push @sig_list, $f; 
	}

	open FILE, ">$REQ_FILE";
	
	@alarm_type = qw(HIHI HIGH LOW LOLO OSV ZSV);
	
	foreach $f (@sig_list) { 
		foreach $a (@alarm_type) { print FILE "$f.$a\n"; }
	}

	close FILE;

}

