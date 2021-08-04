
i=/home/hpsrun/online_recon
o=/scratch/hpsrun/dqm

$i/bin/hps-recon-server \
--port 22222 \
--host localhost \
-w $o/stations \
-c ./server.cfg

