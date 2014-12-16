#!/bin/tcsh
set channel=$1
caput $channel.HHSV NO_ALARM
caput $channel.HSMV NO_ALARM
caput $channel.LSMV NO_ALARM
caput $channel.LLSV NO_ALARM
exit
