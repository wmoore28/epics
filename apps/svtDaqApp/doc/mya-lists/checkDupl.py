#!/usr/bin/python

import os,sys, subprocess

def checkDuplLine(fname):
    f = open(sys.argv[1],"r")
    lines = f.readlines()
    
    for line in lines:
        count = 0
        for line_loop in lines:
            if line_loop == line:
                count = count + 1
        if count !=1:
            print "ERROR foud ", count, " of line: \"", line, "\""
            sys.exit(1)

if len(sys.argv)<2:
    print "Need a list of files"
    sys.exit(1)

for i in range(len(sys.argv)):
    if i==0:
        continue
    fname = sys.argv[i]
    print "processing ", fname
    checkDuplLine(fname)
    print "passed"


