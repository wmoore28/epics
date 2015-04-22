

template ="""

"text update" {
			object {
				x=XPOS
				y=YPOS
				width=WIDTH
				height=HEIGHT
			}
			monitor {
				chan="CHAN"
				clr=31
				bclr=14
			}
			align="horiz. centered"
			limits {
			}
		}

"""

template1 = """

oval {
	object {
		x=XPOS
		y=YPOS
		width=20
		height=20
	}
	"basic attribute" {
		clr=20
	}
	"dynamic attribute" {
		vis="calc"
		calc="A!=B|A=0"
		chan="CHA"
		chanB="CHB"
	}
}

oval {
	object {
		x=XPOS
		y=YPOS
		width=20
		height=20
	}
	"basic attribute" {
		clr=15
	}
	"dynamic attribute" {
		vis="calc"
		calc="A=B&A>0"
		chan="CHA"
		chanB="CHB"
	}
}

"""


template2 = """

oval {
	object {
		x=XPOS
		y=YPOS
		width=20
		height=20
	}
	"basic attribute" {
		clr=20
	}
	"dynamic attribute" {
		vis="calc"
		calc="A=21"
		chan="CHA"
	}
}

oval {
	object {
		x=XPOS
		y=YPOS
		width=20
		height=20
	}
	"basic attribute" {
		clr=15
	}
	"dynamic attribute" {
		vis="calc"
		calc="A!21"
		chan="CHA"
	}
}

"""



XBASE=200
YBASE=62
WIDTH=20
HEIGHT=20


#for dpm in range(15):
#    for hyb in range(4):
#        for apv in range(5):
#            X = XBASE + 80 + 28*4*hyb + apv*22
#            Y = YBASE + dpm*25
#            CH = "SVT:daq:" + str(dpm) + ":" + str(hyb) + ":" + str(apv) + ":insertedframes_rd"#
#
#            t = template
#
#            t=t.replace("XPOS",str(X))
#            t=t.replace("YPOS",str(Y))
#            t=t.replace("CHAN",CH)
#            t=t.replace("WIDTH",str(WIDTH))
#            t=t.replace("HEIGHT",str(HEIGHT))
#            print t


#for dpm in range(15):
#    X = XBASE + 25 
#    Y = YBASE + dpm*25
#    CHA = "SVT:daq:dpm:" + str(dpm) + ":blockcount"
#    CHB = "SVT:daq:dtm:0:readcount"
#    t = template1    
#    t=t.replace("XPOS",str(X))
#    t=t.replace("YPOS",str(Y))    
#    t=t.replace("CHA",CHA)
#    t=t.replace("CHB",CHB)
#    t=t.replace("WIDTH",str(WIDTH))
#    t=t.replace("HEIGHT",str(HEIGHT))
#    print t

i = 0
for feb in range(10):
    for hyb in range(4):
        X = XBASE 
        Y = YBASE + i*25
        CHA = "SVT:lv:"+str(feb)+":" + str(hyb) + ":sync:sync_rd"
        t = template2    
        t=t.replace("XPOS",str(X))
        t=t.replace("YPOS",str(Y))    
        t=t.replace("CHA",CHA)
        t=t.replace("WIDTH",str(WIDTH))
        t=t.replace("HEIGHT",str(HEIGHT))
        i = i + 1
        print t


