#!/bin/sh
echo 'Enter Title (NO SPACES ALLOWED, NO SPECIAL CHARACTERS ALLOWED)'
read title
echo 'Left Click in Window for Snapshot'
windowid=`xwininfo | grep "Window id" | awk '{print$4}'`
echo $windowid
java org/jlab/AutoLogEntry/MakeLogEntry $windowid $title 

