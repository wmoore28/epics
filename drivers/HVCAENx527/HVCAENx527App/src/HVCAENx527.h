/* $Header: HVCAENx527/HVCAENx527App/src/HVCAENx527.h 1.13 2007/06/01 13:32:57CST Ru Igarashi (igarasr) Exp Ru Igarashi (igarasr)(2007/06/01 13:32:58CST) $ 
 */
#include <stdio.h>
#include <string.h>
#include <dbDefs.h>
#include <dbAccess.h>
#include <recSup.h>
#include <devSup.h>
#include <callback.h>
#include <errlog.h>
#include <sys/time.h>

#include <CAENHVWrapper.h>

#define EVNTNO_UPDATE	10
#define EVNTNO_T1	11
#define EVNTNO_T2	12
#define EVNTNO_T3	13

/* Turn on (1) or off (0) scan server mode */
/* This may be needed if the CAEN driver can't handle asynchronous
   monitoring of parameters, i.e. a get for one channel is mixed up
   with the get for another. */
/* Update: This definitely is needed. */
#define SCAN_SERVER 1

typedef struct ParProp
{
	char pname[16];
	union
	{
		float f;
		long l;
		double d;
	} pval;
	union
	{
		float f;
		long l;
		double d;
	} pvalset;
	unsigned long Type, Mode;
	float Minval, Maxval;
	unsigned short Unit;	/* engineering unit */
	short Exp;		/* exponent of numbers, e.g. +3 = kilo */
	char Onstate[32], Offstate[32];	/* Labels associated with state */
	struct HVChan *hvchan;
	/* EPICS-related variables */
	char PVname[61];
	/* "period" is here for future implementation */
	double period;	/* desired scan period, -1 == not scanned */
	int evntno;	/* EPICS event number, -1 == not scanned */
	struct dbAddr PVaddr;
	CALLBACK pcallback;
} PARPROP;

typedef struct HVChan
{
	unsigned short *crate, slot, chan; /* crate, slot, channel number */
	char chaddr[16];
	char chname[16];
	/* The Channel Name is an oddball parameter.  The CAEN driver
		treats it separately from other channel parameters, so
		we're treating its scan parameters specially here, too */
	double chname_period;
	int chname_evntno;
	short npar;
	PARPROP *pplist;		/* parameters list */
	struct HVCrate *hvcrate;	/* crate data connector */
	/* EPICS-related variables */
	short epicsenabled;	/* 1 = PV exists, 0 = no PV */
} HVCHAN;

typedef struct HVSlot
{
	char slname[64];
	short nchan;
	float hvmax;
	HVCHAN **hvchan;	/* channel list */
} HVSLOT;

typedef struct CrateScanList
{
	char pname[16];
	double period;	/* default desired scan period, -1 == not scanned */
	int evntno;	/* default EPICS event number, -1 == not scanned */
	/* RU! consider putting the channel number lists here */
	struct CrateScanList *next;
} CRATESCANLIST;

typedef struct HVCrate
{
	char name[64];
	char IPaddr[64];
	char username[9];
	char password[33];
	unsigned short crate;	/* crate number */
	short nsl;	/* max number of slots in crate */
	short nchan;	/* total number of channels (#slot * #nchperslot) */
	HVCHAN *hvchan;	/* list of HV channels controlled by this crate */
	HVSLOT *hvchmap;	/* slot X chan lookup table of *hvchan */
	CRATESCANLIST *csl;
	short connected;
} HVCRATE;
extern HVCRATE Crate[MAX_CRATES];
extern short DEBUG;
#define PDEBUG(LEVEL)	if( DEBUG >= LEVEL)
/*
	DEBUG level guideline
	 0 - none
	 1 - not repeated initialization and shutdown messages,
	     messages about the crate and slots that appear only once 
	     during run-time
	 2 - messages about the crate that appear once per crate scan
	 3 - messages about channels that appear only once during run-time
	 4 - messages about channel parameters that appear only once 
	     during run-time
	 5 - messages about channels that appear once per crate scan
	 6 - messages about channels parameters that appear once per crate scan
	10 - all messages
*/

float ScanChannelsPeriod;

int ConnectCrate( char *name);
void CAENx527ConfigureCreate(char *name, char *addr, char *username, char* password);
void CAENx527DbLoadRecords(const char* prefix);

void Shutdown();
#if 0
void iCallback( CALLBACK *pcallback);
void oCallback( CALLBACK *pcallback);
#endif
void *CAENx527ParseDevArgs( char *saddr);
void *CAENx527GetChParVal( PARPROP *pp);
int CAENx527SetChParVal( PARPROP *pp);
char *CAENx527GetChName( HVCHAN *hvch);
int CAENx527SetChName( HVCHAN *hvch, char *chname);
short CAENx527mbbi2state( PARPROP *pp);
void CAENx527mbbi2bits( PARPROP *pp, char *bits, short nbits);
char *CAENx527GetParUnit( PARPROP *pp, char *fieldval);

/* 
 * $Log: HVCAENx527/HVCAENx527App/src/HVCAENx527.h  $ 
 * Revision 1.13 2007/06/01 13:32:57CST Ru Igarashi (igarasr)  
 * Member moved from EPICS/HVCAENx527App/src/HVCAENx527.h in project e:/MKS_Home/archive/cs/epics_local/drivers/CAENx527HV/project.pj to HVCAENx527/HVCAENx527App/src/HVCAENx527.h in project e:/MKS_Home/archive/cs/epics_local/drivers/CAENx527HV/project.pj. 
 */
