#!/bin/env python
import os
import epics
import time

epicsVars = [
    'SVT:atca1:1:DPM0:i_rd',
    'SVT:atca1:1:DPM1:i_rd',
    'SVT:atca1:1:DPM2:i_rd',
    'SVT:atca1:1:DPM3:i_rd',
    'SVT:atca1:1:DTM:i_rd',
    'SVT:atca1:1:RTM:i_rd',
    'SVT:atca1:1:CEN:i_rd',
    'SVT:atca1:2:DPM0:i_rd',
    'SVT:atca1:2:DPM1:i_rd',
    'SVT:atca1:2:DPM2:i_rd',
    'SVT:atca1:2:DPM3:i_rd',
    'SVT:atca1:2:DTM:i_rd',
    'SVT:atca1:2:RTM:i_rd',
    'SVT:atca1:2:CEN:i_rd']


pv = {}
for var in epicsVars:
    pv[var] = epics.pv.PV(var)
    pass

while True:
    time.sleep(1)
    cmd = 'cob_dump --all atca1 | grep mA'
    result = os.popen(cmd).read()
    result = result.splitlines()
    for i,line in enumerate(result):
        line = line.split()
        current = -999
        if line[1] == "RTM": current = int(line[10][:-2])
        else: current = int(line[11][:-2])
        pv[epicsVars[i]].put(current)
        pass
    pass

