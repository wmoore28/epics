#!/usr/bin/python

import subprocess
import math
from optparse import OptionParser
import sys

parser = OptionParser()
#parser.add_option("-n","--nodes", dest="nodes", help="nodes", nargs=">=0")
parser.add_option("-e","--exclude", help="Do not start these IOCs", type="string")
parser.add_option("-t","--test", help="test")
(options, args) = parser.parse_args()
print 'options: ', options
print 'args: ', args


xpos = 10
ypos = 0
xinc = 510
yinc = 120
lines = 8
color = "-bg green -fg black -sb -sl 5000"
geometry  = "-geometry 70x" + str(lines)

targetDir = "./../apps/iocBoot/iocsvtDaqDpm"
targetCntrlDpmDir = "./../apps/iocBoot/iocsvtDaq"

#ypos = yinc
for dpm_index in range (0, 15):
    ix = dpm_index % 3
    iy = math.floor(dpm_index/3)
    xpos = ix*xinc
    ypos = yinc + iy*yinc
    #print "x ", ix, " -> ", xpos, " y ", iy, " -> ", ypos
    position = geometry + "+" + str(xpos) + "+" + str(int(ypos))
    dpm = "dpm" + str(dpm_index)
    go = True
    if len(args)>0 and dpm not in args:
        print "skip ", dpm
        go = False
    title = "-T DPM" + str(dpm_index)
    exeName = "svtDaqDpm" + str(dpm_index) + ".cmd"
    command = "xterm " + title + " " + color + " " + position
    command += " -e 'pushd " + targetDir+ ";./" + exeName + ";bash'" 
    print command
    if options.exclude is not None:
        if options.exclude==dpm:
            print "skip", dpm 
            go=False
    if go:
        print "open"
        subprocess.Popen(command + "&", shell=True)
    if dpm_index == 0 or dpm_index == 1:
        xpos = (dpm_index+1)*510
        ypos = 0
        dtm = "dtm" + str(dpm_index)
        title = "-T DTM" + str(dpm_index)
        position = geometry + "+" + str(int(xpos)) + "+" + str(int(ypos))
        exeName = "svtDaqDtm" + str(dpm_index) + ".cmd"
        command = "xterm " + title + " " + color.replace("green","blue") + " " + position
        command += " -e 'pushd " + targetDir+ ";./" + exeName + ";bash'" 		
        print command
        go = True
        if options.exclude is not None:
            if options.exclude==dtm:
                print "skip", dtm 
                go = False
        if len(args)>0 and dtm not in args:
            go = False
        if go:
            print "open"
            subprocess.Popen(command + "&", shell=True)
    if dpm_index == 0:
        xpos = 0
        ypos = 0
        dtm = "cntrldpm"
        title = "-T CntrlDPM"
        position = geometry + "+" + str(int(xpos)) + "+" + str(int(ypos))
        exeName = "st.cmd"
        command = "xterm " + title + " " + color.replace("green","yellow") + " " + position
        command += " -e 'pushd " + targetCntrlDpmDir + ";./" + exeName + ";bash'" 		
        print command
        go = True
        if options.exclude is not None:
            if options.exclude==dtm:
                print "skip", dtm , 
                go = False
        if len(args)>0 and dtm not in args:
            print dtm, " not in args ", args
            go = False
        if go:
            print "open"
            subprocess.Popen(command + "&", shell=True)

