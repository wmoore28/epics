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
 * HVCAENx527chWaveform.c:
 * Waveform record device support routines.
 */

#include "HVCAENx527.h"

#include <waveformRecord.h>

/*
 * devCAENx527Waveform
 */

static long
init_record_waveform( waveformRecord *pior)
{
	int i;
	char mf[64];
	char arg[64];
	unsigned char *test;
	struct instio *pinstio;

	if( pior->inp.type != INST_IO)
	{
		printf( "%s: waveform INP field type should be INST_IO\n", pior->name);
		return( S_db_badField);
	}

	/* parse device dependent option string and set data pointer */
	pinstio = &(pior->inp.value.instio);
	sscanf(pinstio->string, "%s %s", mf, arg);
	if( mf[0] == '\0' || arg[0] == '\0' )
	{
		printf( "%s: Invalid device parameters: \"%s\"\n", pior->name, pinstio->string);
		return(-1);
	}

	for(i=0; i < MAX_CRATES; i++)
		printf("i = %d name = %s pinstio->string = %s mf = %s arg = %s\n",i, Crate[i].name, pinstio->string, mf, arg);
	i = 0;
	while( i < MAX_CRATES  &&  strcmp(Crate[i].name, mf) != 0) i++;

	if (i>=MAX_CRATES) {
		printf( "%s: Create not found: \"%s\"\n", pior->name, pinstio->string);
		return(-1);
	}

	pior->dpvt = (void*) &Crate[i];
	pior->bptr = (void*) malloc(MAX_STRING_SIZE * MAX_SLOTS);
	printf("crate = %x dpvt = %x\n", &Crate[i], pior->dpvt);

	return(0);
}

static long
read_waveform( waveformRecord *pior)
{
#if SCAN_SERVER == 0
	void *pval;
#endif
	HVCRATE *cr;
	HVSLOT *sl;
	int i;
	int size;

	cr = (HVCRATE*) pior->dpvt;
	pior->nelm = (cr->nsl<MAX_SLOTS)? cr->nsl:MAX_SLOTS;
	/*size = 64; /* sizeof(Crate.name); */
	/*names = calloc(pior->nelm, size); /* nelm * 64 bytes each */

	for (i=0; i<pior->nelm; i++) {
		sl = &cr->hvchmap[i];
		PDEBUG(2) printf("%d %s\n", i, sl->slname);
		strncpy((pior->bptr+i*MAX_STRING_SIZE), (char*)sl->slname, MAX_STRING_SIZE);
	}
	pior->nord = pior->nelm;

	pior->udf = FALSE;
	PDEBUG(2) printf( "DEBUG: get name = %s ...\n", pior->val);

	return(0);
}

struct { /* waveform dset */
	long            number;
	DEVSUPFUN       dev_report;
	DEVSUPFUN       init;
	DEVSUPFUN       init_record; /*returns: (-1,0)=>(failure,success)*/
	DEVSUPFUN       get_ioint_info;
	DEVSUPFUN       read_wf; /*returns: (-1,0)=>(failure,success)*/
} devCAENx527Waveform =
	{
		5,
		NULL,
		NULL,
		init_record_waveform,
		NULL,
		read_waveform,
	};

#include <epicsExport.h>
epicsExportAddress(dset,devCAENx527Waveform);

/*
 * $Log: HVCAENx527/HVCAENx527App/src/HVCAENx527chStringio.c  $
 * Revision 1.8 2007/06/01 13:32:58CST Ru Igarashi (igarasr) 
 * Member moved from EPICS/HVCAENx527App/src/HVCAENx527chStringio.c in project e:/MKS_Home/archive/cs/epics_local/drivers/CAENx527HV/project.pj to HVCAENx527/HVCAENx527App/src/HVCAENx527chStringio.c in project e:/MKS_Home/archive/cs/epics_local/drivers/CAENx527HV/project.pj.
 */
