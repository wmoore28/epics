#!/bin/sh
ssh clonioc3 'echo 18 | xxd -r -p | nc localhost 20016'

