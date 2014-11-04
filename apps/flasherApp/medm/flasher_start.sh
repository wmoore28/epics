#!/bin/sh

flasher=$1

echo $flasher

caput ${flasher}:GET_LEDS.SCAN ".2 second"
caput ${flasher}:SEQ_START ON

exit
