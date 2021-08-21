#!/bin/sh
#utility to screen capture
filename="${HOME}/newfile.png"

if ! zenity --title="Capture screen to file"  --question  --text="Click <b>Capture</b>,then select a rectangular area. \nYou will then be asked to save to file."; then
    exit;
fi

#gnome-screenshot -a -f /tmp/css-screenshot.png >& /dev/null
#import tmp/screenshot.png >& /dev/null
file=`zenity --title="Capture screen to file" --file-selection --filename=${filename} --save --confirm-overwrite --height=500 --width=700`

if [ -n "$file" ]; then
    echo "Saving sceen capture to $file"
    /bin/cp -f  /tmp/screenshot.png $file
fi

exit 0;
