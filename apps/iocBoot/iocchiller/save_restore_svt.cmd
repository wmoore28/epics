  ## General settings
  save_restoreSet_status_prefix("$(IOC_ALIAS):")
  save_restoreSet_Debug(0)
  save_restoreSet_IncompleteSetsOk(1)
  save_restoreSet_DatedBackupFiles(1)
  save_restoreSet_NumSeqFiles(3)
  save_restoreSet_SeqPeriodInSeconds(30)

  ## Specify paths
  set_savefile_path("$(IOCDATA)/autosave/$(IOC_ALIAS)")
  set_requestfile_path(".")
  set_requestfile_path("$(TOP)/req")

  set_pass0_restoreFile("info_positions.sav")
  set_pass0_restoreFile("info_settings.sav")

  set_pass1_restoreFile("info_settings.sav")
  ## set_pass1_restoreFile("anova_settings.sav")
  ## set_pass1_restoreFile("presto_settings.sav")
