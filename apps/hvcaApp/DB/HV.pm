#!/bin/env perl

package HV;
$HV::Version="0.01";

require Exporter;
@ISA = qw(Exporter);
@EXPORT =qw(CREATE_RECORD GET_IOC GET_IOCS GET_MF GET_MF_TYPE PARSE_DAT CARD_SLOT GET_GRPS GET_MF_DET );

sub CREATE_RECORD {
    ($type, $name, $hash_ref) = @_;

    $str = "record($type, \"$name\") {\n";
    $f = 'DTYP';
    if (defined $$hash_ref{$f}) {
	$str .=  "   field($f,\"$$hash_ref{$f}\")\n";
	delete $$hash_ref{$f};
    }
    foreach $f (keys %$hash_ref) {
	$str .=  "   field($f,\"$$hash_ref{$f}\")\n";
    }
    $str .=  "}";
    return($str);
}

sub GET_IOC {
    ($ioc_ref) = @_;
    %ioc = %$ioc_ref;
    $index = 0;
    foreach $i (sort_hash_num(\%ioc)) {
	$ioc_sort{$ioc{$i}} = $ioc{$i};
    }
    foreach $i (keys %ioc_sort) {
	$ioc_array[$index] = $i;
	$index++;
    }
    if ($index > 1) {
	print "more than one IOC.....dying\n  :@ioc_array:!!!!\n";
	die;
    }
    return($ioc_array[0]);
}
sub GET_IOCS {
    ($ioc_ref) = @_;
    %ioc = %$ioc_ref;
    $index = 0;
    foreach $i (sort_hash_num(\%ioc)) {
	$ioc_sort{$ioc{$i}} = $ioc{$i};
    }
    foreach $i (keys %ioc_sort) {
	$ioc_array[$index] = $i;
	$index++;
    }
    return(@ioc_array);
}
sub GET_GRPS {
    ($grp_ref) = @_;
    %grp = %$grp_ref;
    $index = 0;
    foreach $i (sort_hash_num(\%grp)) {
	$grp_sort{$grp{$i}} = $grp{$i};
    }
    foreach $i (keys %grp_sort) {
	$grp_array[$index] = $i;
	$index++;
    }
    return(@grp_array);
}

sub GET_MF {
    ($mf_ref) = @_;
    %mf_addr = %$mf_ref;
    $index = 0;
    foreach $mf (sort_hash_num(\%mf_addr)) {
	$mf_sort{$mf_addr{$mf}} = $mf_addr{$mf};
    }
    foreach $mf (keys %mf_sort) {
#	$mf =~ s/^0//;
	$mf_array[$index] = $mf;
	$index++;
    }
    return(@mf_array);
}
    
sub PARSE_DAT {
    ($dat_file, $grp_ref, $allow_ref, , $ioc_ref, $mf_addr_ref, $slot_num_ref, $sub_mod_ref, $chan_num_ref, 
     $demand_v_ref, $mvdz_ref, $rup_ref, $rdn_ref, $tc_ref, $max_v_ref) = @_;

    open(IN, "< $dat_file");

    while(<IN>) {
	chomp;
	@line = split;
	
	$line[1] =~ s/^0+//;
	if ($line[1] < 10) {
	    $line[1] = '0'.$line[1];
	}
	$line[3] =~ s/^0+//;
	if ($line[3] < 10) {
	    $line[3] = '0'.$line[3];
	}
	$line[4] =~ s/^0+//;
	if ($line[4] < 10) {
	    $line[4] = '0'.$line[4];
	}
	$line[6] =~ s/^0+//;
	if ($line[6] < 10) {
	    $line[6] = '0'.$line[6];
	}

	$chan                 = $line[0];
	$$grp_ref{$chan}      = $line[1];
	$$allow_ref{$chan}    = $line[2];
	$$ioc_ref{$chan}      = $line[3];
	$$mf_addr_ref{$chan}  = $line[4];
	$$slot_num_ref{$chan} = $line[5];
	$$sub_mod_ref{$chan}  = $line[6];
	$$chan_num_ref{$chan} = $line[7];
	$$demand_v_ref{$chan} = $line[8];
	$$mvdz_ref{$chan}     = $line[9];
	$$mcdz_ref{$chan}     = $line[10];
	$$rup_ref{$chan}      = $line[11];
	$$rdn_ref{$chan}      = $line[12];
	$$tc_ref{$chan}       = $line[13];
	$$max_v_ref{$chan}    = $line[14];

    }
    return 1;
}

