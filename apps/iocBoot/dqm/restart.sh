#!/bin/bash

echo Disabling tomcat ...
ssh clonfarm11 sudo systemctl stop tomcat

echo Restarting et ...
softioc_console -R dqm_et >& /dev/null
sleep 5

echo Restarting evio2et ...
softioc_console -R dqm_evio2et >& /dev/null
sleep 5

echo Restarting dqm server ...
softioc_console -R dqm_server >& /dev/null
sleep 7

echo Restarting dqm client ...
softioc_console -R dqm_client >& /dev/null

sleep 2

echo Restarting tomcat ...
ssh clonfarm11 sudo systemctl start tomcat

