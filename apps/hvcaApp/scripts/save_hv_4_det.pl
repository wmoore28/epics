#!/bin/env perl

#
#   Script to run "burtrb" to  save the  
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
$det2save = $ARGV[0] ;
$det2save =~ tr/a-z/A-Z/ ;

# Detector name will be capitalized and added to the path
# (ex. ecal -> /usr/clas12/hps/DATA/ECAL/)
$SnapDir = "/usr/clas12/hps/DATA/";

&SelectBackupFile( $det2save, $SnapDir.$det2save ) ;

# That's it 

exit (0);


sub SelectBackupFile 
  {
    my $det     = $_[0] ;
    my $DirName = $_[1] ;
    

    # create the text entry widget
    $tk_main = MainWindow->new;
    $tk_main->title("Select File Name" );
 
    my $win_label = sprintf( "                             Select Backup File Name for $det                             " );
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

    print "M: $month D: $day Y: $year H: $hour \n";

    $file_name = sprintf("%s/%s_%s_%s_%s_%s.snap", $DirName, $det, $day, $month, $year, $hour ); 

    $tk_entry = $tk_main->Entry ( -textvariable => \$file_name );
    $tk_entry->pack( -expand=>1, -fill=>'x' );

    my $tk_ok_button = $tk_main->Button(-text => 'SAVE',
                    -command => [\&save_file , $det ]);
    $tk_ok_button -> pack(-side=> 'left',
                          -padx=>2);

    my $tk_dismiss = $tk_main->Button(-text=>'DISMISS',
                                      -command=>[$tk_main => 'destroy']);

    $tk_dismiss -> pack(-side=>'right',
                        -padx=>2);

    $tk_entry->focus();
    
    MainLoop;

  }



sub save_file 
  {
    my $file = $file_name ;
    my $det_name = $_[0] ;
    $det_name =~ tr/A-Z/a-z/ ;

    $req_dir = "\$APP/hvcaApp/req" ;

    my $FullFileName = $file ;
#    print "Full Path is $FullFileName \n" ;
    

    $command = "burtrb -f $req_dir/".$det_name."\_all\.req > $FullFileName";

    print "Command is : $command \n" ;
    system "$command" || 
      die "Could not execute $command \n";

    $tk_main->destroy;
  }


