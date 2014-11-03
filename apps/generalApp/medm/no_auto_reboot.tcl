#!/bin/env expectk
message .message -text "Auto reboot is not working for this IOC. To reboot it you must use the following method:

1. telnet to the IOC, username = clasrun, password = usual online password

2. In response the the prompt, type \"reboot\"

No IOC console will appear."
button .dismiss -text Dismiss -command exit
pack .message .dismiss -fill x
