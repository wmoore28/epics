TOP=../..

RM = /bin/rm

ECALDATA = ecal.dat
CCECSDATA = ec3.dat ec4.dat ec5.dat  cc3.dat cc4.dat cc5.dat
CCECNDATA = ec1.dat ec2.dat ec6.dat cc1.dat cc2.dat cc6.dat
SCFDATA = sc1.dat sc2.dat sc3.dat sc4.dat sc5.dat sc6.dat
SCBDATA = sc_north.dat sc_south.dat sc_space.dat
LACDATA = lac1.dat lac2.dat
DCDATA = dc1.dat dc3.dat dc4.dat
BMDATA = bm.dat
EC_CAEN_DATA = ec_caen.dat

ECAL_DB = ecal_01.db
BM_DB = bm_01.db bm_02.db
BMTASC_DB = bmtasc_01.db bmtasc_02.db bmtasc_03.db bmtasc_04.db bmtasc_06.db bmtasc_07.db bmtasc_08.db
CCECS_DB = ccecs_03.db ccecs_04.db ccecs_05.db ccecs_07.db
CCECN_DB = ccecn_01.db ccecn_02.db ccecn_06.db ccecn_08.db
SCF_DB = scf_09.db scf_10.db
LAC_DB = lac_01.db lac_02.db lac_03.db lac_04.db
DC_DB = dc_01.db dc_03.db dc_04.db
EC_CAEN_DB = ec_caen.db

TPE_DATA = tpe.dat
TPE_DB = tpe.db

#PCAL_DATA = pcalhv.dat
#PCAL_DB = pcalhv.db


.PHONY : alh cr_mf_cleaning all distclean realclean
.SUFFIXES : .dat .db .database .adl .req
#all: $(BM_DB) $(BMTASC_DB) $(CCECS_DB) $(CCECN_DB) $(SCF_DB) $(LAC_DB)  $(DC_DB) \
#	$(EC_CAEN_DB) $(TPE_DB) \
#	../medm/adl/cc.adl ../medm/adl/ec.adl \
#	../medm/adl/sc.adl ../medm/adl/ta.adl \
#	../medm/adl/photon.adl ../medm/adl/bm.adl \
#	../medm/adl/lac.adl ../medm/adl/dc.adl \
#	../medm/adl/ec_caen.adl ../medm/adl/dc_by_loc.adl \
#	../medm/adl/tpe.adl ../medm/adl/ecal.adl
all: $(ECAL_DB)	../medm/adl/ecal.adl \
	$(BM_DB) ../medm/adl/bm.adl
	./fix_ecal_guies.sh

install: all

