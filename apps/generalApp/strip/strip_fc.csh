#!/bin/csh -f
StripTool $APP/general/strip/ec_rates_x10_y2000.stc  >& /dev/null &
StripTool $APP/general/strip/ec_rates_x10_y20000.stc >& /dev/null &
StripTool $APP/general/strip/ec_rates_x60_y20000.stc >& /dev/null &
StripTool $APP/general/strip/sc_rates_x10_y200.stc   >& /dev/null &
StripTool $APP/general/strip/sc_rates_x10_y2000.stc  >& /dev/null &
exit
