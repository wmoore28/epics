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
 * HVCAENx527Stringio.c:
 * Stringin record device support routines for mainframe/crate parameters.
 *
 * Based on the devSiSoft.c,v 1.10.2.2 2009/04/03 17:46:22 lange Exp
 *      By: Janet Anderson
 *      Date: 04-21-91
 */

#include "HVCAENx527.h"

/*#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "alarm.h"
#include "dbDefs.h"
#include "dbAccess.h"
#include "epicsTime.h"
#include "recGbl.h"
#include "devSup.h"
#include "link.h"*/
#include "stringinRecord.h"
#include "epicsExport.h"*

/* Create the dset for devSiSoft */
static long init_record_crate_stringin(stringinRecord *prec);
static long read_crate_stringin(stringinRecord *prec);

struct {
    long      number;
    DEVSUPFUN report;
    DEVSUPFUN init;
    DEVSUPFUN init_record;
    DEVSUPFUN get_ioint_info;
    DEVSUPFUN read_stringin;
} devCAENx527Stringin = {
    5,
    NULL,
    NULL,
    init_record_crate_stringin,
    NULL,
    read_crate_stringin
};
epicsExportAddress(dset, devCAENx527Stringin);

static long init_record_crate_stringin(stringinRecord *prec){

	struct instio *pinstio;
	char mf[64];
	int slot;

    /* INP must be INST_IO */
    if (prec->inp.type != INST_IO) {
        recGblRecordError(S_db_badField, (void *)prec, "devCAENx527Stringin (init_record_crate_stringin) Illegal INP field");
        return S_db_badField;
    }

    return 0;
}

static long read_crate_stringin(stringinRecord *prec)
{
    /*long status;

    status = dbGetLink(&prec->inp, DBR_STRING, prec->val, 0, 0);
    if (!status) {
        if (prec->inp.type != CONSTANT)
            prec->udf = FALSE;
        if (prec->tsel.type == CONSTANT &&
            prec->tse == epicsTimeEventDeviceTime)
            dbGetTimeStamp(&prec->inp, &prec->time);
    }*/

    struct instio *pinstio;
	char mf[64];
	int slot;

	/* parse device dependent option string and set data pointer */
	pinstio = &(prec->inp.value.instio);
	sscanf(pinstio->string, "%s %d", mf, &slot);
	if( mf[0] == '\0' || slot<-1 || slot>MAX_SLOTS ) {
		printf( "%s: Invalid device parameters: \"%s\"\n", prec->name, pinstio->string);
		return(-1);
	}

	int i;
	/*for(i=0; i < MAX_CRATES; i++)
		printf("i = %d name = %s pinstio->string = %s mf = %s slot = %d\n",i, Crate[i].name, pinstio->string, mf, slot);*/
	i = 0;
	while( i < MAX_CRATES  &&  strcmp(Crate[i].name, mf) != 0) i++;

	if (i>=MAX_CRATES) {
		printf( "%s: Create not found: \"%s\"\n", prec->name, pinstio->string);
		return(-1);
	}
	if(slot == -1) {
		snprintf(prec->val, sizeof(prec->val),"%s", Crate[i].IPaddr);
	} else if (slot>=0) {
		if (Crate[i].hvchmap[slot].nchan) {
			snprintf(prec->val, sizeof(prec->val),"%s", Crate[i].hvchmap[slot].slname);
		} else {
			snprintf(prec->val, sizeof(prec->val),"N/A");
		}
	}
	return 0;
}
