# 
# INSTALL_BIN should be somewhere inside ~hpsrun.  Do not set this to something 
# like /usr/local/bin without modifying install.  Install will create the 
# directory if needed and setting ownership.
#

INSTALL_BIN := ~hpsrun/bin
OWNER := hpsrun
GROUP := onliners

PROGFILES += hps_epics


.PHONY: all clean install uninstall


install:
	-mkdir -p $(INSTALL_BIN)
	-chown $(OWNER):$(GROUP) $(INSTALL_BIN)
	@for file in $(PROGFILES); do \
		echo "Installing $(INSTALL_BIN)/$$file" ; \
		install -m 0755 -o $(OWNER) -g $(GROUP) $$file $(INSTALL_BIN) ; \
	done

uninstall:
	@for file in $(PROGFILES); do $(RM) $(INSTALL_BIN)/$$file; done
