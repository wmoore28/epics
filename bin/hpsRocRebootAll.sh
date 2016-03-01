#!/bin/bash

function rocwait
{
    echo
    for xx in `seq $1 -1 1`
    do
        echo -ne "Waiting $xx seconds ${@:2} ... \r"
        sleep 1
    done
    echo
}
function recrebo
{
    echo
    echo Rebooting $1 ...
    roc_reboot $1
    echo
}
function rocping
{
    while ! ping -q -a -c1 $1
    do
        sleep 1
    done
    echo $1 is Alive.
}

recrebo hps11
rocwait 30 after rebooting hps11
recrebo hps1
recrebo hps2
rocwait 45 before pinging
rocping hps2
rocping hps1
rocping hps11
rocwait 15 before restarting trigger IOC
ssh clonioc3 'echo 18 | xxd -r -p | nc localhost 20016'

echo
echo
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@ ROCS REBOOTED and TRIGGER IOC RESTARTED @@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo

