#!/bin/csh -f
StripTool $APP/general/strip/chamber_pressures.stc >& /dev/null &
StripTool $APP/general/strip/arco2_ratios.stc >& /dev/null &
StripTool $APP/general/strip/input_flows.stc >& /dev/null &
exit
