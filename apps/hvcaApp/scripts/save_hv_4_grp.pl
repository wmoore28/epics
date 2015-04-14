#!/bin/env perl

#
#   Script to run "burtrb" to  save the  
#   HV for a group for a detector ( EC, CC, TOF, BEAM, Tagger )
#   Expects 2 argument - name of the detector 
#


use Tk;

if ( @ARGV < 2 ) 
  {
    print "Error: Not enough arguments given ! \n";
    print "Exiting now !!! \n" ;
    exit (1);
  }
elsif ( @ARGV > 2 )
  {
    print "Error: Too many arguments given ! \n";
    print "Exiting now !!! \n" ;
    exit (2);    
  }
#
#
#  Get the detector name and change it to uppeccase
#
$det2save = $ARGV[0] ;
$det2save =~ tr/a-z/A-Z/ ;
$grp2save = $ARGV[1] ;

# Detector name will be capitalized and added to the path
# (ex. ecal -> /usr/clas12/hps/DATA/ECAL/)
$SnapDir = "/usr/clas12/hps/DATA/";

$det_dir = $SnapDir.$det2save ;

&SelectBackupFile( $det2save, $grp2save, $det_dir ) ;


# That's it 

exit (0);




sub SelectBackupFile 
  {
    my $det     = $_[0] ;
    my $grp     = $_[1] ;
    my $DirName = $_[2] ;
    
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


    $file_name = sprintf("%s/%s_%s_%s_%s_%s.snap", $DirName, $grp, $day, $month, $year, $hour ); 



    $tk_entry = $tk_main->Entry ( -textvariable => \$file_name );
    $tk_entry->pack( -expand=>1, -fill=>'x' );


    my $tk_ok_button = $tk_main->Button(-text => 'SAVE',
                    -command => [\&save_file , $det,  $grp ]);
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
    my $det_name = $_[0] ;
    my $grp_name = $_[1] ;
    my $file = $file_name ;

    $det_name =~ tr/A-Z/a-z/ ;
#    $grp_name =~ tr/A-Z/a-z/ ;

    $grp_file_name = $grp_name;
    $grp_file_name = $ENV{"APP"}."/hvcaApp/DB/".$det_name."\.grp" ;
    
#    print "Group File Name is $grp_file_name \n" ;

    open( GROUP_FILE, $grp_file_name ) ||
      die "Could not open file for group name $grp_file_name \n" ;
 
#    print "Group name is $grp_name \n" ;
   
    while ( $line = <GROUP_FILE> )
      {
	if ( $line =~ /$grp_name/i )
	  {
	    @line_list = split( / / , $line );
	    $grp_numb = $line_list[0] ;
	    if ( $grp_numb < 10 ) 
	      {
		$grp_numb = "0".$grp_numb ;
	      }	      
	  }
      }
    close( GROUP_FILE );
    
    if ( !$grp_numb )
      {
	die "Not a valid group name $grp_name \n" ;
      }

    $grp_key = $det_name."\_grp".$grp_numb ;
#    print "Group Key is $grp_key \n" ;

#NO:
    #$req_dir = "\$APP/hvcaApp/req/" ;
#YES:
    $req_dir = $ENV{"APP"}."/hvcaApp/req/" ;


#    print "\n\n$req_dir\n\n$grp_key\n\n";


    @req_file_list = `ls $req_dir\* | grep \"$grp_key\"` ;
    
    $req_file_string = "";
    foreach ( @req_file_list )
      {
	chop ;
	$req_file_string .= $_." " ;
      }

    my $FullFileName = $file ;
#    print "Full Path is $FullFileName \n" ;
    
    $command = "burtrb -f $req_file_string > $FullFileName";


    print "Command is : $command \n" ;
    system "$command" || 
      die "Could not execute $command \n";

    $tk_main->destroy;
  }
