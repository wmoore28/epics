#!/usr/bin/python
import subprocess, sys

def getBiasName(half,id,name):
    ch = "SVT:bias:" + half + ":" + str(id) + ":" + name
    return ch

def getBiasLimit(half,id):
    return [-178,-1]

def caputLimit(ch, type, limit, doIt=False):
     cmd = "caput " +  ch + "." + type + " " + str(limit)
     print cmd
     if doIt:
        subprocess.call(cmd, shell=True)

def caputLevel(ch, type, level, doIt=False):
     cmd = "caput " +  ch + "." + type + " " + level
     print cmd
     if doIt:
        subprocess.call(cmd, shell=True)

def setBiasLimits(doIt):

    for half in ["top","bot"]:
        if half=="top":
            r = range(0,18)
        else:
            r = range(20,38)
        for id in r:
            ch = getBiasName(half, id, "v_sens")                             
            print "Processing \"" + ch + "\""
            caputLimit(ch,"LOLO",177.0, doIt)
            caputLimit(ch,"LOW",178.0, doIt)
            caputLimit(ch,"HIGH",182, doIt)
            caputLimit(ch,"HIHI",183.0, doIt)
            caputLevel(ch,"HHSV","MAJOR", doIt)
            caputLevel(ch,"HSV","MINOR", doIt)
            caputLevel(ch,"LSV","MINOR", doIt)
            caputLevel(ch,"LLSV","MAJOR", doIt)



def main(args):
    print "go"
    doIt = False
    if len(args)>1:
        if args[1] == "doIt":
            doIt = True
    
    
    setBiasLimits(doIt)

if __name__=="__main__":
    main(sys.argv)

    
            

    
