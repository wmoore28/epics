.PHONY: realclean

# Production HV configuration
TOP=../..

HV_CLAS = hv.alhConfig

ifeq ($(APP),)
	APP = $(TOP)
endif

HV_CLAS_MF = $(APP)/hvcaApp/medm/alh/ecal_mf_01_01.alhConfig_mf \
             $(APP)/hvcaApp/medm/alh/bm_mf_01_13.alhConfig_mf \
             $(APP)/hvcaApp/medm/alh/bm_mf_02_13.alhConfig_mf

HV_CLAS_CONFIG = $(APP)/hvcaApp/medm/alh/ecal_ECAL_TOP.alhConfig \
                 $(APP)/hvcaApp/medm/alh/ecal_ECAL_BOTTOM.alhConfig \
                 $(APP)/hvcaApp/medm/alh/bm_beam_counter.alhConfig


install: $(HV_CLAS)

$(HV_CLAS): hv_header $(HV_CLAS_MF) $(HV_CLAS_CONFIG)
	$(RM) $@
	cat  $^ > $@

clean:
	$(RM) hv.alhConfig

$(HV_CLAS_MF) $(HV_CLAS_CONFIG): ../../hvcaApp/DB/Makefile
	$(MAKE) -C ../../hvcaApp/DB

# end of makefile
