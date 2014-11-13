#!/bin/sh

flasher=$1

caput ${flasher}:SEQ_START OFF
caput ${flasher}:GET_LEDS.SCAN "Passive"

exit
