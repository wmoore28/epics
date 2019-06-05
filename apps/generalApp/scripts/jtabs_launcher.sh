#!/bin/bash
#
# Wrap this with xterm -e for use from MEDM.  Set remote hostname below.
#

host=hlbl00
user=hbops

echo "Running JTabs from $host..."
if [ "$USER" != "hpsrun" ] && [ "$USER" != "clasrun" ]; then
  read -p "Enter your username [$user]: " INPUT_STRING
  if [ "$INPUT_STRING" != "" ]; then
  	user=$INPUT_STRING
  fi
fi

#ssh $host -l $user jtabs
ssh $host -l $user jmenu

