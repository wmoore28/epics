#!/bin/env perl 

use Pezca; 

use Thread;

use Tk;
use Tk::ProgressBar;

#===========================================================================================
#
# Main 
#
{
  #
  #   Global Variables Used in Many Places in this SCript
  #
  $CurrVal = 0.0;
  $Time = 0.0;
  $StartVal = 2400.0;
  $StopVal = 1400.0;
  $StepVal = 100.0;
  $DelayTime = 900.0;
  $ComSignal = 1;
  $ScanFlag = 0;
  $ScanComplete = 0;

  $PB_Scale = 300.0;
  $TimeScale = 0.0;
  $CurrValScale = 0.0;
  $CurrRB = 0;

  $FieldVal = 0;
  $SetFlag = 0;

  #
  #   Check to see if initial conditions are satisfied
  #    If not READY, then quit 
  #
  $status = &check_status;
  
  $ENV{EPICS_CA_ADDR_LIST} = "129.57.160.53 129.57.160.21 129.57.160.19";


  if( $status eq "OK" ) {
    &start_gui();
  } 
  else {
    print "Error - Can't Start in These Conditions: $status\n";
    exit(1);
  }
  
}


#=========================================================================================
#
#   Function to check the Tagger PS status
#
sub check_status()
  {
    #
    #  First Check for Tagger PS ON
    #
    ( $Err, $TgrStatus   ) = Pezca::GetDouble( "TMPSONRBCK"  );
    ( $Err, $TgrPolarity ) = Pezca::GetDouble( "TMPOLARRBCK" );
    ( $Err, $TgrMode     ) = Pezca::GetDouble( "TMTESTMODE"  );

    if ( $TgrStatus != 1 || $TgrPolarity != 0 || $TgrMode != 1 ) {
      $ReturnValue = "TAGGER PS NOT READY";
    } else {
      $ReturnValue = "OK";
    }
#    $ReturnValue = "OK";
    $ReturnValue;
  }


