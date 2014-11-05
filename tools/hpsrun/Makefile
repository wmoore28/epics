INSTALL_BIN := ~hpsrun/bin
OWNER := hpsrun
GROUP := onliners

PROGFILES   += hps_epics

.PHONY: all clean install uninstall


install:
	@for file in $(PROGFILES); do \
		echo "Installing $(INSTALL_BIN)/$$file" ; \
		install -m 0755 -o $(OWNER) -g $(GROUP) $$file $(INSTALL_BIN) ; \
	done

uninstall:
	@for file in $(PROGFILES); do $(RM) $(INSTALL_BIN)/$$file; done
