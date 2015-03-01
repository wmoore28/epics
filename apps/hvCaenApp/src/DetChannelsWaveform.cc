/*
 * DetChannelsWaveform.cc
 * Waveform record device support routine.
 *
 *  Created on: Aug 8, 2013
 *      Author: Nerses Gevorgyan
 *
 * Copyright (c) 2013 Nerses Gevorgyan <nerses@jlab.org> 2013
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
 */

/*************************************************************************\
* Copyright (c) 2008 UChicago Argonne LLC, as Operator of Argonne
*     National Laboratory.
* Copyright (c) 2002 The Regents of the University of California, as
*     Operator of Los Alamos National Laboratory.
* EPICS BASE is distributed subject to a Software License Agreement found
* in file LICENSE that is included with this distribution.
\*************************************************************************/

/* Revision-Id: anj@aps.anl.gov-20101005192737-disfz3vs0f3fiixd
 *
 *      Original Authors: Bob Dalesio and Marty Kraimer
 *      Date: 6-1-90
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <iostream>
#include <sstream>
#include <string>
using namespace std;

#include "alarm.h"
#include "dbDefs.h"
#include "dbAccess.h"
#include "recGbl.h"
#include "devSup.h"
#include "waveformRecord.h"
#include "epicsExport.h"

#include "detector.hh"

typedef struct {
	epicsUInt32   nelm;
	struct dbAddr *paddr;
	struct dbAddr *paddr_x;
	int isFirstTime;
} waveformDetElements;

/* Create the dset for devWfSoft */
static long init_record_waveform_det(waveformRecord *prec);
static long read_waveform_det(waveformRecord *prec);

struct DEVDETWAVEFORM {
    long      number;
    DEVSUPFUN report;
    DEVSUPFUN init;
    DEVSUPFUN init_record;
    DEVSUPFUN get_ioint_info;
    DEVSUPFUN read_wf;
} devDetWaveform = {
    5,
    NULL,
    NULL,
	(long (*)(void*))init_record_waveform_det,
	NULL,
	(long (*)(void*))read_waveform_det
};
epicsExportAddress(dset, devDetWaveform);

static long init_record_waveform_det( waveformRecord *prec)
{
	unsigned int k;
	static waveformDetElements *dpvt;

	char det[64];
	char prefix1[64];
	char prefix2[64];
	char suffix[64];
	char channel[64];
	struct instio *pinstio;

	if( prec->inp.type != INST_IO)
	{
		printf( "%s: waveform INP field type should be INST_IO\n", prec->name);
		return( S_db_badField);
	}

	/* parse device dependent option string and set data pointer */
	pinstio = &(prec->inp.value.instio);

//	char* p2 = pinstio->string;
//	char* p1;
//	                 p1 =   p2; while(*p2!='\0' || *p2!=' ') p2++; strncpy(det,     p1, sizeof(p2) - sizeof(p1) - 1);
//	if (*p2!='\0') { p1 = ++p2; while(*p2!='\0' || *p2!=' ') p2++; strncpy(suffix,  p1, sizeof(p2) - sizeof(p1) - 1); }
//	if (*p2!='\0') { p1 = ++p2; while(*p2!='\0' || *p2!=' ') p2++; strncpy(prefix1, p1, sizeof(p2) - sizeof(p1) - 1); }
//	strcpy(suffix,  strtok(NULL, " "));
//	strcpy(prefix1, strtok(NULL, " "));
	sscanf(pinstio->string, "%s %s %s", det, suffix, prefix1);
//	if( det[0] == '\0' || prefix1[0] == '\0' || suffix[0] == '\0' )
	if( det[0] == '\0' || suffix[0] == '\0' )
	{
		printf( "%s: Invalid device parameters: \"%s\"\n", prec->name, pinstio->string);
		return(-1);
	}
	/*
	 * The prefix1 is the one we are getting via dbLoadRecords for WF.
	 * The prefix was got via detUsePrefix.
	 * The prefix2 is the prefix1 without prefix and that could be matched to the items from DB query.
	 * prefix1 is like xyzhv
	 * prefix  is like xyz
	 * prefix2 will be like hv
	 */
	strcpy(prefix2, (const char*)(prefix1+prefix.size()));
	printf( "%s: waveform has a prefix %s\n", prec->name, prefix.c_str());
	printf(__FILE__":%s:%d: prefix1 = %s, prefix = %s, prefix2 = %s\n", __FUNCTION__, __LINE__, prefix1, prefix.c_str(), prefix2);
	dpvt = (waveformDetElements*) malloc(sizeof(waveformDetElements));
	dpvt->nelm = prec->nelm;
	dpvt->paddr   = (struct dbAddr *) malloc( 2*prec->nelm*sizeof(struct dbAddr) ); // make it x2 to make room for enable pointers too
	dpvt->paddr_x = (struct dbAddr *) malloc(              sizeof(struct dbAddr) ); // make room for corresponding X PV
	map<int, map<string, string> > channels = db->getChannels();
	cout<<"channels.size() = "<<channels.size()<<endl;
	k=0;
	for (map<int, map<string, string> >::iterator it = channels.begin(); it != channels.end() && k<2*prec->nelm; ++it) {
		map<string, string> items = it->second;
		for (map<string, string>::iterator items_it = items.begin(); items_it != items.end() && k<2*prec->nelm; ++items_it) {
			if (	items_it->first.compare(0, 5, "DETch") == 0) {// &&
//				if (items_it->second.compare(0, strlen(prefix2), prefix2) == 0) {// &&
//					if (items_it->second.compare(strlen(prefix2), strlen(det), det) == 0 ) {
				//				if (items_it->second.compare(0, prefix.size(), prefix) == 0) {// &&
				if (items_it->second.compare(0, strlen(det), det) == 0 ) {
					printf(__FILE__":%s:%d: i=%d prefix = %s, det = %s, first = %s second = %s\n",
							__FUNCTION__, __LINE__, it->first, prefix.c_str(), det, items_it->first.c_str(), items_it->second.c_str());
					//						printf("\nprefix = %s, prefix1 = %s, it->second = %s, suffix = %s \n", prefix.c_str(), prefix1, items_it->second.c_str(), suffix);
					sprintf(channel, "%s%s:%s", prefix.c_str(), items_it->second.c_str(), suffix);
					dbNameToAddr(channel, &dpvt->paddr[k]);
					k++;
					sprintf(channel, "%s%s:%s", prefix.c_str(), items_it->second.c_str(), "enable");
					dbNameToAddr(channel, &dpvt->paddr[k]);
					//printf(__FILE__":%s:%d: channel name to connect from WF = %s, %d, 0x%x record name = %s\n",
					       //					       __FUNCTION__, __LINE__, channel, strlen(channel), reinterpret_cast<unsigned int>(&dpvt->paddr[k]), dpvt->paddr[k].precord->name);
					printf(__FILE__":%s:%d: channel name to connect from WF = %s, %d, %p record name = %s\n",
					       __FUNCTION__, __LINE__, channel, strlen(channel), &dpvt->paddr[k], dpvt->paddr[k].precord->name);
					k++;
				}
				//				}
			}
		}
	}

	/* Initialize the corresponding x record */
	strcpy(channel, prec->name);
	channel[strlen(channel)-1] = 'x'; // change the last letter from 'y' to 'x'
	printf("coupled x channel name = %s\n", channel);
	dbNameToAddr(channel, dpvt->paddr_x);
	dpvt->isFirstTime = 1;

	prec->dpvt = (void*) dpvt;
	prec->bptr = (void*) malloc(prec->nelm*sizeof(float));
	printf("nelm = %d dpvt = %lx\n", prec->nelm, (unsigned long)prec->dpvt);

	prec->udf = FALSE;
	if (k==0) prec->pact = TRUE;
	return(0);
}

