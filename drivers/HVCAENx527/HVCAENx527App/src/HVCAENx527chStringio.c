/* $Header: HVCAENx527/HVCAENx527App/src/HVCAENx527chStringio.c 1.8 2007/06/01 13:32:58CST Ru Igarashi (igarasr) Exp Ru Igarashi (igarasr)(2007/06/01 13:32:58CST) $
 *
 * Copyright Canadian Light Source, Inc.  All rights reserved.
 *    - see licence.txt and licence_CAEN.txt for limitations on use.
 *
 *
 * HVCAENx527chStringio.c:
 * String input record and output record device support routines.
 */

#include "HVCAENx527.h"

#include <stringinRecord.h>
#include <stringoutRecord.h>

/*
 * devCAENx527chStringin
 */

static long
init_record_stringin( stringinRecord *pior)
{
	char str[256];
	struct instio *pinstio;
	HVCHAN *hvch = NULL;

	if( pior->inp.type != INST_IO)
	{
		printf( "%s: stringin INP field type should be INST_IO\n", pior->name);
		return( S_db_badField);
	}

	/* parse device dependent option string and set data pointer */
	pinstio = &(pior->inp.value.instio);
	if( ( hvch = CAENx527ParseDevArgs( pinstio->string)) == NULL)
	{
		printf( "%s: Invalid device parameters: \"%s\"\n", pior->name, pinstio->string);
		return(2);
	}

	if( (hvch->chname_evntno > 0) && ( sscanf( pinstio->string, "%*s %s", str) == 1) && ( strncmp( str, "ChName", 255) == 0))
		pior->evnt = hvch->chname_evntno;

	pior->dpvt = hvch;
	hvch->epicsenabled = 1;

	return( 0);
}

static long
read_stringin( stringinRecord *pior)
{
#if SCAN_SERVER == 0
	void *pval;
#endif
	HVCHAN *hvch = NULL;

	hvch = (HVCHAN *)pior->dpvt;
	if( hvch == NULL || hvch->epicsenabled == 0 || hvch->hvcrate->connected == 0)
		return( 3);

#if SCAN_SERVER == 0
	pval = CAENx527GetChName( hvch);
	if( pval == NULL)
		return( 3);
#endif

	strcpy( pior->val, hvch->chname);
	pior->udf = FALSE;
PDEBUG(10) printf( "DEBUG: get name = %s\n", pior->val);

	return( 2);
}

struct
{
	long number;
	DEVSUPFUN	report;
	DEVSUPFUN	init;
	DEVSUPFUN	init_record;
	DEVSUPFUN	get_ioint_info;
	DEVSUPFUN	read_stringin;
	DEVSUPFUN	special_linconv;
} devCAENx527chStringin =
	{
		6,
		NULL,
		NULL,
		init_record_stringin,
		NULL,
		read_stringin,
		NULL
	};

/*
 * devCAENx527chStringout
 */

static long
init_record_stringout( stringoutRecord *pior)
{
	struct instio *pinstio;
	HVCHAN *hvch = NULL;
	void *pval;

	if( pior->out.type != INST_IO)
	{
		printf( "%s: stringout OUT field type should be INST_IO\n", pior->name);
		return( S_db_badField);
	}

	/* parse device dependent option string and set data pointer */
	pinstio = &(pior->out.value.instio);
	if( ( hvch = CAENx527ParseDevArgs( pinstio->string)) == NULL)
	{
		printf( "%s: Invalid device parameters: \"%s\"\n", pior->name, pinstio->string);
		return( S_db_badField);
	}

	pior->dpvt = hvch;

	/* Initialize the value from value in the crate */
	pval = CAENx527GetChName( hvch);
	if( pval == NULL)
		return( 3);
	strcpy( pior->val, hvch->chname);
PDEBUG(3) printf( "DEBUG: init stringin %s -> %s\n", pinstio->string, hvch->chname);

	hvch->epicsenabled = 1;

	return( 0);
}

static long
write_stringout( stringoutRecord *pior)
{
	HVCHAN *hvch;

	hvch = (HVCHAN *)(pior->dpvt);
	if( hvch == NULL || hvch->epicsenabled == 0)
		return(3);
	snprintf( hvch->chname, 12, "%s", pior->val);
PDEBUG(10) printf( "DEBUG: put name = %s\n", pior->val);
	if( CAENx527SetChName( hvch, pior->val) != 0)
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
	DEVSUPFUN	write_stringout;
	DEVSUPFUN	special_linconv;
} devCAENx527chStringout =
	{
		6,
		NULL,
		NULL,
		init_record_stringout,
		NULL,
		write_stringout,
		NULL
	};
#include <epicsExport.h>
epicsExportAddress(dset,devCAENx527chStringin);
epicsExportAddress(dset,devCAENx527chStringout);

/*
 * $Log: HVCAENx527/HVCAENx527App/src/HVCAENx527chStringio.c  $
 * Revision 1.8 2007/06/01 13:32:58CST Ru Igarashi (igarasr) 
 * Member moved from EPICS/HVCAENx527App/src/HVCAENx527chStringio.c in project e:/MKS_Home/archive/cs/epics_local/drivers/CAENx527HV/project.pj to HVCAENx527/HVCAENx527App/src/HVCAENx527chStringio.c in project e:/MKS_Home/archive/cs/epics_local/drivers/CAENx527HV/project.pj.
 */
