#!/bin/bash
basedir="${0/%`basename $0`/}"
pushd $basedir
./allFebCaput.sh SVT:lv:fe anan:i_rd.LOLO 0.3
./allFebCaput.sh SVT:lv:fe anan:i_rd.LOW 0.31
./allFebCaput.sh SVT:lv:fe anan:i_rd.HIGH 0.33
./allFebCaput.sh SVT:lv:fe anan:i_rd.HIHI 0.34

caput SVT:lv:fe:0:anan:i_rd.LOLO 0.27
caput SVT:lv:fe:0:anan:i_rd.LOW 0.275
caput SVT:lv:fe:0:anan:i_rd.HIGH 0.295
caput SVT:lv:fe:0:anan:i_rd.HIHI 0.305
caput SVT:lv:fe:8:anan:i_rd.LOLO 0.27
caput SVT:lv:fe:8:anan:i_rd.LOW 0.275
caput SVT:lv:fe:8:anan:i_rd.HIGH 0.295
caput SVT:lv:fe:8:anan:i_rd.HIHI 0.305

./allFebCaput.sh SVT:lv:fe anap:i_rd.LOLO 2.9
./allFebCaput.sh SVT:lv:fe anap:i_rd.LOW 3.0
./allFebCaput.sh SVT:lv:fe anap:i_rd.HIGH 3.2
./allFebCaput.sh SVT:lv:fe anap:i_rd.HIHI 3.3

caput SVT:lv:fe:0:anap:i_rd.LOLO 1.95
caput SVT:lv:fe:0:anap:i_rd.LOW 2.02
caput SVT:lv:fe:0:anap:i_rd.HIGH 2.15
caput SVT:lv:fe:0:anap:i_rd.HIHI 2.2
caput SVT:lv:fe:8:anap:i_rd.LOLO 1.95
caput SVT:lv:fe:8:anap:i_rd.LOW 2.02
caput SVT:lv:fe:8:anap:i_rd.HIGH 2.15
caput SVT:lv:fe:8:anap:i_rd.HIHI 2.2

./allFebCaput.sh SVT:lv:fe digi:i_rd.LOLO 0.9
./allFebCaput.sh SVT:lv:fe digi:i_rd.LOW 1.0
./allFebCaput.sh SVT:lv:fe digi:i_rd.HIGH 1.2
./allFebCaput.sh SVT:lv:fe digi:i_rd.HIHI 1.3

./allFebCaput.sh SVT:lv:fe digi:v_sens.HIHI 5.6
./allFebCaput.sh SVT:lv:fe anan:v_sens.HIHI 5.6
./allFebCaput.sh SVT:lv:fe anap:v_sens.HIHI 5.6
./allFebCaput.sh SVT:lv:fe digi:v_sens.HIGH 5.55
./allFebCaput.sh SVT:lv:fe anan:v_sens.HIGH 5.55
./allFebCaput.sh SVT:lv:fe anap:v_sens.HIGH 5.55
./allFebCaput.sh SVT:lv:fe digi:v_sens.LOW 5.45
./allFebCaput.sh SVT:lv:fe anan:v_sens.LOW 5.45
./allFebCaput.sh SVT:lv:fe anap:v_sens.LOW 5.45
./allFebCaput.sh SVT:lv:fe digi:v_sens.LOLO 5.4
./allFebCaput.sh SVT:lv:fe anan:v_sens.LOLO 5.4
./allFebCaput.sh SVT:lv:fe anap:v_sens.LOLO 5.4

./allFebCaput.sh SVT:lv:fe anan:v_term.HIHI 6.75
./allFebCaput.sh SVT:lv:fe anan:v_term.HIGH 6.70
./allFebCaput.sh SVT:lv:fe anan:v_term.LOW 6.51
./allFebCaput.sh SVT:lv:fe anan:v_term.LOLO 6.45

caput SVT:lv:fe:0:anan:v_term.HIHI 6.60
caput SVT:lv:fe:0:anan:v_term.HIGH 6.555
caput SVT:lv:fe:0:anan:v_term.LOW 6.30
caput SVT:lv:fe:0:anan:v_term.LOLO 6.25
caput SVT:lv:fe:8:anan:v_term.HIHI 6.60
caput SVT:lv:fe:8:anan:v_term.HIGH 6.555
caput SVT:lv:fe:8:anan:v_term.LOW 6.30
caput SVT:lv:fe:8:anan:v_term.LOLO 6.25

./allFebCaput.sh SVT:lv:fe anap:v_term.HIHI 7.35
./allFebCaput.sh SVT:lv:fe anap:v_term.HIGH 7.29
./allFebCaput.sh SVT:lv:fe anap:v_term.LOW 7.21
./allFebCaput.sh SVT:lv:fe anap:v_term.LOLO 7.15

caput SVT:lv:fe:0:anap:v_term.HIHI 6.80
caput SVT:lv:fe:0:anap:v_term.HIGH 6.75
caput SVT:lv:fe:0:anap:v_term.LOW 6.55
caput SVT:lv:fe:0:anap:v_term.LOLO 6.50
caput SVT:lv:fe:8:anap:v_term.HIHI 6.80
caput SVT:lv:fe:8:anap:v_term.HIGH 6.75
caput SVT:lv:fe:8:anap:v_term.LOW 6.55
caput SVT:lv:fe:8:anap:v_term.LOLO 6.50

for ch in digi anap anan
do
for var in i_rd v_sens v_term
do
./allFebCaput.sh SVT:lv:fe "$ch:$var.HHSV" MAJOR
./allFebCaput.sh SVT:lv:fe "$ch:$var.HSV" MINOR
./allFebCaput.sh SVT:lv:fe "$ch:$var.LSV" MINOR
./allFebCaput.sh SVT:lv:fe "$ch:$var.LLSV" MAJOR
done
done

./allFebCaput.sh SVT:lv:fe digi:v_term.HIHI 7.2
./allFebCaput.sh SVT:lv:fe digi:v_term.HIGH 7.1
./allFebCaput.sh SVT:lv:fe digi:v_term.LOW 6.9
./allFebCaput.sh SVT:lv:fe digi:v_term.LOLO 6.8


for ch in `seq 0 3`
do
caput "SVT:lv:fl:$ch:i_rd.HIHI" 0.75
caput "SVT:lv:fl:$ch:i_rd.HIGH" 0.70
caput "SVT:lv:fl:$ch:i_rd.LOW" 0.50
caput "SVT:lv:fl:$ch:i_rd.LOLO" 0.45
caput "SVT:lv:fl:$ch:v_term.HIHI" 7.0
caput "SVT:lv:fl:$ch:v_term.HIGH" 6.9
caput "SVT:lv:fl:$ch:v_term.LOW" 6.3
caput "SVT:lv:fl:$ch:v_term.LOLO" 6.2
caput "SVT:lv:fl:$ch:v_sens.HIHI" 5.6
caput "SVT:lv:fl:$ch:v_sens.HIGH" 5.55
caput "SVT:lv:fl:$ch:v_sens.LOW" 5.45
caput "SVT:lv:fl:$ch:v_sens.LOLO" 5.4

for var in i_rd v_sens v_term
do
caput "SVT:lv:fl:$ch:$var.HHSV" MAJOR
caput "SVT:lv:fl:$ch:$var.HSV" MINOR
caput "SVT:lv:fl:$ch:$var.LSV" MINOR
caput "SVT:lv:fl:$ch:$var.LLSV" MAJOR
done
done

popd
