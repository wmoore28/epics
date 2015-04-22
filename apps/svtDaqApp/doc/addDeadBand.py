import os,sys


def getLongStr(ss):
    s = ss
    for j in range(1,15):
        s += ss.replace("dpm:0","dpm:"+str(j))
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
    if "rx" in l or "num" in l:
        ll = l + " 1 1 \n"
        lll = getLongStr(ll)
        print "lll: ",lll
        fn.write(lll)
    elif "syncbase" in l or "syncpeak" in l:
        ll = l + " 10 10 \n"
        lll = getLongStr(ll)
        fn.write(lll)
    elif "sync_rd" in l:
        ll = l + " 1 1 \n"
        lll = getLongStr(ll)
        fn.write(lll)
    elif "eventstate" in l:
        ll = l + " 1 1 \n"
        lll = getLongStr(ll)
        fn.write(lll)
    elif "blockcount" in l or "eventcount" in l:
        ll = l + " 1 1 \n"
        lll = getLongStr(ll)
        fn.write(lll)
    elif "ackcount" in l or "readcount" in l or "trigcount" in l:
        ll = l + " 1 1 \n"
        lll = getLongStrDtm(ll)
        fn.write(lll)
    elif "v125" in l or "avdd" in l or "dvdd" in l:
        if "i_rd":
            ll = l + " 0.01 0.01 \n"
            lll = getLongStrDtm(ll)
        fn.write(lll)

    else:
        print "no archiving for ", l
    
fn.close()
f.close()

        
