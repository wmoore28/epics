#
# New version of StripTool looks for .stp extenstion.  Make links to old .stc files.
#
# TODO: move .stc to .stp for new StripTool version (wmoore)
#

.PHONY: all clean distclean install rebuild realclean

STC_FILES = $(shell find ./ -name "*.stc")

STP_LINK_COMMAND = $(foreach file_with_path, $(STC_FILES), \
	ln -sf $(file_with_path) $(basename $(notdir $(file_with_path))).stp ; \
	echo $(basename $(notdir $(file_with_path))).stp >> .gitignore; )

all:
	$(RM) .gitignore
	$(STP_LINK_COMMAND)

install: all
