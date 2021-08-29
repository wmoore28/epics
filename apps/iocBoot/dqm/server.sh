#!/bin/bash

ulimit -u 12000 

i=/home/hpsrun/online_recon
o=/scratch/hpsrun/dqm

export JAVA_HOME=/usr/lib/jvm/java-11
export PATH=$JAVA_HOME:$PATH

$i/bin/online-recon-server \
--port 22222 \
--host localhost \
-w $o/stations \
-c ./server.cfg