alh: ../medm/alh/*.alhConfig*
	$(MAKE) -C ../../generalApp/alh hv.alhConfig
ccecsc.dat: ccecs.dat ccecn.dat scf.dat
	$(RM) -f ccecsc.dat
	cat ccecs.dat ccecn.dat scf.dat > ccecsc.dat
bmtasc.dat: photon.dat ta.dat scb.dat
	$(RM) -f bmtasc.dat
	cat photon.dat ta.dat scb.dat > bmtasc.dat
cc.dat: cc1.dat cc2.dat cc3.dat cc4.dat cc5.dat cc6.dat
	$(RM) -f cc.dat
	cat cc1.dat cc2.dat cc3.dat cc4.dat cc5.dat cc6.dat > cc.dat
ec.dat: ec1.dat ec2.dat ec3.dat ec4.dat ec5.dat  ec6.dat 
	$(RM) -f ec.dat
	cat ec1.dat ec2.dat ec3.dat ec4.dat ec5.dat  ec6.dat \
		> ec.dat
#ec_caen.dat: $(EC_CAEN_DATA)
#	$(RM) -f $@
#	cat $^ > $@
ccecs.dat: $(CCECSDATA)
	$(RM) -f ccecs.dat
	cat $(CCECSDATA) > ccecs.dat
ccecn.dat: $(CCECNDATA)
	$(RM) -f ccecn.dat
	cat $(CCECNDATA) > ccecn.dat
scf.dat: $(SCFDATA)
	$(RM) -f scf.dat  
	cat $(SCFDATA) > scf.dat
scb.dat: $(SCBDATA)
	$(RM) -f scb.dat
	cat $(SCBDATA) > scb.dat
sc.dat: $(SCFDATA) $(SCBDATA)
	$(RM) -f sc.dat
	cat $(SCFDATA) $(SCBDATA) > sc.dat
lac.dat: $(LACDATA)
	$(RM) -f lac.dat
	cat $(LACDATA) > lac.dat
dc.dat: $(DCDATA)
	$(RM) -f dc.dat
	cat $(DCDATA) > dc.dat
dc_by_loc.dat: dc.dat
	dc_by_loc.pl
# configuration in ecal.pl is outdated, primary source is ecal.dat (per nerses).
#ecal.dat: ecal.pl
#	$^ > $@
test_mf: test_mf.db ../medm/adl/test_mf.adl
#
cr_mf_cleaning: 
	@echo Cleaning up old configs
	rm -f ../medm/alh/cr_mf*	
cr_mf: cr_mf_cleaning cr_mf.db ../medm/adl/cr_mf.adl
	$(MAKE) -C ../../generalApp/alh hv_cr.alhConfig
#
caen:    caen.db   ../medm/adl/caen.adl
#
caen102:    caen102.db   ../medm/adl/caen102.adl
#
clean:
	$(RM) -f ../medm/adl/*.csh *.db *.database ../req/*.req
	$(RM) -f ../medm/alh/*.alhConfig* ../medm/adl/*.alarm
	$(RM) -f ../medm/adl/*.adl
	$(RM) -f ../medm/adl/c*.snap
	$(RM) -f ../medm/adl/*.snap
	$(RM) -f ../medm/adl/*.alarms 
	$(RM) -f ../req/*.csh ../req/*.snap
	$(RM) -f ec.dat sc.dat cc.dat
	$(RM) -f ccec.dat
	$(RM) -f ccecsc.dat ccecs.dat ccecn.dat bmtasc.dat scb.dat scf.dat
	$(RM) -f ccecs_2.dat ccecn_2.dat bmtasc_2.dat
	$(RM) -f lac.dat
	$(RM) -f dc.dat
	$(RM) -f default.sdrSum

realclean: clean
distclean: realclean

%.files:
	$(MAKE) $*.db
	$(MAKE) ../medm/adl/$*.adl
%_2.db: %.dat
	@echo null command
$(CCECS_DB): ccecs.dat
	./dat2db.pl ccecs
$(CCECN_DB): ccecn.dat
	./dat2db.pl ccecn
$(BM_DB): bm.dat
	./dat2db.pl bm
	cp -f $(BM_DB) $(TOP)/db
$(BMTASC_DB): bmtasc.dat
	./dat2db.pl bmtasc
$(SCF_DB): scf.dat
	./dat2db.pl scf
$(LAC_DB): lac.dat
	./dat2db.pl lac
$(DC_DB): dc.dat
	./dat2db.pl dc
$(EC_CAEN_DB): ec_caen.dat
	./dat2db.pl ec_caen
$(ECAL_DB): ecal.dat
	./dat2db.pl ecal
	cp -f $@ $(TOP)/db
%.db: %.dat
	./dat2db.pl $*
../medm/adl/%.adl : %.dat
	echo $* | $(TOP)/bin/$(EPICS_HOST_ARCH)/hv_adl
	./dat2req.pl $*
	chmod +x $**.csh
	test -d ../medm/adl || mkdir ../medm/adl
	test -d ../req || mkdir ../req
	mv $**.adl ../medm/adl
#	mv $**.req ../req >& /dev/null
	mv $**.snap ../req
	mv $**.csh ../medm/adl
	mv $**.alarms ../medm/adl
	test -d ../medm/alh || mkdir ../medm/alh
	mv $**.alhConfig* ../medm/alh
	@echo "----------------------------------------"
	@echo "To update ALH configuration you need to:"
	@echo "make alh"
	@echo "----------------------------------------"
