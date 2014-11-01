#!/usr/bin/env perl

use HV;
use POSIX qw(strftime);

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
$req_list = '';
foreach $mf (@mf_ids) {
    foreach $ioc_ident (@ioc_ids) {
	foreach $grp_ident (@grp_ids) {
	    foreach $c (keys %grp) {
		if ($mf_addr{$c} == $mf && $ioc{$c} == $ioc_ident && $grp{$c} == $grp_ident) {
		    $req_list .= "B_hv_$c\_CE 1 ON\n";
		    $req_list .= "B_hv_$c\_DV 1 $demand_v{$c}\n";
		    $req_list .= "B_hv_$c\_RDN 1 $rup{$c}\n";
		    $req_list .= "B_hv_$c\_RUP 1 $rdn{$c}\n";
       		    $req_list .= "B_hv_$c\_TC 1 $tc{$c}\n";
		}
	    }
	}
    }
}

$now_string = strftime "%Y%m%d_%H:%M:%S", localtime;
$FILE = uc $file;
$snap_file = "~epics/burt/HV/$FILE/${FILE}_${now_string}.snap\n";
#$snap_file = "./${FILE}_${now_string}.snap";
$now_string = strftime "%a %b %e %H:%M:%S %Y", localtime;
open(SNAP, "> ../snap/$snap_file");

print SNAP "--- Start BURT header\n";
print SNAP "Time: $now_string\n";
$user=$ENV{USER};
($name, $pass, $uid, $gid, $quota, $comment, $gcos, $dir, $shell, $expire) = getpwnam($user);
print SNAP "Login ID: $user ($comment)\n";
print SNAP "Eff  UID: $uid\n";
print SNAP "Group ID: $gid\n";
print SNAP "Keywords:\n";
print SNAP "Comments:\n";
print SNAP "Type:     Absolute\n";
print SNAP "Directory $ENV{APP}/apps/medm\n";
print SNAP "Req File: $ENV{APP}/hvcaApp/req/${file}_all.req\n";
print SNAP "--- End BURT header\n";
print SNAP "$req_list";
close(SNAP);

