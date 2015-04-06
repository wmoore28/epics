

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

XBASE=704
YBASE=74
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


for dpm in range(15):
    X = XBASE + 25 
    Y = YBASE + dpm*25
    CHA = "SVT:daq:dpm:" + str(dpm) + ":blockcount"
    CHB = "SVT:daq:dtm:0:readcount"
    t = template1    
    t=t.replace("XPOS",str(X))
    t=t.replace("YPOS",str(Y))    
    t=t.replace("CHA",CHA)
    t=t.replace("CHB",CHB)
    t=t.replace("WIDTH",str(WIDTH))
    t=t.replace("HEIGHT",str(HEIGHT))
    print t


