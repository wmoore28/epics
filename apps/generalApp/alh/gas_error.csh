#!/bin/tcsh
#mailx -s "EPICS gas alarm" mvineyar@richmond.edu jacobsg@jlab.org \
#	christo@jlab.org marki@jlab.org <<+
#Sent automatically by alh.
#+
rm -f /home/clasrun/last_gas_alarm.txt
date > /home/clasrun/last_gas_alarm.txt
exit
