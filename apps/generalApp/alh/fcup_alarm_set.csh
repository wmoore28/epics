#!/bin/tcsh -f
# major alarm on the way down
caput scaler_calc1.LLSV 2
caput scaler_calc1.LOLO 0.099
# minor alarm on the way up
caput scaler_calc1.HHSV 1
caput scaler_calc1.HIHI 0.101
exit
