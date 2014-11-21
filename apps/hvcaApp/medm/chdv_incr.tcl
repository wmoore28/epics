#!/bin/env wish
set file [lindex $argv 0]
frame .group_line
frame .voltage_line
frame .button_line
label .group_label -text "Group to change (integer) = "
entry .group -width 3 -relief sunken -textvariable group
label .delta_v_label -text "Change in voltage magnitude = "
entry .delta_v -width 6 -relief sunken -textvariable delta_v
button .go \
	-command {exec >&@stdout $env(APP)/hvcaApp/medm/chdv_incr.perl $env(APP)/hvcaApp/DB/$file $group $delta_v} \
    -text Go
button .quit -command exit -text Quit
pack .group_line .voltage_line .button_line
pack .group_label .group -in .group_line -side left
pack .delta_v_label .delta_v -in .voltage_line -side left
pack .go .quit -in .button_line -side left