static long read_waveform_det( waveformRecord *prec)
{

	unsigned int i,k;
	int status;
	float *data;
	epicsEnum16 enable[1];
	long option = 0;
	long nRequest;
	void *pfl = NULL;

	static unsigned int MAX_NELM;

	waveformDetElements *dpvt;
	struct dbAddr *paddr;
	dpvt = (waveformDetElements*)prec->dpvt;
	paddr = dpvt->paddr;
	MAX_NELM = dpvt->nelm;

	/* Init of corresponding X PV */
	if (dpvt->isFirstTime) {
		dpvt->isFirstTime = 0;
		data = (float*)malloc(sizeof(float)*MAX_NELM);
		for (unsigned int i = 0; i < MAX_NELM; i++) {
			data[i] = i+1;
		}
		nRequest =  MAX_NELM;
		if ( dbPutField(dpvt->paddr_x, DBR_FLOAT, data, nRequest) ) {
		  //			printf("Error in %s: Can't put data from 0x%x \n", __FUNCTION__, (unsigned int)dpvt->paddr_x );
			printf("Error in %s: Can't put data from %p \n", __FUNCTION__, dpvt->paddr_x );
		}
	}

	data = (float*) prec->bptr;
//	printf("sizeof(data) = %d sizeof(prec->bptr) = %d\n",sizeof(data),sizeof(prec->bptr));
	nRequest = 1;
	status = 0;
	k = 0;
	for (i=0; i<MAX_NELM; i++) {
		if (&paddr[2*i] != 0) {
//			printf("i = %2d k = %2d enable = %d name = %s\n", i, k, enable[0], paddr[2*i+1].precord->name);
			status |= dbGetField(&paddr[2*i+1], DBR_ENUM, enable, &option, &nRequest, pfl);
//			printf("i = %2d k = %2d enable = %d name = %s\n", i, k, enable[0], paddr[2*i+1].precord->name);
			if (enable[0]==1) {
				status |= dbGetField(&paddr[2*i], DBR_FLOAT, &data[k], &option, &nRequest, pfl);
//				printf("i = %2d k = %2d enable = %d name = %s data = %f\n", i, k, enable[0], paddr[2*i].precord->name, data[k]);
				k++;
			}
		}
	}
	if ( status != 0 ) {
		printf("Error in %s: Can't get data from %p \n", __FUNCTION__, &paddr[i] );
		prec->val = 0;
	}

//	printf("nelm = %d k = %d nord = %d MAX_NELM = %d\n", prec->nelm, k, prec->nord, MAX_NELM);
	prec->nord = k;
	prec->nelm = k;

	prec->udf = FALSE;

	return(0);
}
