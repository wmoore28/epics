#!/bin/env perl

use HV;

$file = $ARGV[0];
if ($file =~ '.dat') {
    $dat_file = $file;
    $file =~ s/\.dat$//;
} else {
    $dat_file = "$file\.dat";
}

my %grp, %allow, %ioc, %mf_addr, %slot_num, %sub_mod, %chan_num, %demand_v, %mvdz, %rup, %rdn, %tc, %max_v;

$ok = &PARSE_DAT($dat_file, \%grp, \%allow, \%ioc, \%mf_addr, \%slot_num, \%sub_mod, \%chan_num, \%demand_v, \%mvdz, \%rup, \%rdn, \%tc, \%max_v);

@ioc_ids = &GET_IOCS(\%ioc);
@mf_ids = &GET_MF(\%mf_addr);
@grp_ids = &GET_GRPS(\%grp);

$n_req_files = 0;
foreach $mf (@mf_ids) {
    foreach $ioc_ident (@ioc_ids) {
	foreach $grp_ident (@grp_ids) {

	    $ifound = 0;
	    $req_list = '';
	    foreach $c (keys %grp) {
		if ($mf_addr{$c} == $mf && $ioc{$c} == $ioc_ident && $grp{$c} == $grp_ident) {
		    $ifound++;

		    $name = "B_hv_$c\_CE";
		    $req_list .= "$name\n";

		    $name = "B_hv_$c\_DV";
		    $req_list .= "$name\n";
		    
		    $name = "B_hv_$c\_RDN";
		    $req_list .= "$name\n";
	    
		    $name = "B_hv_$c\_RUP";
		    $req_list .= "$name\n";
	    
		    $name = "B_hv_$c\_TC";
		    $req_list .= "$name\n";
		}
	    }
	    if ($ifound) {
		$req_file = "$file\_grp$grp_ident\_ioc$ioc_ident\_mf$mf\.req";
		$file_list[$n_req_files] = $req_file;
		$n_req_files++;

		open(REQ, "> ../req/$req_file");
		$req_list =~ s/^\s+$//;
		print REQ "$req_list";
		close(REQ);
	    }
	}
    }
}

# now write the system all file.

$req_file = "../req/$file\_all.req";
open(REQ, "> $req_file");
foreach $rf (@file_list) {
    print REQ "#include \"$rf\"\n";
}
close(REQ);
