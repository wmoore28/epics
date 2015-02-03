/*
 * vmeChassis.hh
 *
 *  Created on: June 16, 2014
 *      Author:
 *
 *      This class provides interface that EPICS support will use to monitor
 *      and control the JLAB boards on a VME/VXS chassis.
 *      All methods, including accesssors, need to be thread-safe since they
 *      may be executing simultaneousely on multiple threads.
 */

#ifndef _vmeChassis_HH_
#define _vmeChassis_HH_

#include <stdint.h>

#include <iostream>
#include <string>
#include <vector>
#include <map>

#include "jlabBoard.hh"

using namespace std;

class vmeChassis {

protected:
	// Prevent copying boards
	vmeChassis(const vmeChassis& chassis);
	vmeChassis& operator=(const vmeChassis& chassis);
	
	// Map with the boards that the chassis can see. The key is the slot number.
	map<uint32_t, jlabBoard*> 	vcBoardMap;
	
	// Map of chassis that have been connected so far
	static map<string,vmeChassis*> vcMapOfChassis;
	
public:

	// Constructor. Open communication for the chassis specified by IP address.
	// Create all board objects on that chassis and fill the board map. 
	// Throws an exception if fails to create the object or the chassis 
	// already has been connected.
	vmeChassis( const string ipAddress );

	// Destructor. Destroys this board. 
	~vmeChassis();
	
	// Return the 32-bit status word for this board
	uint32_t					GetStatus();

	// Return the number of channels this board chassis is serving
	uint32_t					GetNumberOfBoards();

	// Return the IP address of the board
	string						GetAddress();
	
	// Return the map with the boards that the chassis can see. The key is the slot number.
	map<uint32_t, jlabBoard*>	GetBoardMap();
	
	static map<string,vmeChassis*> GetMapOfChassis();	
};

#endif /* _vmeChassis_HH_ */