sub sort_hash_num { 
    my $x = shift; 
    my %array = %$x; 
    
    sort {$array{$b} <=> $array{$a}; } keys %array; 
} 

sub CARD_SLOT {
    ($mf, $slot, $chan, $cmd) = @_;

    %COMMAND = (
		NoSupport => 0x00, 
		G_Valid   => 0x80, 
		G_HV      => 0x81, 
		G_Alarm   => 0x82,
		S_CE      => 0x01, 
		S_DV      => 0x02, 
		S_RDN     => 0x03, 
		S_RUP     => 0x04, 
		S_TC      => 0x05, 
		S_MVDZ    => 0x06, 
		S_MCDZ    => 0x07, 
		S_HV      => 0x08, 
		S_SOT     => 0x09, 
		S_PRD     => 0x0A,
		S_CHHV    => 0x0B
		);
    
    $prm1 = $mf;
    $prm1 = $prm1 + ($slot << 8);
    
    $prm2 = $chan;
    $prm2 = $prm2 + ($COMMAND{$cmd} << 8);
    
    return($prm1, $prm2);
}



sub GET_MF_TYPE {
    ($mod_ref) = @_;
    %mod_addr = %$mod_ref;
    $index = 0;
    foreach $mod (sort_hash_num(\%mod_addr)) {
	$mod_sort{$mod_addr{$mod}} = $mod_addr{$mod};
    }
    foreach $mod (keys %mod_sort) {
#	$mf =~ s/^0//;
	$mod_array[$index] = $mod;
	$index++;
    }
    if ( $index > 1 )
      {
	print "Error: More than one type of modules in a file \n";
	print "Exiting... \n";
	exit 1;
      }
    else
      {
	if ( $mod_array[0] == 2 ) 
	  {
	    $mod_type = "LecroyHV" ;
	  }
	elsif ( $mod_array[0] == 3 )
	  {
	    $mod_type = "CAEN_HV" ;
	  }
	else
	  {
	    $mod_type = "UNKNOWN" ;
	  }
	return($mod_type) ;
      }
  }


sub GET_MF_DET {
  local ( $ioc_id, $mf_id ) = @_ ;

  if ( $ioc_id == 5 ) {
    if ( $mf_id <= 8 ) {
      $detector = "EC";
    }
    elsif ( $mf_id > 8 ) {
      $detector = "TOF";
    }
  }
  elsif( $ioc_id == 12 ) {
    if ( $mf_id <= 2 ) { # Old beam line devices pshv and tagthv
      $detector = "PHOTON" ;
    }
    elsif ( ($mf_id >= 3 && $mf_id <= 6) || ($mf_id >= 9 ) ) {
      $detector = "TOF";
    }
    elsif( $mf_id == 7 || $mf_id == 8 ) {
      $detector = "TAGGER";
    }
  } elsif( $ioc_id == 9 ) {
	  $detector = "LAC";
  } elsif( $ioc_id == 10 ) {
	  $detector = "DC";
  }
  elsif( $ioc_id == 1 ) { # Software IOC on clonpc2
    if ( $mf_id == 2 ) { # hvdvcs CAEN 1527
      $detector = "BEAM" ;
    } else { # hvec1, hvec2
      $detector = "EC CAEN" ;
    }
  }

  else{
    $detector = "unknown detector" ;
  }

  return $detector;
}


