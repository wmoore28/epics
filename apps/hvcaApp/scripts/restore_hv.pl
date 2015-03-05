#!/bin/env perl

#
#  Script to launch "burtgooey" to restore the  
#   HV for a whole detector ( EC, CC, TOF, BEAM, Tagger, Photon )
#   Expects 1 argument - name of the detector 
#

use Tk;

if ( @ARGV < 1 ) 
  {
    print "Error: No detector component given ! \n";
    print "Exiting now !!! \n" ;
    exit (1);
  }
elsif ( @ARGV > 1 )
  {
    print "Error: Too many detector components given ! \n";
    print "Exiting now !!! \n" ;
    exit (2);    
  }

#
#  Get the detector name and change it to uppeccase
#
$det2restore = $ARGV[0] ;
$det2restore =~ tr/a-z/A-Z/ ;

print "You are Restoring HV values for $det2restore \n"; 
print "Make sure You know what you are doing ! \n" ;

#print "Will Restore HV values for $det_nam \n"; 

#$SnapDir = "/home/epics/burt/HV/" ;
# Detector name will be capitalized and added to the path
# (ex. ecal -> /usr/clas12/hps/DATA/ECAL/)
$SnapDir = "/usr/clas12/hps/DATA/";

&SelectBackupFile( $det2restore, $SnapDir.$det2restore ) ;


# That's it 

exit (0);



sub SelectBackupFile 
  {
    my $det     = $_[0] ;
    my $DirName = $_[1] ;
    
 
    # create the text entry widget
    $tk_main = MainWindow->new;
    $tk_main->title("Select File Name" );
 
    my $win_label = sprintf( "               Select Backup File Name for $det                 " );
    my $tk_label = $tk_main -> Label(-text=>$win_label );
    $tk_label -> pack;
    
    my $date_var = `date`;
    chop( $date_var );
    my @date_list = split( /\s+/,  $date_var ) ;
    my $month = $date_list[1];
    my $day   = $date_list[2];
    my $year  = $date_list[5];
    my $hour  = $date_list[3];
    $hour =~ s/\:/\_/g ;


    $tk_entry = $tk_main->Entry ( -textvariable => \$file_name );
    $tk_entry->pack( -expand=>1, -fill=>'x' ); 

    @file_list = `ls -t $DirName/\*.snap`;
    foreach ( @file_list )
      {
	chop ( $_ );
      }

    if ( @file_list > 0 )
      {
	$file_name = $file_list[0] ;
      }
    else 
      {
	$file_name = "";
      }


    $tk_listbox = $tk_main->Scrolled("Listbox", 
				     -scrollbars=>"e", 
				     -selectmode => "single", 
				     -height => 20,
				     -width => 0  )-> pack(  );
    $tk_listbox->insert( 'end', @file_list );
    $tk_listbox->bind('<Button-1>', 
		      sub { $file_name = $tk_listbox->get( $tk_listbox->curselection() ) ;  } );

    $tk_listbox->activate( 0 );
    $tk_listbox->selectionSet( 0 );
    $tk_listbox->focus( );
    

    my $tk_ok_button = $tk_main->Button(-text => 'RESTORE',
					-command => [\&restore_hv ] ) ;
						    
    $tk_ok_button -> pack(-side=> 'left',
                          -padx=>2);

    my $tk_dismiss = $tk_main->Button(-text=>'DISMISS',
                                      -command=>[$tk_main => 'destroy']);

    $tk_dismiss -> pack(-side=>'right',
                        -padx=>2);

#    $tk_entry->focus();
    
    MainLoop;

  }


sub restore_hv 
  {
    my $file = $file_name ;

    my $FullFileName = "$file" ;
    print "Full Path is $FullFileName \n" ;
    

    $command = "burtwb -f  $FullFileName";

    print "Command is : $command \n" ;
    system "$command" || 
      die "Could not execute $command \n";

    $tk_main->destroy;
  }
