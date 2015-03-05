#!/usr/bin/python

import subprocess
import math
from optparse import OptionParser
import sys

parser = OptionParser()
#parser.add_option("-n","--nodes", dest="nodes", help="nodes", nargs=">=0")
parser.add_option("-t", action="store_true", dest="test")
(options, args) = parser.parse_args()
print options
print args

xpos = 10
ypos = 0
xinc = 510
yinc = 120
lines = 8
color = "-bg green -fg black -sb -sl 5000"
geometry  = "-geometry 70x" + str(lines)

procServConf = "/usr/clas12/hps/dev/apps/iocBoot/procServ.conf"
iocNames = {}
for l in open(procServConf,"r").readlines():
    if "svtDaq" in l:
        iocNames[l.split()[0].replace(":","")] = l.split()[2].replace(":","")


print "SVT DAQ IOC's: ", iocNames 


for dpm in range (0, 17):

    ix = dpm % 3
    iy = math.floor(dpm/3)
    xpos = ix*xinc
    ypos = yinc + iy*yinc
    #print "x ", ix, " -> ", xpos, " y ", iy, " -> ", ypos
    position = geometry + "+" + str(xpos) + "+" + str(int(ypos))

    name = "dpm" + str(dpm)
    iocName =  "iocsvtDaqDpm" + str(dpm)
    if dpm==14:
        name = "controldpm"
        iocName = "iocsvtDaq"
    if dpm==15:
        name = "dtm0"
        iocName = "iocsvtDaqDtm0"
    if dpm==16:
        name = "dtm1"
        iocName = "iocsvtDaqDtm1"

    go = True    
    if len(args)>0 and name not in args:
        go = False
    
    if go:
        cmd = "telnet localhost " + iocNames[iocName]
        title = "-T " + iocName
        command = "xterm " + title + " " + color + " " + position
        command += " -e '" + cmd + ";bash'" 
        print command
        if not options.test:
            #process = subprocess.Popen(command + "&",shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            #out, err = process.communicate()
            #errcode = process.returncode
            #print out
            #if err is not None:
            #    print err
            #print "Error code: ", errcode
            process = subprocess.Popen(command + "&",shell=True)
