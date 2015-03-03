/* File:    drvfadc250.h
 * Author:  Hovanes Egiyan, Jefferson Lab
 * Date:    05-Mar-2013
 *
 * Purpose: 
 * This module provides the driver support for the asyn device support layer
 * for the MPOD module. This asyn driver will be using MpodCrate driver class to
 * dynamically crate the EPICS DB and to update the EPICS records using
 * snmpwalk calls from  MpodCrate.
 *
 */

#ifndef _DRV_GLOBAL_MPOD_H_
#define _DRV_GLOBAL_MPOD_H_


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
#include <dbBase.h>
#include <dbCommon.h>
#include <dbStaticLib.h>
#include <dbDefs.h>
#include <dbAccessDefs.h>

// include header file for the MpodCrate driver
#include "drvMPOD.hh"
#include "MtxLock.hh"

#include <iostream>
#include <string>
#include <map>
#include <vector>

using namespace std;

/***************/
/* Definitions */
/***************/
#define MPODChassisNumberString				"MPOD_CHASSIS_NUMBER"

// C-function with global scope that calls the member function
void readGlobalParameters( void *drvPtr );

// AsynPortDriver for MPOD global parameters
// it inherits from asynPortDriver
class drvGlobalMPOD : public asynPortDriver {
	protected:
		epicsEventId				dgmEventID;			//! Event ID for waking up reading thread

		pthread_mutex_t 			dgmMutex;			//! Mutex for an object
		pthread_mutexattr_t 		dgmMtxAttr;			//! Mutex attributes for an object

		static pthread_mutex_t      dgmClassMutex;		//! Class mutex for this class
		static pthread_mutexattr_t  dgmClassMtxAttr;	//! Class mutex attributes

		static string 				dmgDirDB;			//! Path to be used when dynamically loading DB files
		static string 				dmgFileNameDB;		//! Template DB filename
		static drvGlobalMPOD*  		dgmInstancePtr;		//! Pointer to the instance
		static string 				dgmPortName;		//! Port name for this class, can only be one

		// Main Constructor to be called when creation of a driver is requested from IOC script
		drvGlobalMPOD();
		//! Main Constructor to be called when creation of a driver is requested from IOC script
		drvGlobalMPOD( const char* pName );

		//! Initialize the mutex for the object
		void 						initMutex();
		//! Destroy the mutex for the object
		void						closeMutex();
		//! Lock the class mutex for this class
		inline static int 			classLock()
		{ return pthread_mutex_lock( &dgmClassMutex ); }
		//! Unlock the class mutex for this class
		inline static int 			classUnlock()
		{ return pthread_mutex_unlock( &dgmClassMutex ); }

	public:
		//! Destructor
		~drvGlobalMPOD();

		//! Print out the report for this AsynPortDriver
		virtual void 			report( FILE *fp, int details );

		//! This is the main function for reading. It is executed
		//! in a separate thread and fills the values.
		void 					readGlobalParameters();

		//! Dynamically load records using template EPICS DB files
		static int 				loadRecords();

		//1 Return the only instance of the class
		static drvGlobalMPOD* 	getInstance();

		//! Initialize global mutex
		static int 				initGlobalMutex();

		inline static string	getDirDB()
		{ MtxLock classLock( dgmClassMutex ); return dmgDirDB; }


#define FIRST_GLOBAL_MPOD_PARAM MPODChassisNumber_
		int MPODChassisNumber_	;
#define LAST_GLOBAL_MPOD_PARAM  MPODChassisNumber_

#define NUM_GLOBAL_MPOD_PARAMS (&LAST_GLOBAL_MPOD_PARAM- &FIRST_GLOBAL_MPOD_PARAM + 1)

};

/***********************/
/* Function prototypes */
/***********************/

/* External functions */
/* iocsh functions */
extern "C" {
  int dbLoadRecordsMPOD( const char *dummy  );
}


#endif

