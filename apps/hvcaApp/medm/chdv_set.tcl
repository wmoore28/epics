#!/bin/env wish
set file [lindex $argv 0]
frame .group_line
frame .voltage_line
frame .button_line
label .group_label -text "Group to set (integer) = "
entry .group -width 3 -relief sunken -textvariable group
label .set_v_label -text "Set voltage = "
entry .set_v -width 6 -relief sunken -textvariable set_v
button .go \
	-command {exec >&@stdout $env(APP)/hvcaApp/medm/chdv_set.perl $env(APP)/hvcaApp/DB/$file $group $set_v} \
    -text Go
button .quit -command exit -text Quit
pack .group_line .voltage_line .button_line
pack .group_label .group -in .group_line -side left
pack .set_v_label .set_v -in .voltage_line -side left
pack .go .quit -in .button_line -side left
