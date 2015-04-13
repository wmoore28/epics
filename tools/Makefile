TOOLDIRS := harp_analyzer hpsrun LogEntry procServMgr SVT_Scan_Analyzer

.PHONY: all clean distclean install uninstall 

all:
	-@for dir in $(TOOLDIRS); do cd $$dir && make all ; cd .. ; done

install: all
	-@for dir in $(TOOLDIRS); do cd $$dir && make install ; cd .. ; done

clean:
	-@for dir in $(TOOLDIRS); do cd $$dir && make clean ; cd .. ; done

uninstall:
	-@for dir in $(TOOLDIRS); do cd $$dir && make uninstall ; cd .. ; done
