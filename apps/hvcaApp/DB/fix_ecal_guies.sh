#!/bin/bash 

rm -f 1.tmp
for f in ../medm/adl/ecal_ECAL_*.adl 
do
    cat $f | sed -e 's/_CE/_CHHV/g' >1.tmp
    mv -f 1.tmp $f
done
