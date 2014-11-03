#!/bin/env perl


$crate="13";
$mainframe="01";
#$mainframe="04";
# &CREATE_MAINFRAME_HEADER(CRATE_ID MAINFRAME_ID)
&CREATE_MAINFRAME_HEADER($crate, $mainframe);

#&CREATE_CHANNEL($crate, $mainframe, $board, $channel);

#Slot 2:  Mod. A509   18 CH FLOATING     8V   2000.00mA --- Ser.  48, Rel. 1.07
#$board="02";
$board="01";
for $channel (0..17) {
    &CREATE_CHANNEL($crate, $mainframe, $board, $channel);
}
#Slot 6:  Mod. A509H  15 CH FLOATING     8V    500.00mA --- Ser.   6, Rel. 1.00
#$board="06";
#for $channel (0..14) {
#    &CREATE_CHANNEL($crate, $mainframe, $board, $channel);
#}
#Slot 8:  Mod. A944P  24 CH POSITIVE  2500V     40.00uA --- Ser.  15, Rel. 1.02
#$board="08";
#for $channel (0..23) {
#    &CREATE_CHANNEL($crate, $mainframe, $board, $channel);
#}



sub CREATE_MAINFRAME_HEADER {

#
# print the manframe related DB entries
#
( $CRATE, $MAINFRAME ) = @_;

print <<EOD
record(bo, "B/HVON_SET_${CRATE}_${MAINFRAME}") {
   field(DTYP,"CAEN_HV")
   field(ZNAM,"HV/OFF")
   field(DESC,"binary output record")
   field(ONAM,"HV/ON")
   field(OMSL,"supervisory")
   field(SCAN,"Passive")
   field(OUT,"#C1 S2048")
}
record(bi, "B/HVVALID_${CRATE}_${MAINFRAME}") {
   field(DTYP,"CAEN_HV")
   field(ZNAM,"NOT VALID")
   field(DESC,"binary input record ")
   field(ONAM,"VALID")
   field(ZSV,"MAJOR")
   field(SCAN,"2 second")
   field(OSV,"NO_ALARM")
   field(INP,"#C1 S32768")
}
record(bi, "B/HVALARM_${CRATE}_${MAINFRAME}") {
   field(DTYP,"CAEN_HV")
   field(ZNAM,"enabled")
   field(DESC,"binary input record")
   field(ONAM,"disabled")
   field(ZSV,"NO_ALARM")
   field(SCAN,"2 second")
   field(OSV,"MAJOR")
   field(INP,"#C1 S33280")
}
record(bi, "B/HVSTATUS_${CRATE}_${MAINFRAME}") {
   field(DTYP,"CAEN_HV")
   field(ZNAM,"HV/OFF")
   field(DESC,"binary input record")
   field(ONAM,"HV/ON")
   field(SCAN,"2 second")
   field(INP,"#C1 S33024")
}
record(calc, "B/HVOC_${CRATE}_${MAINFRAME}") {
   field(LOLO,"-0.1")
   field(CALC,"ABS(A-B)")
   field(LLSV,"MAJOR")
   field(HIHI,"0.1")
   field(SCAN,"1 second")
   field(HHSV,"MAJOR")
   field(INPA,"B/HVSTATUS_${CRATE}_${MAINFRAME} NPP NMS")
   field(LSV,"MAJOR")
   field(LOW,"-0.1")
   field(INPB,"B/HVON_SET_${CRATE}_${MAINFRAME} NPP NMS")
   field(HIGH,"0.1")
   field(HSV,"MAJOR")
}
EOD
    ;

}


sub CREATE_CHANNEL {

#
# print channel related entries
#

( $CRATE, $MAINFRAME, $BOARD, $CHANNEL ) = @_;

$C=$MAINFRAME+($BOARD<<8);
print "# C=$C CRATE=$CRATE MAINFRAME=$MAINFRAME BOARD=$BOARD CHANNEL=$CHANNEL\n";

#@S = {256, 512, 768, 1024, 1280, 1536, 1792};
@S = split(':',"256:512:768:1024:1280:1536:1792");
for $i (0..6) {
    $S[$i] += $CHANNEL;
#    print "S\[$i\]=$S[$i]\n";
}
print <<EOD
record(bo, "B_hv_HPS_B${BOARD}_${CHANNEL}_CE") {
   field(DTYP,"CAEN_HV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C${C} S${S[0]}")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_HPS_B${BOARD}_${CHANNEL}_DV") {
   field(DTYP,"CAEN_HV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C${C} S${S[1]}")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_HPS_B${BOARD}_${CHANNEL}_RDN") {
   field(DTYP,"CAEN_HV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C${C} S${S[2]}")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_HPS_B${BOARD}_${CHANNEL}_RUP") {
   field(DTYP,"CAEN_HV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C${C} S${S[3]}")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_HPS_B${BOARD}_${CHANNEL}_TC") {
   field(DTYP,"CAEN_HV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C${C} S${S[4]}")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_HPS_B${BOARD}_${CHANNEL}_MVDZ") {
   field(DTYP,"CAEN_HV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C${C} S${S[5]}")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_HPS_B${BOARD}_${CHANNEL}_MCDZ") {
   field(DTYP,"CAEN_HV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C${C} S${S[6]}")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_HPS_B${BOARD}_${CHANNEL}_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INAM,"InitChannel")
   field(SNAM,"ScanChannel")
   field(INPA,"${MAINFRAME}")
   field(INPB,"${BOARD}")
   field(INPC,"${CHANNEL}")
   field(PREC,"3")
   field(HIGH,"10")
   field(HSV,"MAJOR")
}
EOD
;

}
