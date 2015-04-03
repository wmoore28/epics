#!/usr/bin/perl

$fname_MDA = @ARGV[0];
$fname_asc = $fname_MDA;
$fname_asc =~ s/mda/asc/;

print "fname_MDA = $fname_MDA \n";
print "fname_asc = $fname_asc \n";

$Data_Dir = "/usr/clas12/hps/DATA/hps_svt_scans";
$Analyzer_Dir = "/usr/clas12/hps/v1.1.0/tools/SVT_Scan_Analyzer";

#system ("/apps/mdautils-1.3.1/mda2ascii /usr/clas12/hps/DATA/hps_svt_scans/svt_top_scan_0005.mda -o /usr/clas12/hps/DATA/hps_svt_scans/svt_top_scan_0005.asc");
system("/apps/mdautils-1.3.1/mda2ascii $Data_Dir/$fname_MDA -o $Data_Dir/$fname_asc");
system("$Analyzer_Dir/analyze_svt_scan.exe $fname_asc 1");
print "Kuku \n";
