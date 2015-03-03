/* $Header: HVCAENx527/HVCAENx527App/src/HVCAENx527chMBBio.c 1.14 2007/06/01 13:32:58CST Ru Igarashi (igarasr) Exp Ru Igarashi (igarasr)(2007/06/01 13:32:58CST) $ 
 *
 * Copyright Canadian Light Source, Inc.  All rights reserved.
 *    - see licence.txt and licence_CAEN.txt for limitations on use.
 */
/*
 * HVCAENx527chMBBio.c:
 * MultiBit Binary input record and output record device support routines.
 */
#include "HVCAENx527.h"

#include <mbbiRecord.h>

/*
 * devCAENx527chMBBi
 */

void setMbbiField (char* field, unsigned int id) {
	size_t n;
	mbbiRecord dummy;
	n = sizeof(dummy.zrst);
	if (id < MAX_CRATES) {
		if (Crate[id].connected == 1) {
			strncpy(field, Crate[id].name, n);
		}
	} else {
		errlogPrintf("Possible Create IDes are: 0 - %d, got %d\n", MAX_CRATES-1, id);
	}
	return;
}

static long
init_record_mbbi_mf( mbbiRecord *pior)
{
	char *str;

/*	if( pior->inp.type != CONSTANT)
	{
		errlogPrintf( "%s(%d): mbbi INP field type should be CONSTANT(0)\n", pior->name, pior->inp.type);
		return( S_db_badField);
	}*/

	/* parse device dependent option string and set data pointer */
	str = pior->inp.value.constantStr;
	if (strcmp(str,"crateList") != 0) {
		errlogPrintf( "ERROR: Unsupported INP field %s for PV %s . Should be crates instead.", str, pior->name);
		return(-1);
	}

	setMbbiField( pior->zrst,  0 );
	setMbbiField( pior->onst,  1 );
	setMbbiField( pior->twst,  2 );
	setMbbiField( pior->thst,  3 );
	setMbbiField( pior->frst,  4 );
	setMbbiField( pior->fvst,  5 );
	setMbbiField( pior->sxst,  6 );
	setMbbiField( pior->svst,  7 );
	setMbbiField( pior->eist,  8 );
	setMbbiField( pior->nist,  9 );
	setMbbiField( pior->test, 10 );
	setMbbiField( pior->elst, 11 );
	setMbbiField( pior->tvst, 12 );
	setMbbiField( pior->ttst, 13 );
	setMbbiField( pior->ftst, 14 );
	setMbbiField( pior->ffst, 15 );

	return( 0);
}

static long
read_mbbi_mf( mbbiRecord *pior)
{
	/*pior->val = 0;*/
	pior->udf = FALSE;
/*PDEBUG(10) printf( "DEBUG: get %s = %o %hd\n", pp->pname, (short)(pp->pval.l), pior->val);*/

	return(0);
}

struct
{
        long number;
        DEVSUPFUN       report;
        DEVSUPFUN       init;
        DEVSUPFUN       init_record;
        DEVSUPFUN       get_ioint_info;
        DEVSUPFUN       read_mbbi;
} devCAENx527MBBi =
        {
                5,
                NULL,
                NULL,
                init_record_mbbi_mf,
                NULL,
                read_mbbi_mf
        };


#include <epicsExport.h>
epicsExportAddress(dset,devCAENx527MBBi);

/*
 *  $Log: HVCAENx527/HVCAENx527App/src/HVCAENx527chMBBio.c  $
 *  Revision 1.14 2007/06/01 13:32:58CST Ru Igarashi (igarasr) 
 *  Member moved from EPICS/HVCAENx527App/src/HVCAENx527chMBBio.c in project e:/MKS_Home/archive/cs/epics_local/drivers/CAENx527HV/project.pj to HVCAENx527/HVCAENx527App/src/HVCAENx527chMBBio.c in project e:/MKS_Home/archive/cs/epics_local/drivers/CAENx527HV/project.pj.
 */
