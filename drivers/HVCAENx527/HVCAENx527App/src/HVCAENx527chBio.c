/* $Header: HVCAENx527/HVCAENx527App/src/HVCAENx527chBio.c 1.14 2007/06/01 13:32:58CST Ru Igarashi (igarasr) Exp Ru Igarashi (igarasr)(2007/06/01 13:32:58CST) $
 *
 * Copyright Canadian Light Source, Inc.  All rights reserved.
 *    - see licence.txt and licence_CAEN.txt for limitations on use.
 */
/*
 * HVCAENx527chBio.c:
 * Binary input record and binary output record device support routines.
 */
#include "HVCAENx527.h"

#include <biRecord.h>
#include <boRecord.h>

/*
 * devCAENx527chBi
 */

static long
init_record_bi( biRecord *pior)
{
	struct instio *pinstio;
	PARPROP *pp = NULL;

	if( pior->inp.type != INST_IO)
	{
		errlogPrintf( "%s: bi INP field type should be INST_IO\n", pior->name);
		return( S_db_badField);
	}

	/* parse device dependent option string and set data pointer */
	pinstio = &(pior->inp.value.instio);
	if( ( pp = CAENx527ParseDevArgs( pinstio->string)) == NULL)
	{
		errlogPrintf( "%s: Invalid device parameters: \"%s\"\n", pior->name, pinstio->string);
		return(2);
	}

	if( pp->evntno > 0)
		pior->evnt = pp->evntno;

	pior->dpvt = pp;
	strcpy( pp->PVname, pior->name);
	pp->hvchan->epicsenabled = 1;

	return( 0);
}

static long
read_bi( biRecord *pior)
{
#if SCAN_SERVER == 0
	void *pval;
#endif
	PARPROP *pp;

	pp = (PARPROP *)pior->dpvt;
	if( pp == NULL || pp->hvchan->epicsenabled == 0 || pp->hvchan->hvcrate->connected == 0)
		return( 3);

#if SCAN_SERVER == 0
	pval = CAENx527GetChParVal( pp);
	if( pval == NULL)
		return( 3);
#endif

	pior->val = (short)(pp->pval.l);
	pior->udf = FALSE;
PDEBUG(10) printf( "DEBUG: get %s = %hd\n", pp->pname, pior->val);

	return( 2);
}

struct
{
        long number;
        DEVSUPFUN       report;
        DEVSUPFUN       init;
        DEVSUPFUN       init_record;
        DEVSUPFUN       get_ioint_info;
        DEVSUPFUN       read_bi;
} devCAENx527chBi = 
        {
                5,
                NULL,
                NULL,
                init_record_bi,
                NULL,
                read_bi
        };

/*
 * devCAENx527chBi
 */

static long
init_record_bo( boRecord *pior)
{
	struct instio *pinstio;
	PARPROP *pp = NULL;
	void *pval;

	if( pior->out.type != INST_IO)
	{
		errlogPrintf( "%s: bi INP field type should be INST_IO\n", pior->name);
		return( S_db_badField);
	}

	/* parse device dependent option string and set data pointer */
	pinstio = &(pior->out.value.instio);
	if( ( pp = CAENx527ParseDevArgs( pinstio->string)) == NULL)
	{
		errlogPrintf( "%s: Invalid device parameters: \"%s\"\n", pior->name, pinstio->string);
		return(2);
	}

	pior->dpvt = pp;
	strcpy( pp->PVname, pior->name);

	/* Initialize the value from value in the crate */
	pval = CAENx527GetChParVal( pp);
	if( pval == NULL)
		return( 3);
	pior->val = (short)(pp->pval.l);
	pior->rval = (short)(pp->pval.l);

	pp->hvchan->epicsenabled = 1;

	return( 0);
}

static long
write_bo( boRecord *pior)
{
	PARPROP *pp;

	pp = (PARPROP *)(pior->dpvt);
	if( pp == NULL || pp->hvchan->epicsenabled == 0)
		return(3);
	pp->pvalset.l = (long)(pior->val);
PDEBUG(10) printf( "DEBUG: put %s = %d\n", pp->pname, pior->val);
	if( CAENx527SetChParVal( pp) != 0)
		return( 3);

	pior->udf = FALSE;

	return( 0);
}

struct
{
        long number;
        DEVSUPFUN       report;
        DEVSUPFUN       init;
        DEVSUPFUN       init_record;
        DEVSUPFUN       get_ioint_info;
        DEVSUPFUN       write_bo;
} devCAENx527chBo =
        {
                5,
                NULL,
                NULL,
                init_record_bo,
                NULL,
                write_bo
        };
#include <epicsExport.h>
epicsExportAddress(dset,devCAENx527chBi);
epicsExportAddress(dset,devCAENx527chBo);

/*
 * $Log: HVCAENx527/HVCAENx527App/src/HVCAENx527chBio.c  $
 * Revision 1.14 2007/06/01 13:32:58CST Ru Igarashi (igarasr) 
 * Member moved from EPICS/HVCAENx527App/src/HVCAENx527chBio.c in project e:/MKS_Home/archive/cs/epics_local/drivers/CAENx527HV/project.pj to HVCAENx527/HVCAENx527App/src/HVCAENx527chBio.c in project e:/MKS_Home/archive/cs/epics_local/drivers/CAENx527HV/project.pj.
 */

