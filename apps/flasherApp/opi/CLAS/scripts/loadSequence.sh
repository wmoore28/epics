#!/bin/sh
#script to check the existend of sequence file and run it

#Get the file with the values
seqfile=`caget -S -t ${1}:SEQ_FILE`
echo $seqfile

#Check the file exists
if [ !  -e "$seqfile" ]; then
    zenity --title="No sequence file" --question --text "$seqfile doesn't exist"; 
    exit;
fi

#else run it
echo "running $seqfile ${1}"

$seqfile ${1}



exit;

