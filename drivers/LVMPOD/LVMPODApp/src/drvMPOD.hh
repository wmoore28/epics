/* File:    drvfadc250.h
 * Author:  Hovanes Egiyan, Jefferson Lab
 * Date:    05-Mar-2013
 *
 * Purpose: 
 * This module provides the driver support for the asyn device support layer
 * for the MPOD module. This asyn driver will be using MpodCrate driver class to
 * dynamically crate the EPICS DB and to update the EPICS records using
 * snmpwalk calls from  MpodCrate. The maximum number of chassis this driver
 * will handle is 16 because of the mbbi/mbbo record usage in the autoconfiguration scheme.
 * The driver assumes that the asyn ports for the chassis is created it cannot be closed,
 * because the bookkeeping will fail.
 *
 */

#ifndef _DRV_MPOD_H_
#define _DRV_MPOD_H_

/************/
/* Includes */
/************/
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>
#include <math.h>

/* EPICS includes */
#include <cantProceed.h>
#include <asynPortDriver.h>
#include <epicsEvent.h>
#include <epicsTypes.h>
#include <epicsThread.h>
#include <epicsString.h>
#include <epicsTimer.h>
#include <epicsExport.h>
#include <epicsMutex.h>
#include <epicsEvent.h>
#include <errlog.h>
#include <iocsh.h>
#include <initHooks.h>




#include <iostream>
#include <string>
#include <map>
#include <vector>
#include <sstream>
#include <algorithm>

using namespace std;

// include the header file for my custom simple mutex manipulation class
#include "MtxLock.hh"
// include header file for the MpodCrate driver
#include "LVMPODCrate.h"

/***************/
/* Definitions */
/***************/
#define MPODBoardNumberString             	"MPOD_BOARD_NUMBER"
#define MPODChannelNumberString            	"MPOD_CHANNEL_NUMBER"
#define MPODBoardTypeString               	"MPOD_BOARD_TYPE"
#define MPODChassisPortString				"MPOD_CHASSIS_PORT"
#define MPODChassisAddrString				"MPOD_CHASSIS_ADDR"


// C-function with global scope that calls the member function
void readCrateParameters( void *drvPtr );

// AsynPortDriver for MPOD configuration parameters
// it inherits from asynPortDriver
class drvMPOD: public asynPortDriver {
	protected:
		string 			dmIP;				// IP name/addres of the MPOD chassis
		bool			dmExists;			// Flag indicating if already exists
		epicsEventId	dmEventID;			// Event ID for waking up reading thread
		MpodCrate*		dmCrate;			// MPOD crate object that handles all MPD related operations
		string 			dmMbbPrefix; 		// MBB prefix for configuring EPICS DB

		pthread_mutex_t 			dmMutex;			//! Mutex for an object
		pthread_mutexattr_t 		dmMtxAttr;			//! Mutex attributes for an object

		static pthread_mutex_t      dmClassMutex;		//! Class mutex for this class
		static pthread_mutexattr_t  dmClassMtxAttr;		//! Class mutex attributes

		static map<string, drvMPOD*>	dmPortMap;		// Map containing pointers to all ports

		static string 	dmChassisFileNameDB;			// DB file name for EPICS records referring to chassis
		static string   dmChassisSnmpFileNameDB;		// DB file for EPICS records referring to chassis using SNMP
		static string 	dmBoardFileNameDB;				// DB file name for EPICS records referring to boards

		static map<string, drvMPOD*> dmMbbPrefixMap; 	// Map to keep mbbi/mbbo string number assignment for chassis
		static vector<string> dmMbbPrefixVec;			// Vector to keep track of insertion order for dmMbbPrefixVec
		static map<string,string> dmBoardFileNameMap;	// Map to map the board type names to DB file names

		//! Initialize the mutex for the object
		void 						initMutex();
		//! Destroy the mutex for the object
		void						closeMutex();
		//! Lock the class mutex for this class
		inline static int 			classLock()
		{ return pthread_mutex_lock( &dmClassMutex ); }
		//! Unlock the class mutex for this class
		inline static int 			classUnlock()
		{ return pthread_mutex_unlock( &dmClassMutex ); }

	public:
		// Main Constructor to be called when creation of a driver is requested from IOC script
		drvMPOD( const char *ipAddress, const char *portName, int maxNumberOfBoards );

		// Destructor
		~drvMPOD();

		// These are the methods we override from asynPortDriver
//		asynStatus readInt32( asynUser* pasynUser, epicsInt32* value );

		// Print out the report for this AsynPortDriver
		virtual void 				report( FILE *fp, int details );

		// Returns the base address value
		inline string 				getIP()
		{ MtxLock objLock( dmMutex ); return dmCrate->GetIPAddress(); }

		// This is the main function for reading. It is executed
		// in a separate thread and fills the values.
		void 						readCrateParameters();

		// Method to  dynamically load EPICS DB records using templates
		int 						loadRecords();

		static map<string,drvMPOD*> initMbbMap( vector<string>& preixVec );
		static vector<string>  		initPrefixVector();
		static map<string,string> 	initBoardFileNameMap();

		inline MpodCrate*			getMpodCrate()
		{ MtxLock objLock( dmMutex ); return dmCrate; }
		inline bool 				exists()
		{ MtxLock objLock( dmMutex ); return dmExists; }

		static map<string, drvMPOD*> getPortMap()
		{ MtxLock classLock( dmClassMutex ); return dmPortMap; }

		//! Initialize global mutex
		static int 					initGlobalMutex();

#define FIRST_MPOD_PARAM MPODBoardNumber_
		int MPODBoardNumber_	;
		int MPODChannelNumber_	;
		int MPODBoardType_		;
		int MPODChassisPort_	;
		int MPODChassisAddr_	;
#define LAST_MPOD_PARAM  MPODChassisAddr_

#define NUM_MPOD_PARAMS (&LAST_MPOD_PARAM- &FIRST_MPOD_PARAM + 1)

};


/***********************/
/* Function prototypes */
/***********************/

/* External functions */
/* iocsh functions */
extern "C" {
  char* drvMPODConfig( const char *ipAddress, const char* portName, int maxNumOfBoards );
}

#endif

