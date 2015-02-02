#!/bin/sh

usage()
{
    echo "Usage: $0 [P [R]]" >&2
    exit 1
}

case "$#" in
    0)  P="wienerCrate:" ; R="1:" ;;
    1)  P="$1"           ; R="1:" ;;
    2)  P="$1"           ; R="$2" ;;
    *)  usage            ;;
esac

edm -x -m "P=$P,R=$R" WienerStatus.edl &
