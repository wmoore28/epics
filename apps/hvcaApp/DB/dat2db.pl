#!/bin/env perl

use HV;

$file = $ARGV[0];
if ($file =~ '.dat') {
    $dat_file = $file;
} else {
    $dat_file = "$file\.dat";
}

my %grp, %allow, %ioc, %mf_addr, %slot_num, %sub_mod, %chan_num, %demand_v, %mvdz, %rup, %rdn, %tc, %max_v;

$ok = &PARSE_DAT($dat_file, \%grp, \%allow, \%ioc, \%mf_addr, \%slot_num, \%sub_mod, \%chan_num, \%demand_v, \%mvdz, \%rup, \%rdn, \%tc, \%max_v);

$ioc_ident = &GET_IOC(\%ioc);
@mf_ids = &GET_MF(\%mf_addr);

$mf_type = &GET_MF_TYPE( \%sub_mod );


foreach $mf (@mf_ids) {

    close(OUT);
    $db_file = $dat_file;
    $db_file = "$file\_$mf\.db";
    open(OUT, "> $db_file");

    $mf_det = &GET_MF_DET( $ioc_ident, $mf );


#main frame cmd 
    ($prm1, $prm2)  = &CARD_SLOT($mf, 0, 0, 'S_HV');
    
    %rec_hash = (DESC => 'binary output record',
		 SCAN => 'Passive',
		 DTYP => "$mf_type",
		 OUT  => "\#C$prm1 S$prm2",
		 ZNAM => 'HV/OFF',
		 ONAM => 'HV/ON',
		 OMSL => 'supervisory'
		 );
    $name = "B_HVON_SET_$ioc_ident\_$mf";
    $seting_name = $name ;
    $rec = &CREATE_RECORD('bo',$name, \%rec_hash);
    print OUT "$rec\n";


    ($prm1, $prm2)  = &CARD_SLOT($mf, 0, 0, 'G_Valid');
    
    %rec_hash = (DESC => 'binary input record ',
		 SCAN => '2 second',
		 DTYP => "$mf_type",
		 INP  => "\#C$prm1 S$prm2",
		 ZNAM => 'NOT VALID',
		 ONAM => 'VALID',
		 OSV  => 'NO_ALARM',
		 ZSV  => 'MAJOR'
		 );
    $name = "B_HVVALID_$ioc_ident\_$mf";
    $rec = &CREATE_RECORD('bi',$name, \%rec_hash);
    print OUT "$rec\n";


    ($prm1, $prm2)  = &CARD_SLOT($mf, 0, 0, 'G_Alarm');
    
    %rec_hash = (DESC => 'binary input record',
		 SCAN => '2 second',
		 DTYP => "$mf_type",
		 INP  => "\#C$prm1 S$prm2",
		 ZNAM => 'enabled',
		 ONAM => 'disabled',
		 OSV => 'MAJOR',
		 ZSV => 'NO_ALARM'
		 );
    $name = "B_HVALARM_$ioc_ident\_$mf";
    $rec = &CREATE_RECORD('bi',$name, \%rec_hash);
    print OUT "$rec\n";


    ($prm1, $prm2)  = &CARD_SLOT($mf, 0, 0, 'G_HV');
    
    %rec_hash = (DESC => 'binary input record',
		 SCAN => '2 second',
		 DTYP => "$mf_type",
		 INP  => "\#C$prm1 S$prm2",
		 ZNAM => 'HV/OFF',
		 ONAM => 'HV/ON'
		 );
    $name = "B_HVSTATUS_$ioc_ident\_$mf";
    $status_name = $name ;
    $rec = &CREATE_RECORD('bi',$name, \%rec_hash);
    print OUT "$rec\n";
#
#   CALC record to compare HVSET and HVGET 
#
    %rec_hash = (SCAN => '1 second',
		 CALC => 'ABS(A-B)',
		 INPA => "$status_name NPP NMS",
		 INPB => "$seting_name NPP NMS",
		 HIHI => '0.1',
		 HIGH => '0.1',
		 LOW  => '-0.1',
		 LOLO => '-0.1',
		 HHSV => 'MAJOR',
		 HSV  => 'MAJOR',
		 LSV  => 'MAJOR',
		 LLSV => 'MAJOR'
		 );
    $name = "B_HVOC_$ioc_ident\_$mf";
    $rec = &CREATE_RECORD('calc',$name, \%rec_hash);
    print OUT "$rec\n";

    #
    #   Generate ALH config file for mainframes.
    #

    $mf_alh_file_name = "$file"."_mf_$mf"."_$ioc_ident"."\.alhConfig_mf" ;

    open( MF_ALH_FILE,  "> $mf_alh_file_name" );

    print MF_ALH_FILE "CHANNEL  HV_mf   B_HVVALID_$ioc_ident"."_$mf \n" ;
    print MF_ALH_FILE "\$GUIDANCE\nMainframe $mf for $mf_det is not respoding. Call detector expert !\n\$END\n" ;
#    print MF_ALH_FILE "\$GUIDANCE\nMainframe $mf on IOC $ioc_ident is not respoding. Call detector expert !\n\$END\n" ;

    print MF_ALH_FILE "CHANNEL  HV_mf   B_HVOC_$ioc_ident"."_$mf \n" ;
    print MF_ALH_FILE "\$GUIDANCE\nStatus of HV mainframe $mf for $mf_det is different from what is set in EPICS GUI.\n" ;
#    print MF_ALH_FILE "\$GUIDANCE\nStatus of HV mainframe $mf on IOC $ioc_ident is different from what is set in EPICS GUI.\n" ;
    print MF_ALH_FILE "It may have tripped or its status was changed. Try to turn it ON or OFF in HV GUI. \n" ;
    print MF_ALH_FILE "If it does not help, call detector expert !\n\$END\n";

    close ( MF_ALH_FILE );

    #
    #  Finished make MF status ALH file
    #
    if ( $mf_type == "CAEN_HV" )
      {
	$HV_PREC = 3;
      }
    else
      {
	$HV_PREC = 0;
      }

    foreach $c (keys %grp) {
	if ($mf_addr{$c} == $mf) {
	    ($prm1, $prm2)  = &CARD_SLOT($mf_addr{$c}, $slot_num{$c}, $chan_num{$c}, 'S_CE');
	    $name = "B_hv_$c\_CE";
	    %rec_hash = (DESC => 'binary output record',
			 SCAN => 'Passive',
			 DTYP => "$mf_type",
			 OUT  => "\#C$prm1 S$prm2",
			 ZNAM => 'OFF',
			 ONAM => 'ON',
			 PRIO => 'LOW',
			 OMSL => 'supervisory'
			 );
	    $rec = &CREATE_RECORD('bo',$name, \%rec_hash);
	    print OUT "$rec\n";
	    
	    ($prm1, $prm2)  = &CARD_SLOT($mf_addr{$c}, $slot_num{$c}, $chan_num{$c}, 'S_CHHV');
	    $name = "B_hv_$c\_CHHV";
	    %rec_hash = (DESC => 'binary output record',
			 SCAN => 'Passive',
			 DTYP => "$mf_type",
			 OUT  => "\#C$prm1 S$prm2",
			 ZNAM => 'OFF',
			 ONAM => 'ON',
			 PRIO => 'LOW',
			 OMSL => 'supervisory'
			 );
	    $rec = &CREATE_RECORD('bo',$name, \%rec_hash);
	    print OUT "$rec\n";
	    
	    ($prm1, $prm2)  = &CARD_SLOT($mf_addr{$c}, $slot_num{$c}, $chan_num{$c}, 'S_DV');
	    $name = "B_hv_$c\_DV";
	    %rec_hash = (DESC => 'analog output record',
			 SCAN => 'Passive',
			 DTYP => "$mf_type",
			 OUT  => "\#C$prm1 S$prm2",
			 PRIO => 'LOW',
			 OMSL => 'supervisory',
			 PREC => "$HV_PREC"
			 );
	    $rec = &CREATE_RECORD('ao',$name, \%rec_hash);
	    print OUT "$rec\n";
	    
	    ($prm1, $prm2)  = &CARD_SLOT($mf_addr{$c}, $slot_num{$c}, $chan_num{$c}, 'S_RDN');
	    $name = "B_hv_$c\_RDN";
	    %rec_hash = (DESC => 'analog output record',
			 SCAN => 'Passive',
			 DTYP => "$mf_type",
			 OUT  => "\#C$prm1 S$prm2",
			 PRIO => 'LOW',
			 OMSL => 'supervisory'
			 );
	    $rec = &CREATE_RECORD('ao',$name, \%rec_hash);
	    print OUT "$rec\n";
	    
	    ($prm1, $prm2)  = &CARD_SLOT($mf_addr{$c}, $slot_num{$c}, $chan_num{$c}, 'S_RUP');
	    $name = "B_hv_$c\_RUP";
	    %rec_hash = (DESC => 'analog output record',
			 SCAN => 'Passive',
			 DTYP => "$mf_type",
			 OUT  => "\#C$prm1 S$prm2",
			 PRIO => 'LOW',
			 OMSL => 'supervisory'
			 );
	    $rec = &CREATE_RECORD('ao',$name, \%rec_hash);
	    print OUT "$rec\n";

	    ($prm1, $prm2)  = &CARD_SLOT($mf_addr{$c}, $slot_num{$c}, $chan_num{$c}, 'S_TC');
	    $name = "B_hv_$c\_TC";
	    %rec_hash = (DESC => 'analog output record',
			 SCAN => 'Passive',
			 DTYP => "$mf_type",
			 OUT  => "\#C$prm1 S$prm2",
			 PRIO => 'LOW',
			 OMSL => 'supervisory'
			 );
	    $rec = &CREATE_RECORD('ao',$name, \%rec_hash);
	    print OUT "$rec\n";
	    
	    ($prm1, $prm2)  = &CARD_SLOT($mf_addr{$c}, $slot_num{$c}, $chan_num{$c}, 'S_MVDZ');
	    $name = "B_hv_$c\_MVDZ";
	    %rec_hash = (DESC => 'analog output record',
			 SCAN => 'Passive',
			 DTYP => "$mf_type",
			 OUT  => "\#C$prm1 S$prm2",
			 PRIO => 'LOW',
			 OMSL => 'supervisory'
			 );
	    $rec = &CREATE_RECORD('ao',$name, \%rec_hash);
	    print OUT "$rec\n";
	    
	    ($prm1, $prm2)  = &CARD_SLOT($mf_addr{$c}, $slot_num{$c}, $chan_num{$c}, 'S_MCDZ');
	    $name = "B_hv_$c\_MCDZ";
	    %rec_hash = (DESC => 'analog output record',
			 SCAN => 'Passive',
			 DTYP => "$mf_type",
			 OUT  => "\#C$prm1 S$prm2",
			 PRIO => 'LOW',
			 OMSL => 'supervisory'
			 );
	    $rec = &CREATE_RECORD('ao',$name, \%rec_hash);
	    print OUT "$rec\n";
	    
	    $name = "B_hv_$c\_property";
	    %rec_hash = (DESC => 'big subroutine record',
			 SCAN => '2 second',
			 INAM => 'InitChannel',
			 SNAM => 'ScanChannel',
			 INPA => $mf_addr{$c},
			 INPB => $slot_num{$c},
			 INPC => $chan_num{$c},
			 HSV  => 'MAJOR',
			 HIGH => '10',
			 PRIO => 'LOW', 
			 PREC => "$HV_PREC"
			 );
	    $rec = &CREATE_RECORD('bigsub',$name, \%rec_hash);
	    print OUT "$rec\n";
	}
    }
}