#============================================================================================
#
#  Function which starts the MAIN GUI
#
sub start_gui()
  {
    print "Starting GUI ...\n";

    $MainPad =  MainWindow->new;
    $MainPad->title('Tagger Magnet Scan' );
    
    my $TopLevel = $MainPad->toplevel;
    my $MenuBar = $TopLevel->Menu(-type => 'menubar');
    $TopLevel->configure(-menu => $MenuBar);

    my $modifier = 'Meta';	# Unix
    
    my $FileMenu = $MenuBar->cascade(-label => '~File', -tearoff => 0);
    $FileMenu->command(-label => 'Print ...', -command => [\&menus_error, 'Print'] );
    $FileMenu->separator;
    $FileMenu->command(-label => 'Quit',      -command => sub { exit 0 } );

    my $MainLabel = $MainPad -> Label(
				      -text => 'Tagger Magnet Scan',
				      -font => 'Times 22',
				      -foreground => 'Green4');
    $MainLabel -> pack;

    my @Fields = ("NAME", "START_VAL"); 
 
    #
    #  Divide the Canvas into 2 Vertical Frames
    #
    @pl = qw/-side top -expand 1 -padx .5c -pady .5c/;
    my $ScanFrame = $MainPad->Frame->pack(@pl);
    
    @pl = qw/-side left -expand 1 -padx .5c -pady .5c/;
    foreach $field ( @Fields ) {
      $SubFrame{$field} = $ScanFrame->Frame->pack(@pl);
    }
    
    my $field = $Fields[0];
    my(@pl) = qw/-side top -pady 18 -anchor w/;
    $Title{"Start"} = $SubFrame{$field}->Label( 
					       -relief => 'flat',
					       -text   => "Start Value (A)",
					      )->pack(@pl);
    $Title{"Stop"} = $SubFrame{$field}->Label( 
					       -relief => 'flat',
					       -text   => "Stop Value (A)",
					      )->pack(@pl);

    $Title{"Step Size"} = $SubFrame{$field}->Label( 
					       -relief => 'flat',
					       -text   => "Step Size Value (A)",
					      )->pack(@pl);
    $Title{"Delay"} = $SubFrame{$field}->Label( 
					       -relief => 'flat',
					       -text   => "Delay (sec)",
					      )->pack(@pl);

    $field = $Fields[1];
    my %Scale;
    $Scale{"Start"} = $SubFrame{$field}->Scale(
					       qw/-orient horizontal -length 200 -width 10 
					       -from 0. -to 2500.  -resolution 10.0 -tickinterval 500. /
								 ) ;
    $Scale{"Start"}->configure( -variable  => \$StartVal );
    $Scale{"Start"}->pack(qw/-side top -expand yes -anchor w/);




    $Scale{"Stop"} = $SubFrame{$field}->Scale(
					       qw/-orient horizontal -length 200 -width 10 
					       -from 0. -to 2500.  -resolution 10.0 -tickinterval 500. /
								 ) ;
    $Scale{"Stop"}->configure( -variable  => \$StopVal );
    $Scale{"Stop"}->pack(qw/-side top -expand yes -anchor w/);


    $Scale{"Step Size"} = $SubFrame{$field}->Scale(
					       qw/-orient horizontal -length 200 -width 10 
					       -from 0. -to 300.  -resolution 5.0 -tickinterval 50. /
								 ) ;
    $Scale{"Step Size"}->configure( -variable  => \$StepVal );
    $Scale{"Step Size"}->pack(qw/-side top -expand yes -anchor w/);
       

    $Scale{"Delay"} = $SubFrame{$field}->Scale(
					       qw/-orient horizontal -length 200 -width 10 
					       -from 0. -to 1200.  -resolution 20 -tickinterval 300. /
								 ) ;
    $Scale{"Delay"}->configure( -variable  => \$DelayTime );
    $Scale{"Delay"}->pack(qw/-side top -expand yes -anchor w/);

    my $ButtonFrame  = $MainPad->Frame->pack(@pl); 
    #
    #  Start Button
    #
    $StartButton = $ButtonFrame->Button(  -text    => 'Start Scan',
					       -command => [\&launch_scan]  );
    $StartButton->pack(qw/-side left -expand 1 -padx 15 -anchor w/);   

    #
    #  Start Button
    #    
    my $StopButton = $ButtonFrame->Button(  -text    => 'Stop Scan',
				       -command => sub { &cancel_scan } );
    $StopButton->pack(qw/-side left -expand 1 -padx 15 -anchor w/);
    
    #
    #  Help Button
    #
    
    my $HelpButton = $ButtonFrame->Button( -text    => 'Help',
					   -command => [\&show_help]  );
    $HelpButton->pack(qw/-side left -expand 1 -padx 15 -anchor w/);   
    
    #
    #  Dismiss Button
    #   
    my $ExitButton = $ButtonFrame->Button(  -text    => 'Exit Scan',
					    -command => sub { &cancel_scan, exit 0 }  );
    $ExitButton->pack(qw/-side right -expand 1 -padx 15 -anchor w/);   
    
    MainLoop;
    
    1;   
  }



#================================================================================
#
#  Function to handle errors
#   from the GUI.
#
sub menus_error {
  
  # Generate a background error, which may even be displayed in a window if
  # using ErrorDialog. 
  
  my($msg) = @_;
  
  $msg = "No action has been defined for \"$msg\".";
  $MainPad->BackTrace($msg);
  
} # end menus_error



#=====================================================================================
#
#  A function called when Help is requested from the 
#          GUI 
#
sub show_help {
  $HelpPad =  MainWindow->new;
  $HelpPad->configure( -title => 'Help Window' );
  $HelpPad->Label(qw/-wraplength 4.5i -justify left -pady 20 -text/ => 
		  ' No Help so far', 
		  -font => 'Times 14')->pack;
  my $BigButton = $HelpPad->Button(
				   -text    => 'Close',
				   -command => [ $HelpPad => 'destroy'  ]   
				  );
  $BigButton->pack(qw/-side right -expand 1 -padx 35 -anchor w/);   
  
}

#=============================================================================================
#
#  Function to start scan and launch the GUI
#
sub launch_scan {
#  my tt=0;
  lock($ScanFlag);
  if ( $ScanFlag == 0 ) {
    { lock($ComSignal); $ComSignal = 0; }
    local $thread = Thread->new( \&do_scan );
    $thread->detach;

    sleep(1);

    &start_scan_GUI();

  } else {
    print "Scan is Already in Progress \n" ;
  }  
}


