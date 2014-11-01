#!/bin/tcsh
rm -f Makefile Makefile.tmp
cvs update Makefile
sed s/ec4/ec4_no_mf_4/ Makefile > Makefile.tmp
mv Makefile.tmp Makefile
make clean
make
cd ../../general
make
exit
