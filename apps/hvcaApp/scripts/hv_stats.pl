#!/bin/env perl

# perl script to check switch_print IOC output to check HV problems
# the log file (ARGV[0]) should be created with the 
#                     $EPICSB/scripts/catch_colsole.pl [IOC]  
# script (running on clon10 as clasrun).  The HV "switch_print" command 
# should be executed on the IOC before creating the logfile.

open(IN, "< $ARGV[0]");

$n_reply = 0;
$n_send = 0;
$min_mf = 99;
$max_mf = -1;
while(<IN>) {
    chop;
    if (/analyse_reply/) {
	$n_reply++;
	@line = split;
	$cmd = $line[5];
	$slot = $line[6];
	$func = $line[7];
#	if ($reply) {
#	    print "TWO replys without SEND!!!!! $cmd $slot $func\n";
#	}
  	$reply = 1;
    } elsif (/send_command_main/) {
	$n_send++;
	@line = split;
	($junk,$cmd) = split(/=/,$line[3]);
	$slot = $line[4];
	$func = $line[5];
#	if ($send) {
#	    print "TWO sends without REPLY!!!!! $mf $cmd $slot $func\n";
#	}
	$send= 1;
    } else {
	$reply = 0;
	$send = 0;
    }
    if (($reply || $send) && !($cmd =~ /^GS/)) {
	($junk,$mf) = split(/=/,$line[2]);
	if (defined $mf) {
	    if ($mf > $max_mf && $mf <= 15) {
		$max_mf = $mf;
	    }
	    if ($mf < $min_mf && $mf >= 0) {
		$min_mf = $mf;
	    }
	    $n_dest[$mf]++;
	    
	    $index = $cmd.'_'.$slot.'_'.$func;
	    $stat{$index}++;
	    $slot =~ s/^\w//;
	    if ($cmd =~ /RC/) {
		$rc_cmds[$mf][$slot] = $rc_cmds[$mf][$slot]+1;
	    }
	    if ($cmd =~ /PS/) {
		$ps_cmds[$mf][$slot] = $ps_cmds[$mf][$slot]+1;
	    }
#	print "$reply\:$send mf: $mf $n_dest[$mf]  $index $stat{$index} \n";
	}
    }
}

foreach $cmd (sort_hash_num(\%stat)) {
    print "$cmd  $stat{$cmd} \n";
}

for $i (0..$#ps_cmds) {
    for $j (0..$#{$ps_cmds[$i]} ) {
	print "PS commands for mainframe:slot :$i:$j $ps_cmds[$i][$j] \n";
    }
}
print "\n";
for $i (0..$#rc_cmds) {
    for $j (0..$#{$rc_cmds[$i]} ) {
	print "RC commands for mainframe:slot :$i:$j $rc_cmds[$i][$j] \n";
    }
}
#print "\n";
#print "min:$min_mf max:$max_mf\n";
#for $i ($min_mf..$max_mf) {
#    for $j (0..15) {
#	if ($rc_cmds[$i][$j] + $ps_cmds[$i][$j]) {
#	    $asym = $ps_cmds[$i][$j]/($rc_cmds[$i][$j] + $ps_cmds[$i][$j]);
#	} else {
#	    $asym = 0.5;
#	}
#	print "PS/(RC+PS) for mainframe:slot :$i:$j $asym \n";
#    }
#}

sub sort_hash_num {
    my $x = shift;
    my %array = %$x;

    sort {$array{$b} <=> $array{$a}; } keys %array;
}
