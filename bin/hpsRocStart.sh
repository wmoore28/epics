#!/bin/sh

if [ -z "$1" ]; then
  ssh=
  host=$HOST
else
  ssh=ssh $1
  host=$1
fi

if [ $host = "hps11" ]; then
  $ssh coda_roc_gef -s clashps -o "$host TS"
elif [ $host = "hps12" ]; then
  $ssh coda_roc_gef -s clashps -o "$host ROC"
elif [ $host = "hps1" ]; then
  $ssh coda_roc_gef -s clashps -o "$host ROC"
elif [ $host = "hps2" ]; then
  $ssh coda_roc_gef -s clashps -o "$host ROC"
elif [ $host = "hps1gtp" ]; then
  $ssh coda_roc -s clashps -o "$host ROC"
elif [ $host = "hps2gtp" ]; then
  $ssh coda_roc -s clashps -o "$host ROC"
else
  echo INVALID HOST:  $host
fi
