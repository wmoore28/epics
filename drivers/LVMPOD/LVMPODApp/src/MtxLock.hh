/*
 * MtxLock.hh
 *
 *  Created on: Apr 29, 2013
 *      Author: Hovanes Egiyan
 *
 *  This simple class helps locking given mutex when creating an object of
 *  this class, and unlocking the mutex when that object is destroyed.
 *  It also has explicit locking and unlocking methods.
 */

#ifndef MTXLOCK_HH_
#define MTXLOCK_HH_

extern "C" {
#include <pthread.h>
} ;

class MtxLock {
protected:
	pthread_mutex_t& m_;
public:
	//! Construct and lock mutex
	inline MtxLock(pthread_mutex_t& m) : m_(m) { pthread_mutex_lock(&m_); }
	//! Destruct and unlock mutex
	inline ~MtxLock() { pthread_mutex_unlock(&m_); }
	//! Explicitly lock mutex
	inline int Lock() { return pthread_mutex_lock(&m_); }
	//! Explicitly unlock mutex
	inline int Unlock() { return pthread_mutex_unlock(&m_); }
};

#endif /* MTXLOCK_HH_ */
