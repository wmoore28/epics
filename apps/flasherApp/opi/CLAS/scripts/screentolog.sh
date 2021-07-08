#!/bin/sh
xwininfo | grep "Window id" | awk '{print$4}'
java org/jlab/AutoLogEntry/MakeLogEntry $id Flasher.opi
exit

image="/usr/share/icons/gnome/48x48/devices/camera.png"

if  yad --title="Capture screen to log book" --image=${image} --question --text="Click <b>Capture</b>,then select a rectangular area. \nYou will then have the option of a comment." --buttons-layout=spread --button=Capture:0 --button=Cancel:1 --width=400; then
    gnome-screenshot -a -f /tmp/css-screenshot.png >& /dev/null

    fullcomment=`yad --title="Capture screen to log book" --form --field="<b>Enter your name and a comment</b> (Or leave blank if you want):LBL" --field=Name --field=Comment:TXT --height=500 --width=500 --image=/tmp/css-screenshot.png --image-on-top --separator="£"`;

    if [ $? = 1 ]; then     #if cancel, exit
	exit 1;
    else
    	name=`echo $fullcomment | gawk 'BEGIN {FS="£"}{n="Unknown";if(length($1)>=1)n=$1;print n}'`
	comment=`echo $fullcomment | gawk 'BEGIN {FS="£"}{n="No comment";if(length($2)>=1)n=$2;print n}'`
	echo "Sending sceen capture to Logbook"
	echo "Author: $name"
	echo "Comment: $comment"
        #logbook command here
    fi
fi

exit 0;
