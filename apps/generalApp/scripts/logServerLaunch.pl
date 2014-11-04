#!/bin/env perl 

#
# Script to check if the logserver is running or not.
# If not launch the log server
#  Intended to be launched as a cronjob.
#


{
 open( PS_PROC, "/usr/bin/ps -ef \| grep \'solaris/iocLogServer\' |" );

 $iProc = 0; $ServFlag = 0;
 while ( <PS_PROC> ) {
   chop;
   $SelfProc = 0;
   $iProc++;

#   print "$_ \n" ;
   @Fields = split(/\s+/);

   foreach ( @Fields ) {
     if ( /grep/ ) {
	 $SelfProc = 1;
       }
   }

   unless( $SelfProc ) {
     $ServFlag = 1;
   }
 } 
 
 if( !$ServFlag ) {
#   print "Launching Server \n";
   system ( "\$EPICS_BASE/bin/solaris/iocLogServer & " );
 } else {
#   print "Server is already running \n";
 }

}
