#!/bin/bash

APPS=`find -maxdepth 1 -name "*App" -type d `

touch linkmaker.txt
for dir in $APPS
do
	dir=`basename $dir`
	link=`echo $dir | sed -e 's/App//g'`
	if [ ! -h $link ]; then
		ln -s $dir $link
		echo $link >> linkmaker.txt
	fi
done
