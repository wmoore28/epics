#! /bin/tcsh -f
rm -f $1.dat.out
../bin/hvca <<+
r
$1.dat
w
$1.dat.out
q
+
exit
