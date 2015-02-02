/*
 * Copyright Canadian Light Source, Inc.  All rights reserved.
 *    - see licence.txt and licence_CAEN.txt for limitations on use.
 */
/*
 * HVCAENx527chAio.c:
 * Analog input record and analog output record device support routines.
 */
#include "HVCAENx527.h"

#include <dbScan.h>
#include <aiRecord.h>
#include <aoRecord.h>

/*
 * devCAENx527chAi
 */

static long
init_record_ai( aiRecord *pior)
{
	struct instio *pinstio;
	PARPROP *pp = NULL;

	if( pior->inp.type != INST_IO)
	{
		printf( "%s: ai INP field type should be INST_IO\n", pior->name);
		return( S_db_badField);
	}

	/* parse device dependent option string and set data pointer */
	pinstio = &(pior->inp.value.instio);
	if( ( pp = CAENx527ParseDevArgs( pinstio->string)) == NULL)
	{
		printf( "%s: Invalid device parameters: \"%s\"\n", pior->name, pinstio->string);
		return(2);
	}

	if( pp->evntno > 0)
		pior->evnt = pp->evntno;

	pior->dpvt = pp;
	strcpy( pp->PVname, pior->name);
	if( pp->Unit)
	{
		(void)CAENx527GetParUnit( pp, pior->egu);
	}

	pp->hvchan->epicsenabled = 1;
PDEBUG(10) printf( "DEBUG: set %s EVNT: %d\n", pp->pname, pior->evnt);

	return( 0);
}

static long
read_ai( aiRecord *pior)
{
#if SCAN_SERVER == 0
	void *pval;
#endif
	PARPROP *pp = NULL;

	pp = (PARPROP *)pior->dpvt;
	if( pp == NULL || pp->hvchan->epicsenabled == 0 || pp->hvchan->hvcrate->connected == 0)
		return( 3);

#if SCAN_SERVER == 0
	pval = CAENx527GetChParVal( pp);
	if( pval == NULL)
		return( 3);
#endif

	pior->val = (double)(pp->pval.f);
	pior->udf = FALSE;
PDEBUG(10) printf( "DEBUG: get %s = %lf\n", pp->pname, pior->val);

	return( 2);
}

struct
{
	long number;
	DEVSUPFUN	report;
	DEVSUPFUN	init;
	DEVSUPFUN	init_record;
	DEVSUPFUN	get_ioint_info;
	DEVSUPFUN	read_ai;
	DEVSUPFUN	special_linconv;
} devCAENx527chAi =
	{
		6,
		NULL,
		NULL,
		init_record_ai,
		NULL,
		read_ai,
		NULL
	};

/*
 * devCAENx527chAo
 */

static long
init_record_ao( aoRecord *pior)
{
	struct instio *pinstio;
	PARPROP *pp = NULL;
	void *pval;

	if( pior->out.type != INST_IO)
	{
		printf( "%s: ao OUT field type should be INST_IO\n", pior->name);
		return( S_db_badField);
	}

	/* parse device dependent option string and set data pointer */
	pinstio = &(pior->out.value.instio);
	if( ( pp = CAENx527ParseDevArgs( pinstio->string)) == NULL)
	{
		printf( "%s: Invalid device parameters: \"%s\"\n", pior->name, pinstio->string);
		return( S_db_badField);
	}

	pior->dpvt = pp;
	strcpy( pp->PVname, pior->name);

	/* Initialize the value from value in the crate */
	pval = CAENx527GetChParVal( pp);
	if( pval == NULL)
		return( 3);
	pior->val = (double)(pp->pval.f);
	pior->rval = (double)(pp->pval.f);
	if( pp->Unit)
	{
		(void)CAENx527GetParUnit( pp, pior->egu);
	}

	pp->hvchan->epicsenabled = 1;

	return( 0);
}

static long
write_ao( aoRecord *pior)
{
	PARPROP *pp;

	pp = (PARPROP *)(pior->dpvt);
	if( pp == NULL || pp->hvchan->epicsenabled == 0)
		return(3);
	if( pior->val < pp->Minval)
	{
		pp->pvalset.f = pp->Minval;
	}
	else if( pp->Maxval < pior->val)
	{
		pp->pvalset.f = pp->Maxval;
	}
	else
		pp->pvalset.f = (float)(pior->val);
PDEBUG(10) printf( "DEBUG: put %s = %lf (%f)\n", pp->pname, pior->val, pp->pvalset.f);
	if( CAENx527SetChParVal( pp) != 0)
		return( 3);

	pior->udf = FALSE;

	return( 0);
}

struct
{
	long number;
	DEVSUPFUN	report;
	DEVSUPFUN	init;
	DEVSUPFUN	init_record;
	DEVSUPFUN	get_ioint_info;
	DEVSUPFUN	write_ao;
	DEVSUPFUN	special_linconv;
} devCAENx527chAo =
	{
		6,
		NULL,
		NULL,
		init_record_ao,
		NULL,
		write_ao,
		NULL
	};
#include <epicsExport.h>
epicsExportAddress(dset,devCAENx527chAi);
epicsExportAddress(dset,devCAENx527chAo);
