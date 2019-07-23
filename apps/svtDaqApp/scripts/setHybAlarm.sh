#!/bin/bash
basedir="${0/%`basename $0`/}"
pushd $basedir

caput HPS_SVT:PLC:i:RTD_SVT_Supply-Value.LOLO 12.0
caput HPS_SVT:PLC:i:RTD_SVT_Supply-Value.LOW 13.0
caput HPS_SVT:PLC:i:RTD_SVT_Supply-Value.HIGH 17.0
caput HPS_SVT:PLC:i:RTD_SVT_Supply-Value.HIHI 18.0

caput HPS_SVT:PLC:i:RTD_SVT_Return-Value.LOLO 12.0
caput HPS_SVT:PLC:i:RTD_SVT_Return-Value.LOW 13.0
caput HPS_SVT:PLC:i:RTD_SVT_Return-Value.HIGH 17.0
caput HPS_SVT:PLC:i:RTD_SVT_Return-Value.HIHI 18.0

#./allHybCaput.sh SVT:temp:hyb temp0:t_rd.LOLO
#./allHybCaput.sh SVT:temp:hyb temp0:t_rd.LOW
#./allHybCaput.sh SVT:temp:hyb temp0:t_rd.HIGH
#./allHybCaput.sh SVT:temp:hyb temp0:t_rd.HIHI

for feb in `seq 0 9`
do
for ch in `seq 0 3`
do
if (feb == 2 || feb == 9) && (ch == 2 || ch ==3)
caput SVT:temp:hyb:$feb:$ch:temp0:t_rd.LOLO 10.0
caput SVT:temp:hyb:$feb:$ch:temp0:t_rd.LOW 11.0
caput SVT:temp:hyb:$feb:$ch:temp0:t_rd.HIGH 20.0
caput SVT:temp:hyb:$feb:$ch:temp0:t_rd.HIHI 22.0
done
done
