/*
 * Copyright (c) 2012 Nerses Gevorgyan <nerses@jlab.org> 2012
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 *
 * HVCAENx527chsubArray.c:
 * subArray record device support routines.
 */

#include <stdlib.h>
#include "HVCAENx527.h"

#include <waveformRecord.h>
#include <subArrayRecord.h>

/*
 * devCAENx527subArray
 */

static long init_record_subArray( subArrayRecord *pior) {

	/* parse device dependent option string and set data pointer */
	struct dbAddr *pWfDbAddr;
	waveformRecord *pwf;

	dbNameToAddr(pior->inp.value.constantStr, pWfDbAddr);
	pwf = (waveformRecord*) pWfDbAddr->precord;
	if( pwf == 0 ) {
	    printf(__FILE__":%d: Error Can't find %s \n", __LINE__, pior->inp.value.constantStr);
	    exit(1);
	  }

	pior->dpvt = (void*) pwf;

	return(0);
}

static long read_subArray( subArrayRecord *pior) {

	waveformRecord *pwf;

	pwf = (waveformRecord*) pior->dpvt;

	uint size;
	switch (pior->ftvl) {
		case DBF_STRING:
			size = MAX_STRING_SIZE;
			break;
		case DBF_CHAR:
		case DBF_UCHAR:
			size = sizeof(char);
			break;
		case DBF_SHORT:
		case DBF_USHORT:
			size = sizeof(short);
			break;
		case DBF_LONG:
		case DBF_ULONG:
			size = sizeof(long);
			break;
		case DBF_FLOAT:
			size = sizeof(float);
			break;
		case DBF_DOUBLE:
			size = sizeof(double);
			break;
		case DBF_ENUM:
			size = sizeof(epicsEnum16);
			break;
		default:
			size = 0;
			break;
	}
	/* clean buffer size */
	if (pior->bptr) free(pior->bptr);
	pior->bptr = malloc(size * pior->nelm);

	memcpy(pior->bptr, pwf->val, size * pior->nelm);
	pior->nord = pior->nelm;

	pior->udf = FALSE;
	PDEBUG(2) printf( "DEBUG:%s: get name = %s ...\n", __FILE__, pior->val);

	return(0);
}

struct { /* subArray dset */
        long            number;
        DEVSUPFUN       dev_report;
        DEVSUPFUN       init;
        DEVSUPFUN       init_record; /*returns: (-1,0)=>(failure,success)*/
        DEVSUPFUN       get_ioint_info;
        DEVSUPFUN       read_sa; /*returns: (-1,0)=>(failure,success)*/
} devsubArray =
	{
		5,
		NULL,
		NULL,
		init_record_subArray,
		NULL,
		read_subArray,
	};

#include <epicsExport.h>
epicsExportAddress(dset,devsubArray);

/*
 * $Log: HVCAENx527/HVCAENx527App/src/HVCAENx527chStringio.c  $
 * Revision 1.8 2007/06/01 13:32:58CST Ru Igarashi (igarasr) 
 * Member moved from EPICS/HVCAENx527App/src/HVCAENx527chStringio.c in project e:/MKS_Home/archive/cs/epics_local/drivers/CAENx527HV/project.pj to HVCAENx527/HVCAENx527App/src/HVCAENx527chStringio.c in project e:/MKS_Home/archive/cs/epics_local/drivers/CAENx527HV/project.pj.
 */
