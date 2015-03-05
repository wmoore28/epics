#!/usr/bin/python

import subprocess
import math
from optparse import OptionParser
import sys

parser = OptionParser()
#parser.add_option("-e","--exclude", help="Do not start this IOC", type="string")
parser.add_option("-a","--action", help="start/stop/status", type="string", default="status")
parser.add_option("-t", action="store_true", dest="test")
(options, args) = parser.parse_args()
print 'options: ', options
print 'args: ', args

iocBootDir = "/usr/clas12/hps/dev/apps/iocBoot"


print "Data DPM's"

for dpm in range(0,17):
    
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
        cmd = "procServMgr -p " + iocBootDir + " -i " + iocName + " " + options.action
        print cmd
        if not options.test:
            process = subprocess.Popen(cmd,shell=True,stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            out, err = process.communicate()
            errcode = process.returncode
            print out
            if err is not None:
                print err
            print "Error code: ", errcode

    

