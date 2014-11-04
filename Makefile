.PHONY: all install clean distclean rebuild todo tools clean-tools install-tools uninstall-tools tar

## apps/
all:
	(cd apps; make all)

install:
	(cd apps; make install)

clean:
	(cd apps; make clean)

distclean:
	(cd apps; make distclean)

rebuild: clean install

todo:
	@find apps -type f -exec egrep -HIn TODO \{\} \; 2> /dev/null
	@find apps -type f -exec egrep -HIn FIXME \{\} \; 2> /dev/null

## tools/
tools:
	(cd tools; make all)

clean-tools:
	(cd tools; make clean)

install-tools:
	(cd tools; make install)

uninstall-tools:
	(cd tools; make uninstall)

## misc
tar: distclean
	@cd ../ && tar czf hps-epics-`date +%Y.%m.%d`.tgz epics
