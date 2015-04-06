#/usr/bin/python

import os,sys


def getLongStr(ss):
    s = ss
    if "dpm:0" in ss:
        for j in range(1,15):
            s += ss.replace("dpm:0","dpm:"+str(j))
    if "daq:0" in ss:
        for j in range(1,15):
            s += ss.replace("daq:0","daq:"+str(j))
    return s

def getLongStrDtm(ss):
    s = ss
    for j in range(1,2):
        s += ss.replace("dtm:0","dtm:"+str(j))
    return s
        
    



if len(sys.argv)<2:
    print "Need a list"
    sys.exit(1)


f = open(sys.argv[1],"r")
fn = open(sys.argv[1]+".deadband","w")

for line in f.readlines():
    l = line.split()[0]
    print l
    if "dtm" in l:
        ll = l + " 1 \n"
        lll = getLongStrDtm(ll)
        fn.write(lll)
    else:
        ll = l + " 1 \n"
        lll = getLongStr(ll)    
        fn.write(lll)
fn.close()
f.close()
