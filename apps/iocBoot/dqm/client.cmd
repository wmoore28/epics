
port 22222
host localhost

set lcsim.detector HPS_PhysicsRun2019-v2-FEE-Pass0
set lcsim.run 10031

#set lcsim.steering /org/hps/steering/recon/PhysicsRun2016OnlineRecon.lcsim
set lcsim.steering file:///home/hpsrun/online_recon/hps-java/steering-files/src/main/resources/org/hps/steering/monitoring/OnlineRecon2021KFTracker.lcsim

set lcsim.jvm_args -Xmx2400m

create 24 
start

