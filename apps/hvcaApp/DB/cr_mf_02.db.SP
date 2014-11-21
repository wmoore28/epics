record(bo, "B/HVON_SET_99_02") {
   field(DTYP,"LecroyHV")
   field(ZNAM,"HV/OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S2048")
   field(ONAM,"HV/ON")
   field(OMSL,"supervisory")
}
record(bi, "B/HVVALID_99_02") {
   field(DTYP,"LecroyHV")
   field(ZNAM,"NOT VALID")
   field(DESC,"binary input record ")
   field(ZSV,"MAJOR")
   field(SCAN,"2 second")
   field(OSV,"NO_ALARM")
   field(ONAM,"VALID")
   field(INP,"#C2 S32768")
}
record(bi, "B/HVALARM_99_02") {
   field(DTYP,"LecroyHV")
   field(ZNAM,"enabled")
   field(DESC,"binary input record")
   field(ZSV,"NO_ALARM")
   field(SCAN,"2 second")
   field(OSV,"MAJOR")
   field(ONAM,"disabled")
   field(INP,"#C2 S33280")
}
record(bi, "B/HVSTATUS_99_02") {
   field(DTYP,"LecroyHV")
   field(ZNAM,"HV/OFF")
   field(DESC,"binary input record")
   field(SCAN,"2 second")
   field(ONAM,"HV/ON")
   field(INP,"#C2 S33024")
}
record(calc, "B/HVOC_99_02") {
   field(LOLO,"-0.1")
   field(CALC,"ABS(A-B)")
   field(LLSV,"MAJOR")
   field(HIHI,"0.1")
   field(SCAN,"1 second")
   field(HHSV,"MAJOR")
   field(INPA,"B/HVSTATUS_99_02 NPP NMS")
   field(LSV,"MAJOR")
   field(LOW,"-0.1")
   field(INPB,"B/HVON_SET_99_02 NPP NMS")
   field(HIGH,"0.1")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_03_00_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S256")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_00_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S512")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_00_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S768")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_00_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1024")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_00_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1280")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_00_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1536")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_00_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1792")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_03_00_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"03")
   field(HIGH,"10")
   field(INPC,"00")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_09_11_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S267")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_11_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S523")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_11_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S779")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_11_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1035")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_11_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1291")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_11_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1547")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_11_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1803")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_09_11_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"09")
   field(HIGH,"10")
   field(INPC,"11")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_08_06_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S262")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_06_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S518")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_06_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S774")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_06_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1030")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_06_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1286")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_06_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1542")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_06_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1798")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_08_06_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"08")
   field(HIGH,"10")
   field(INPC,"06")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_08_05_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S261")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_05_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S517")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_05_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S773")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_05_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1029")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_05_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1285")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_05_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1541")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_05_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1797")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_08_05_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"08")
   field(HIGH,"10")
   field(INPC,"05")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_06_07_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S263")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_07_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S519")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_07_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S775")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_07_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1031")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_07_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1287")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_07_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1543")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_07_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1799")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_06_07_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"06")
   field(HIGH,"10")
   field(INPC,"07")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_02_09_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S265")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_09_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S521")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_09_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S777")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_09_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1033")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_09_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1289")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_09_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1545")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_09_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1801")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_02_09_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"02")
   field(HIGH,"10")
   field(INPC,"09")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_09_00_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S256")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_00_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S512")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_00_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S768")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_00_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1024")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_00_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1280")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_00_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1536")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_00_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1792")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_09_00_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"09")
   field(HIGH,"10")
   field(INPC,"00")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_00_03_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S259")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_03_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S515")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_03_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S771")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_03_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1027")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_03_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1283")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_03_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1539")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_03_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1795")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_00_03_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"00")
   field(HIGH,"10")
   field(INPC,"03")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_03_03_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S259")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_03_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S515")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_03_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S771")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_03_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1027")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_03_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1283")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_03_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1539")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_03_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1795")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_03_03_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"03")
   field(HIGH,"10")
   field(INPC,"03")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_04_02_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S258")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_02_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S514")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_02_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S770")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_02_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1026")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_02_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1282")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_02_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1538")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_02_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1794")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_04_02_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"04")
   field(HIGH,"10")
   field(INPC,"02")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_05_09_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S265")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_09_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S521")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_09_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S777")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_09_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1033")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_09_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1289")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_09_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1545")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_09_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1801")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_05_09_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"05")
   field(HIGH,"10")
   field(INPC,"09")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_03_07_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S263")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_07_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S519")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_07_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S775")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_07_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1031")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_07_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1287")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_07_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1543")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_07_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1799")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_03_07_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"03")
   field(HIGH,"10")
   field(INPC,"07")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_08_08_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S264")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_08_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S520")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_08_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S776")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_08_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1032")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_08_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1288")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_08_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1544")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_08_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1800")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_08_08_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"08")
   field(HIGH,"10")
   field(INPC,"08")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_06_05_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S261")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_05_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S517")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_05_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S773")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_05_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1029")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_05_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1285")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_05_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1541")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_05_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1797")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_06_05_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"06")
   field(HIGH,"10")
   field(INPC,"05")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_02_07_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S263")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_07_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S519")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_07_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S775")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_07_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1031")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_07_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1287")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_07_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1543")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_07_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1799")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_02_07_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"02")
   field(HIGH,"10")
   field(INPC,"07")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_06_03_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S259")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_03_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S515")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_03_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S771")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_03_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1027")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_03_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1283")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_03_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1539")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_03_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1795")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_06_03_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"06")
   field(HIGH,"10")
   field(INPC,"03")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_06_01_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S257")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_01_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S513")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_01_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S769")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_01_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1025")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_01_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1281")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_01_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1537")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_01_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1793")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_06_01_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"06")
   field(HIGH,"10")
   field(INPC,"01")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_04_00_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S256")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_00_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S512")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_00_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S768")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_00_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1024")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_00_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1280")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_00_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1536")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_00_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1792")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_04_00_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"04")
   field(HIGH,"10")
   field(INPC,"00")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_00_09_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S265")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_09_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S521")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_09_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S777")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_09_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1033")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_09_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1289")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_09_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1545")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_09_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1801")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_00_09_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"00")
   field(HIGH,"10")
   field(INPC,"09")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_02_02_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S258")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_02_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S514")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_02_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S770")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_02_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1026")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_02_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1282")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_02_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1538")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_02_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1794")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_02_02_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"02")
   field(HIGH,"10")
   field(INPC,"02")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_10_07_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S263")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_07_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S519")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_07_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S775")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_07_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1031")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_07_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1287")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_07_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1543")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_07_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1799")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_10_07_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"10")
   field(HIGH,"10")
   field(INPC,"07")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_04_11_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S267")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_11_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S523")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_11_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S779")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_11_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1035")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_11_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1291")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_11_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1547")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_11_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1803")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_04_11_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"04")
   field(HIGH,"10")
   field(INPC,"11")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_03_08_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S264")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_08_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S520")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_08_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S776")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_08_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1032")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_08_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1288")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_08_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1544")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_08_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1800")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_03_08_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"03")
   field(HIGH,"10")
   field(INPC,"08")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_10_01_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S257")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_01_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S513")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_01_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S769")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_01_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1025")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_01_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1281")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_01_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1537")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_01_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1793")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_10_01_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"10")
   field(HIGH,"10")
   field(INPC,"01")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_00_01_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S257")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_01_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S513")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_01_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S769")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_01_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1025")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_01_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1281")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_01_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1537")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_01_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1793")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_00_01_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"00")
   field(HIGH,"10")
   field(INPC,"01")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_02_00_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S256")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_00_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S512")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_00_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S768")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_00_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1024")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_00_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1280")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_00_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1536")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_00_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1792")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_02_00_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"02")
   field(HIGH,"10")
   field(INPC,"00")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_03_11_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S267")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_11_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S523")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_11_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S779")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_11_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1035")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_11_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1291")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_11_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1547")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_11_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1803")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_03_11_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"03")
   field(HIGH,"10")
   field(INPC,"11")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_06_10_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S266")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_10_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S522")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_10_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S778")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_10_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1034")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_10_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1290")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_10_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1546")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_10_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1802")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_06_10_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"06")
   field(HIGH,"10")
   field(INPC,"10")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_08_10_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S266")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_10_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S522")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_10_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S778")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_10_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1034")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_10_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1290")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_10_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1546")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_10_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1802")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_08_10_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"08")
   field(HIGH,"10")
   field(INPC,"10")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_06_09_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S265")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_09_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S521")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_09_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S777")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_09_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1033")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_09_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1289")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_09_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1545")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_09_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1801")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_06_09_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"06")
   field(HIGH,"10")
   field(INPC,"09")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_05_04_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S260")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_04_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S516")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_04_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S772")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_04_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1028")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_04_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1284")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_04_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1540")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_04_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1796")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_05_04_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"05")
   field(HIGH,"10")
   field(INPC,"04")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_00_10_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S266")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_10_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S522")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_10_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S778")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_10_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1034")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_10_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1290")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_10_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1546")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_10_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1802")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_00_10_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"00")
   field(HIGH,"10")
   field(INPC,"10")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_10_08_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S264")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_08_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S520")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_08_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S776")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_08_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1032")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_08_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1288")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_08_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1544")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_08_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1800")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_10_08_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"10")
   field(HIGH,"10")
   field(INPC,"08")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_02_04_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S260")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_04_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S516")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_04_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S772")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_04_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1028")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_04_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1284")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_04_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1540")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_04_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1796")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_02_04_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"02")
   field(HIGH,"10")
   field(INPC,"04")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_05_02_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S258")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_02_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S514")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_02_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S770")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_02_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1026")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_02_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1282")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_02_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1538")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_02_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1794")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_05_02_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"05")
   field(HIGH,"10")
   field(INPC,"02")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_10_11_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S267")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_11_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S523")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_11_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S779")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_11_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1035")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_11_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1291")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_11_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1547")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_11_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1803")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_10_11_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"10")
   field(HIGH,"10")
   field(INPC,"11")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_09_05_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S261")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_05_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S517")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_05_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S773")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_05_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1029")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_05_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1285")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_05_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1541")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_05_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1797")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_09_05_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"09")
   field(HIGH,"10")
   field(INPC,"05")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_04_08_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S264")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_08_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S520")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_08_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S776")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_08_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1032")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_08_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1288")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_08_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1544")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_08_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1800")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_04_08_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"04")
   field(HIGH,"10")
   field(INPC,"08")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_03_02_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S258")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_02_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S514")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_02_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S770")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_02_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1026")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_02_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1282")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_02_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1538")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_02_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1794")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_03_02_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"03")
   field(HIGH,"10")
   field(INPC,"02")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_05_00_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S256")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_00_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S512")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_00_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S768")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_00_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1024")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_00_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1280")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_00_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1536")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_00_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1792")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_05_00_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"05")
   field(HIGH,"10")
   field(INPC,"00")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_00_06_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S262")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_06_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S518")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_06_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S774")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_06_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1030")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_06_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1286")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_06_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1542")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_06_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1798")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_00_06_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"00")
   field(HIGH,"10")
   field(INPC,"06")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_10_04_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S260")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_04_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S516")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_04_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S772")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_04_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1028")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_04_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1284")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_04_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1540")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_04_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1796")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_10_04_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"10")
   field(HIGH,"10")
   field(INPC,"04")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_08_00_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S256")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_00_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S512")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_00_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S768")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_00_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1024")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_00_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1280")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_00_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1536")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_00_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1792")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_08_00_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"08")
   field(HIGH,"10")
   field(INPC,"00")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_09_06_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S262")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_06_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S518")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_06_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S774")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_06_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1030")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_06_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1286")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_06_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1542")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_06_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1798")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_09_06_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"09")
   field(HIGH,"10")
   field(INPC,"06")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_02_11_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S267")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_11_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S523")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_11_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S779")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_11_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1035")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_11_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1291")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_11_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1547")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_11_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1803")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_02_11_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"02")
   field(HIGH,"10")
   field(INPC,"11")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_09_01_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S257")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_01_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S513")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_01_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S769")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_01_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1025")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_01_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1281")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_01_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1537")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_01_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1793")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_09_01_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"09")
   field(HIGH,"10")
   field(INPC,"01")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_03_06_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S262")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_06_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S518")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_06_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S774")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_06_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1030")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_06_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1286")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_06_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1542")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_06_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1798")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_03_06_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"03")
   field(HIGH,"10")
   field(INPC,"06")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_09_03_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S259")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_03_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S515")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_03_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S771")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_03_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1027")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_03_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1283")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_03_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1539")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_03_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1795")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_09_03_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"09")
   field(HIGH,"10")
   field(INPC,"03")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_02_10_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S266")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_10_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S522")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_10_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S778")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_10_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1034")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_10_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1290")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_10_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1546")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_10_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1802")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_02_10_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"02")
   field(HIGH,"10")
   field(INPC,"10")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_05_11_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S267")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_11_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S523")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_11_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S779")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_11_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1035")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_11_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1291")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_11_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1547")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_11_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1803")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_05_11_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"05")
   field(HIGH,"10")
   field(INPC,"11")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_08_09_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S265")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_09_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S521")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_09_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S777")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_09_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1033")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_09_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1289")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_09_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1545")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_09_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1801")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_08_09_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"08")
   field(HIGH,"10")
   field(INPC,"09")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_09_10_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S266")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_10_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S522")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_10_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S778")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_10_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1034")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_10_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1290")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_10_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1546")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_10_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1802")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_09_10_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"09")
   field(HIGH,"10")
   field(INPC,"10")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_03_05_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S261")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_05_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S517")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_05_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S773")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_05_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1029")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_05_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1285")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_05_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1541")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_05_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1797")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_03_05_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"03")
   field(HIGH,"10")
   field(INPC,"05")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_03_10_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S266")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_10_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S522")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_10_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S778")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_10_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1034")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_10_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1290")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_10_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1546")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_10_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1802")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_03_10_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"03")
   field(HIGH,"10")
   field(INPC,"10")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_09_08_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S264")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_08_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S520")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_08_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S776")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_08_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1032")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_08_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1288")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_08_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1544")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_08_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1800")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_09_08_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"09")
   field(HIGH,"10")
   field(INPC,"08")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_08_03_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S259")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_03_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S515")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_03_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S771")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_03_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1027")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_03_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1283")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_03_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1539")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_03_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1795")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_08_03_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"08")
   field(HIGH,"10")
   field(INPC,"03")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_04_04_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S260")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_04_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S516")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_04_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S772")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_04_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1028")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_04_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1284")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_04_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1540")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_04_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1796")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_04_04_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"04")
   field(HIGH,"10")
   field(INPC,"04")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_05_06_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S262")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_06_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S518")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_06_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S774")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_06_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1030")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_06_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1286")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_06_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1542")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_06_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1798")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_05_06_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"05")
   field(HIGH,"10")
   field(INPC,"06")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_06_06_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S262")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_06_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S518")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_06_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S774")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_06_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1030")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_06_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1286")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_06_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1542")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_06_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1798")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_06_06_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"06")
   field(HIGH,"10")
   field(INPC,"06")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_00_08_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S264")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_08_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S520")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_08_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S776")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_08_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1032")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_08_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1288")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_08_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1544")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_08_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1800")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_00_08_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"00")
   field(HIGH,"10")
   field(INPC,"08")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_04_06_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S262")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_06_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S518")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_06_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S774")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_06_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1030")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_06_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1286")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_06_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1542")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_06_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1798")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_04_06_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"04")
   field(HIGH,"10")
   field(INPC,"06")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_02_01_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S257")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_01_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S513")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_01_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S769")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_01_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1025")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_01_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1281")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_01_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1537")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_01_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1793")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_02_01_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"02")
   field(HIGH,"10")
   field(INPC,"01")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_10_00_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S256")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_00_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S512")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_00_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S768")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_00_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1024")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_00_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1280")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_00_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1536")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_00_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1792")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_10_00_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"10")
   field(HIGH,"10")
   field(INPC,"00")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_00_02_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S258")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_02_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S514")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_02_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S770")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_02_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1026")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_02_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1282")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_02_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1538")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_02_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1794")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_00_02_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"00")
   field(HIGH,"10")
   field(INPC,"02")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_08_01_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S257")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_01_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S513")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_01_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S769")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_01_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1025")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_01_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1281")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_01_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1537")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_01_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1793")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_08_01_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"08")
   field(HIGH,"10")
   field(INPC,"01")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_02_06_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S262")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_06_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S518")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_06_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S774")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_06_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1030")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_06_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1286")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_06_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1542")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_06_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1798")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_02_06_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"02")
   field(HIGH,"10")
   field(INPC,"06")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_09_04_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S260")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_04_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S516")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_04_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S772")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_04_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1028")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_04_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1284")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_04_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1540")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_04_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1796")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_09_04_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"09")
   field(HIGH,"10")
   field(INPC,"04")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_02_08_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S264")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_08_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S520")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_08_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S776")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_08_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1032")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_08_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1288")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_08_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1544")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_08_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1800")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_02_08_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"02")
   field(HIGH,"10")
   field(INPC,"08")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_03_01_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S257")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_01_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S513")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_01_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S769")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_01_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1025")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_01_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1281")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_01_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1537")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_01_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1793")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_03_01_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"03")
   field(HIGH,"10")
   field(INPC,"01")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_10_05_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S261")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_05_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S517")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_05_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S773")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_05_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1029")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_05_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1285")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_05_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1541")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_05_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1797")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_10_05_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"10")
   field(HIGH,"10")
   field(INPC,"05")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_09_09_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S265")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_09_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S521")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_09_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S777")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_09_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1033")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_09_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1289")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_09_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1545")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_09_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1801")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_09_09_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"09")
   field(HIGH,"10")
   field(INPC,"09")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_10_06_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S262")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_06_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S518")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_06_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S774")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_06_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1030")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_06_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1286")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_06_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1542")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_06_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1798")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_10_06_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"10")
   field(HIGH,"10")
   field(INPC,"06")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_06_00_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S256")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_00_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S512")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_00_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S768")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_00_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1024")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_00_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1280")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_00_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1536")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_00_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1792")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_06_00_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"06")
   field(HIGH,"10")
   field(INPC,"00")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_00_11_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S267")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_11_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S523")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_11_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S779")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_11_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1035")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_11_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1291")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_11_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1547")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_11_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1803")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_00_11_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"00")
   field(HIGH,"10")
   field(INPC,"11")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_10_03_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S259")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_03_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S515")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_03_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S771")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_03_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1027")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_03_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1283")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_03_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1539")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_03_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1795")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_10_03_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"10")
   field(HIGH,"10")
   field(INPC,"03")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_06_02_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S258")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_02_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S514")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_02_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S770")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_02_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1026")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_02_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1282")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_02_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1538")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_02_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1794")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_06_02_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"06")
   field(HIGH,"10")
   field(INPC,"02")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_00_04_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S260")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_04_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S516")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_04_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S772")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_04_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1028")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_04_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1284")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_04_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1540")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_04_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1796")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_00_04_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"00")
   field(HIGH,"20")
   field(INPC,"04")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_06_04_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S260")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_04_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S516")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_04_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S772")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_04_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1028")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_04_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1284")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_04_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1540")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_04_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1796")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_06_04_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"06")
   field(HIGH,"10")
   field(INPC,"04")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_04_03_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S259")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_03_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S515")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_03_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S771")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_03_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1027")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_03_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1283")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_03_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1539")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_03_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1795")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_04_03_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"04")
   field(HIGH,"10")
   field(INPC,"03")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_03_09_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S265")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_09_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S521")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_09_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S777")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_09_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1033")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_09_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1289")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_09_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1545")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_09_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1801")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_03_09_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"03")
   field(HIGH,"10")
   field(INPC,"09")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_04_01_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S257")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_01_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S513")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_01_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S769")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_01_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1025")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_01_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1281")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_01_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1537")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_01_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1793")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_04_01_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"04")
   field(HIGH,"10")
   field(INPC,"01")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_04_10_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S266")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_10_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S522")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_10_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S778")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_10_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1034")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_10_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1290")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_10_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1546")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_10_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1802")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_04_10_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"04")
   field(HIGH,"10")
   field(INPC,"10")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_00_05_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S261")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_05_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S517")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_05_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S773")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_05_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1029")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_05_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1285")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_05_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1541")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_05_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1797")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_00_05_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"00")
   field(HIGH,"10")
   field(INPC,"05")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_05_08_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S264")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_08_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S520")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_08_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S776")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_08_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1032")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_08_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1288")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_08_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1544")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_08_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1800")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_05_08_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"05")
   field(HIGH,"10")
   field(INPC,"08")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_05_01_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S257")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_01_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S513")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_01_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S769")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_01_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1025")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_01_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1281")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_01_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1537")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_01_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1793")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_05_01_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"05")
   field(HIGH,"10")
   field(INPC,"01")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_08_11_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S267")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_11_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S523")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_11_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S779")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_11_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1035")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_11_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1291")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_11_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1547")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_11_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1803")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_08_11_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"08")
   field(HIGH,"10")
   field(INPC,"11")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_02_03_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S259")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_03_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S515")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_03_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S771")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_03_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1027")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_03_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1283")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_03_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1539")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_03_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1795")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_02_03_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"02")
   field(HIGH,"10")
   field(INPC,"03")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_05_05_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S261")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_05_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S517")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_05_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S773")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_05_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1029")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_05_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1285")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_05_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1541")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_05_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1797")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_05_05_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"05")
   field(HIGH,"10")
   field(INPC,"05")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_10_02_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S258")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_02_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S514")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_02_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S770")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_02_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1026")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_02_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1282")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_02_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1538")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_02_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1794")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_10_02_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"10")
   field(HIGH,"10")
   field(INPC,"02")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_08_02_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S258")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_02_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S514")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_02_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S770")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_02_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1026")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_02_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1282")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_02_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1538")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_02_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1794")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_08_02_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"08")
   field(HIGH,"10")
   field(INPC,"02")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_09_07_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S263")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_07_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S519")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_07_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S775")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_07_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1031")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_07_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1287")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_07_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1543")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_07_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1799")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_09_07_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"09")
   field(HIGH,"10")
   field(INPC,"07")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_08_07_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S263")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_07_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S519")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_07_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S775")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_07_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1031")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_07_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1287")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_07_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1543")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_07_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1799")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_08_07_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"08")
   field(HIGH,"10")
   field(INPC,"07")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_04_09_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S265")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_09_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S521")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_09_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S777")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_09_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1033")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_09_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1289")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_09_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1545")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_09_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1801")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_04_09_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"04")
   field(HIGH,"10")
   field(INPC,"09")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_04_05_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S261")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_05_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S517")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_05_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S773")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_05_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1029")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_05_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1285")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_05_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1541")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_05_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1797")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_04_05_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"04")
   field(HIGH,"10")
   field(INPC,"05")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_02_05_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S261")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_05_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S517")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_05_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S773")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_05_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1029")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_05_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1285")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_05_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1541")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_02_05_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C514 S1797")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_02_05_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"02")
   field(HIGH,"10")
   field(INPC,"05")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_05_10_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S266")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_10_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S522")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_10_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S778")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_10_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1034")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_10_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1290")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_10_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1546")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_10_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1802")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_05_10_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"05")
   field(HIGH,"10")
   field(INPC,"10")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_10_10_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S266")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_10_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S522")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_10_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S778")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_10_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1034")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_10_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1290")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_10_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1546")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_10_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1802")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_10_10_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"10")
   field(HIGH,"10")
   field(INPC,"10")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_10_09_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S265")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_09_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S521")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_09_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S777")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_09_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1033")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_09_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1289")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_09_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1545")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_10_09_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2562 S1801")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_10_09_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"10")
   field(HIGH,"10")
   field(INPC,"09")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_05_07_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S263")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_07_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S519")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_07_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S775")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_07_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1031")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_07_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1287")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_07_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1543")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_07_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1799")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_05_07_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"05")
   field(HIGH,"10")
   field(INPC,"07")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_05_03_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S259")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_03_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S515")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_03_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S771")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_03_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1027")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_03_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1283")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_03_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1539")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_05_03_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1282 S1795")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_05_03_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"05")
   field(HIGH,"10")
   field(INPC,"03")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_06_11_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S267")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_11_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S523")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_11_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S779")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_11_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1035")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_11_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1291")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_11_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1547")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_11_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1803")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_06_11_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"06")
   field(HIGH,"10")
   field(INPC,"11")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_09_02_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S258")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_02_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S514")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_02_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S770")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_02_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1026")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_02_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1282")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_02_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1538")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_09_02_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2306 S1794")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_09_02_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"09")
   field(HIGH,"10")
   field(INPC,"02")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_08_04_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S260")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_04_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S516")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_04_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S772")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_04_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1028")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_04_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1284")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_04_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1540")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_08_04_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2050 S1796")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_08_04_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"08")
   field(HIGH,"10")
   field(INPC,"04")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_00_07_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S263")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_07_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S519")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_07_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S775")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_07_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1031")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_07_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1287")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_07_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1543")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_07_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1799")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_00_07_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"00")
   field(HIGH,"10")
   field(INPC,"07")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_03_04_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S260")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_04_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S516")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_04_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S772")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_04_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1028")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_04_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1284")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_04_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1540")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_03_04_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C770 S1796")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_03_04_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"03")
   field(HIGH,"10")
   field(INPC,"04")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_06_08_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S264")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_08_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S520")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_08_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S776")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_08_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1032")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_08_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1288")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_08_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1544")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_06_08_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1538 S1800")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_06_08_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"06")
   field(HIGH,"10")
   field(INPC,"08")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_04_07_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S263")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_07_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S519")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_07_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S775")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_07_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1031")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_07_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1287")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_07_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1543")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_04_07_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C1026 S1799")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_04_07_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"04")
   field(HIGH,"10")
   field(INPC,"07")
   field(HSV,"MAJOR")
}
record(bo, "B_hv_CR2_00_00_CE") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(ZNAM,"OFF")
   field(DESC,"binary output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S256")
   field(ONAM,"ON")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_00_DV") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S512")
   field(PREC,"3")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_00_RDN") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S768")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_00_RUP") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1024")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_00_TC") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1280")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_00_MVDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1536")
   field(OMSL,"supervisory")
}
record(ao, "B_hv_CR2_00_00_MCDZ") {
   field(DTYP,"LecroyHV")
   field(PRIO,"LOW")
   field(DESC,"analog output record")
   field(SCAN,"Passive")
   field(OUT,"#C2 S1792")
   field(OMSL,"supervisory")
}
record(bigsub, "B_hv_CR2_00_00_property") {
   field(PRIO,"LOW")
   field(DESC,"big subroutine record")
   field(SCAN,"2 second")
   field(INPA,"02")
   field(SNAM,"ScanChannel")
   field(PREC,"3")
   field(INAM,"InitChannel")
   field(INPB,"00")
   field(HIGH,"10")
   field(INPC,"00")
   field(HSV,"MAJOR")
}
