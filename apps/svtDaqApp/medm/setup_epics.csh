setenv EPICS_HOST_ARCH linux-x86
setenv EPICS_BASE /u1/epics/base-3.14.12.2
setenv MEDM_BASE /u1/epics/extensions
setenv PATH ${EPICS_BASE}/bin/${EPICS_HOST_ARCH}:${MEDM_BASE}/bin/${EPICS_HOST_ARCH}:$PATH