#================================================================================================
#
#  Function to send signal to terminate the scan
#
sub cancel_scan {

  lock($ComSignal);
  $ComSignal = -9;
  printf "Cancelling : Sending Signal $ComSignal to Scan \n" ;
}


#============================================================================================
#
#  Function to start the Scan GUI
#
sub start_scan_GUI {

  print "Starting Scan GUI \n";

  $ScanPad =  MainWindow->new;
  $ScanPad->title('Scan Status');
  
  my $ScanLabel = $ScanPad -> Label(
				    -text => 'Scan Status',
				    -font => 'Times 22',
				    -foreground => 'Green4');
  $ScanLabel->pack;

  @pl = qw/-side top -expand 1 -padx .5c -pady .5c/;
  my $DisplayFrame =  $ScanPad->Frame->pack(@pl);

  @pl = qw/-side left -expand 1 -padx .5c -pady .5c/;
  my $LabelFrame = $DisplayFrame->Frame->pack(@pl);
  @pl = qw/-side left -expand 1 -padx .5c -pady .5c/;
  my $WidgetFrame = $DisplayFrame->Frame->pack(@pl);

  my(@pl) = qw/-side top -pady 15 -anchor w/;
  $Label{"Current"} = $LabelFrame->Label( 
					 -relief => 'flat',
					 -text   => "Progress in Current",
					)->pack(@pl);
  my(@pl) = qw/-side top -pady 15 -anchor w/;
  $Label{"Time"} = $LabelFrame->Label( 
				      -relief => 'flat',
				      -text   => "Progress in Delay",
				     )->pack(@pl);
  

  
  my $CurrPB = $WidgetFrame->ProgressBar( -width => 30, -from => 0, -to => $PB_Scale, -blocks => 500, 
					  -colors => [0, 'blue'], 
					  -variable => \$CurrValScale )->pack( -fill => 'x',
									  -pady => 10 );
  my $TimePB = $WidgetFrame->ProgressBar( -width => 30, -from => 0, -to => $PB_Scale, -blocks => 500, 
					  -colors => [0, 'green' ], 
					  -variable => \$TimeScale )->pack( -fill => 'x',
								       -pady =>  10 );
  
    
  @pl = qw/-side top -expand 1 -padx .5c -pady .5c/;
  my $ButtonFrame  = $ScanPad->Frame->pack(@pl); 
     
  local $StopButton = $ButtonFrame->Button(  -text    => 'Stop Scan',
				       -command => sub { &cancel_scan; 
							  $ScanPad->destroy 
							    if Tk::Exists($ScanPad) }   );
  $StopButton->pack(qw/-side left -expand 1 -padx 15 -anchor w/);

  local $OkButton = $ButtonFrame->Button(  -text    => 'Done',
					   -state   => 'disabled', 
					   -command => sub { $ScanPad->destroy 
							       if Tk::Exists($ScanPad) }  );
  $OkButton->pack(qw/-side left -expand 1 -padx 15 -anchor w/);
  

  $ScanPad->repeat( 1000 => \&update_scan_gui, \$ScanPad, \$StopButton, \$OkButton  ) ;  
}

#==============================================================================================
#
#   Function to be run for updating the scan GUI
#
sub update_scan_gui {
  my ( $Pad, $StopButton, $OkButton ) = @_ ; 

  lock($Time); lock( $CurrVal ); lock($ScanComplete); 
  lock($DelayTime); lock($StartTime); lock($StopTime);

  $TimeScale = $PB_Scale * ( $Time / $DelayTime );
  $CurrValScale = $PB_Scale * ( $CurrVal - $StartVal ) / 
    ( $StopVal - $StartVal ) ;

  if ( $ScanComplete ) {
    $$StopButton->configure( -state => 'disabled' );
    $$OkButton->configure( -state => 'normal' );
  }

  # This is really ugly, but I could not get 
  # GetDouble to work from the new thread
  # Some ports are apparently unaccessible from the  
  # new thread
  { 
    my $Err=0;
    my $EPICS_chan = "Hac_TGR_LS450:FLD_DATA";
    lock($FieldVal);
    ( $Err, $FieldVal ) = Pezca::GetDouble( $EPICS_chan );     
  }

  if ( $SetFlag == 1 ) {
    my $Err=0;
    my $EPICS_chan = "TMSETI";
    lock($SetFlag);
    printf "Setting  $CurrVal \n";
    $Err = Pezca::PutDouble( $EPICS_chan, $CurrVal );  
    $SetFlag = 0;
  }

  {
    my $EPICS_chan = "TMIRBCK";
    my $Err=0;
    lock( $CurrRB  );
    ( $Err, $CurrRB ) = Pezca::GetDouble( $EPICS_chan );  
  }
  
  $$Pad->update;
}

