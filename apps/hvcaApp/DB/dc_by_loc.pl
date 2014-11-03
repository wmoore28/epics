#!/bin/env perl

use HV;

$dat_file = "dc.dat";

my (%grp, %allow, %ioc, %mf_addr, %slot_num, %sub_mod, %chan_num, %demand_v, %mvdz, %rup, %rdn, %tc, %max_v);

$ok = &PARSE_DAT($dat_file, \%grp, \%allow, \%ioc, \%mf_addr, \%slot_num, \%sub_mod, \%chan_num, \%demand_v, \%mvdz, \%rup, \%rdn, \%tc, \%max_v);

@mf_ids = &GET_MF(\%mf_addr);

# --- create the group file

open(OUT,">dc_by_loc.grp");
$i=0;
foreach $mf (@mf_ids) {
    $i++;
    print OUT "$i dc_mf_${mf}\n";
}
close(OUT);

# --- create the data file

open(OUT,">dc_by_loc.dat");
$i=0;
foreach $mf (@mf_ids) {
    $i++;
    foreach $slot (0..9){
	$j=0;
	foreach $chan (0..23){
	    while (($key, $value) = each(%mf_addr)){
		if ($value==$mf && $slot==$slot_num{$key} && $chan==$chan_num{$key}){
#		print "key = $key value = $value == mf  = $mf && slot = $slot == slot_num = $slot_num{$key} && chan = $chan== chan_num $chan_num{$key} \n";
		    print OUT "$key $i ";
#		    print OUT "DC_mf${mf}_sl${slot}_ch${chan} $i "; # does not work because we don't have separate db for this medm configuration
		    print OUT "$allow{$key} ";
		    print OUT "$ioc{$key} ";
		    print OUT "$mf_addr{$key} ";
		    print OUT "$slot_num{$key} ";
		    print OUT "$sub_mod{$key} ";
		    print OUT "$chan_num{$key} ";
		    print OUT "$demand_v{$key} ";
		    print OUT "$mvdz{$key} ";
		    print OUT "$rup{$key} ";
		    print OUT "$rdn{$key} ";
		    print OUT "$tc{$key} ";
		    print OUT "$max_v{$key} ";
		    print OUT "\n";
		    $j++;
		    print "mf = $mf slot = $slot\n";
		}
	    }
	    if ($chan>=$j){ # print the missing channels
		($key, $value) = each(%mf_addr);
		print OUT "DC_mf${mf}_sl${slot}_ch${chan} $i ";
		print OUT "00000 ";
		print OUT "$ioc{$key} ";
		print OUT "$mf ";
		print OUT "$slot ";
		print OUT "$sub_mod{$key} ";
		print OUT "$chan ";
		print OUT "$demand_v{$key} ";
		print OUT "$mvdz{$key} ";
		print OUT "$rup{$key} ";
		print OUT "$rdn{$key} ";
		print OUT "$tc{$key} ";
		print OUT "$max_v{$key} ";
		print OUT "\n";
		$j++;
	    }
	}
    }
}

close(OUT);
