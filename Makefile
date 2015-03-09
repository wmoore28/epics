.PHONY: all install clean distclean rebuild \
	tools clean-tools install-tools uninstall-tools \
	test test-all test-env \
	hps tar todo

## HPS - build epics apps and tools
hps: all tools svtdaqlib		# Build all EPICS Apps and Tools

## EPICS Only (apps/)
all: test-env
	(cd drivers; make all)
	(cd apps; make all)

install:
	(cd drivers; make install)
	(cd apps; make install)

clean: 
	(cd drivers; make clean)
	(cd apps; make clean)

distclean:
	(cd drivers; make distclean)
	(cd apps; make distclean)

rebuild: clean install

## Tools Only (tools/)
tools:
	(cd tools; make all)

clean-tools:
	(cd tools; make clean)

install-tools:
	(cd tools; make install)

uninstall-tools:
	(cd tools; make uninstall)

## Test Builds
test: test-all

test-all:  ## Check env and run all targets, except installs
	@./utils/testbuild.sh

test-env:	## Check env variables only
	@./utils/testbuild.sh -e

## misc
# TODO (wmoore): fix hard-coded path for making tar file).
tar: distclean
	@cd ../ && tar czf hps-epics-`date +%Y.%m.%d`.tgz epics

todo:
	@find drivers -type f -exec egrep -HIn TODO \{\} \; 2> /dev/null
	@find drivers -type f -exec egrep -HIn FIXME \{\} \; 2> /dev/null
	@find apps -type f -exec egrep -HIn TODO \{\} \; 2> /dev/null
	@find apps -type f -exec egrep -HIn FIXME \{\} \; 2> /dev/null
