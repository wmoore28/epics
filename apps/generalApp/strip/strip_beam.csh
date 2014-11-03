#!/bin/csh -f
StripTool $APP/general/strip/scaler_upstream.stc >& /dev/null &
StripTool $APP/general/strip/scaler_downstream.stc >& /dev/null &
StripTool $APP/general/strip/beam_current.stc >& /dev/null &
StripTool $APP/general/strip/bpm.stc >& /dev/null &
exit
