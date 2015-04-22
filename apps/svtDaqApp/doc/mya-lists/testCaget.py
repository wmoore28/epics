#!/usr/bin/python

import os,sys, subprocess




if len(sys.argv)<2:
    print "Need a list"
    sys.exit(1)


f = open(sys.argv[1],"r")

for line in f.readlines():
    l = line.split()[0]
    subprocess.call("caget " + l, shell="True")