#=========================================================================================
#
# Function which actually does the Scan
#
sub do_scan  {

  my $Err = 0;
  my $field = 0;

  if( &open_data_file() ) {
    lock($ComSignal); $ComSignal = -2;
  }

  {
    lock($ScanFlag); lock($ScanComplete);
    $ScanFlag = 1;
    $ScanComplete = 0;
  }
  my $small_value = 30;
  my $start = $StartVal; 
  my $stop = $StopVal; 
  my $step = $StepVal;
  my $dt = $DelayTime;
  my $time_temp = 0;
  my $sig_tmp = 0;
  my $read_back = 0;

  #  Loop over field values
  my $val = 0;
  { lock($ComSignal);  $sig_tmp = $ComSignal; }
  for( $val = $start; ($val >= $stop) && ($sig_tmp==0) && ($start>$stop); $val -= $step ) {
    
    { lock($CurrVal); $CurrVal = $val; }
    { lock($ComSignal);  $sig_tmp = $ComSignal; }
    { lock($Time); $Time = 0; $time_temp = 0;} 
    
    { lock($DelayTime); $dt = $DelayTime; }
    
    # Set the flag up so that the EPICS record is set 
    { lock( $SetFlag ); $SetFlag = 1; }
    sleep(2);
    
    # Wait for a while given that the field reached the setpoint
    while ( ($time_temp < $dt) && ($dt>1) && ($sig_tmp==0) ) { 
      { lock( $CurrRB ); $read_back = $CurrRB; }
      if ( abs( $read_back - $val ) < $small_value ) {
	$time_temp += sleep(2);
      } else {
	print "Waiting to settle \n" ;
	sleep(5);
      }

      { lock($Time) ; $Time = $time_temp ; }
      { lock($ComSignal); $sig_tmp = $ComSignal; }
    }

    sleep(2);   
    { 
      lock($FieldVal); 
      print  "$val  $read_back  $FieldVal   $time_temp \n" ; 
      print DATA_FILE "$val    $read_back   $FieldVal   $time_temp \n" ; 
    }
  }

  { lock($ComSignal); $sig_tmp = $ComSignal; }  
  if ( $sig_tmp==0 ) {
    lock( $ScanComplete );
    $ScanComplete = 1;
  }

  { lock($ScanFlag); $ScanFlag = 0; }
  
  &close_data_file;
  print "Exiting Thread \n";
}
  
#====================================================================================
#
#  Function to Open the data file 
#
sub open_data_file {
  my $run_num = 0;
  my $ReturnValue = 0;

  my $key_file_name = "/home/epics/DATA/tagger_scan/.tagger_scan_key";

  if ( !open( KEY_FILE, $key_file_name ) ) {
    print "WARNING: Can't Open Key File $key_file_name \n";
    $run_num = 1;
  } else {
    $run_num = <KEY_FILE>;
    close( KEY_FILE );
  }
  $run_num++ ;

  print "Opening Data File for Run $run_num \n" ; 

  open( KEY_FILE, ">".$key_file_name ) ;
  print KEY_FILE $run_num;
  close( KEY_FILE );

  $data_file_name = "/home/epics/DATA/tagger_scan/tagger_scan_".$run_num."\.dat" ;

  print "Data file is $data_file_name \n";
  
  if ( !open( DATA_FILE, ">".$data_file_name ) ) { 
    print "ERROR: Can't open file $data_file_name \n" ;
    $ReturnValue = -1;
  } else {
    my $date = `date` ;
    print DATA_FILE "\# Data taken $date" ;
  }
  
  $ReturnValue;
}

#===================================================================================
#
# Function to Close the Datafile
#
sub close_data_file() {
  print "Closeing Data File \n" ;
  close( DATA_FILE );
}
