#!/bin/bash
#
# Wrap this with xterm -e for use from MEDM.  Set remote hostname below.
#

host=clonpc19
user=hpsrun

while getopts h: opt; do
  case $opt in
  h)
    host=$OPTARG
    ;;
  esac
done
shift $((OPTIND - 1))

echo "Running MyaViewer from $host..."
read -p "Enter your username [$user]: " INPUT_STRING
if [ "$INPUT_STRING" != "" ]; then
	user=$INPUT_STRING
fi

ssh $host -l $user MyaViewer
