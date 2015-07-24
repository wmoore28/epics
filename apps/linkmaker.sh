#!/bin/bash

APPS=`find -maxdepth 1 -name "*App" -type d | sort`

touch linkmaker.txt

rm .gitignore
echo "## DO NOT EDIT!" > .gitignore
echo "## This file is generated by linkmaker.sh (make install)" >> .gitignore
echo "linkmaker.txt" >> .gitignore

for dir in $APPS
do
    dir=`basename $dir`
    link=`echo $dir | sed -e 's/App//g'`
    echo $link >> .gitignore
    if [ ! -h $link ]; then
        ln -s $dir $link
        echo $link >> linkmaker.txt
    fi
done
