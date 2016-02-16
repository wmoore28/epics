#!/bin/sh

trigger=$1
prescale=$2
usage='hpsTiPrescale.sh trigger[1-6] prescale[0-15]'

if ! [[ -n "$1" && -n "$2" ]]
then
  echo $usage
  exit
fi 

if [ "$prescale" -lt 0 ] || [ "$prescale" -gt 15 ]
then
  echo Invalid Prescale:  $prescale
  echo $usage
  exit
fi

if [ "$trigger" -lt 1 ] || [ "$trigger" -gt 6 ]
then
  echo Invalid Trigger:  $trigger
  echo $usage
  exit
fi

let epicsTrigger=$trigger-1

tcpClient hps11 "tiSetInputPrescale($1,$2)"

caput HPSTRIGPRESCALE_$epicsTrigger $2

