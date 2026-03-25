// Modified by Anony
// This code is a modified version for standard C style
// from Abstract (Semantic) Diffing of Evolving Concurrent Programs [Bouajjani et al.] in SAS 2017.
// And, there is no any semantic difference from the original code.
// The original code is r8169-2-buggy.c

/*This example from the r8169 driver illustrates the REORDER.RELEASE 
  pattern.

The example involves two driver functions.  The first one (thread1()) is the 
initialisation function invoked when the driver is loaded.  It 
allocates various resources required by the driver and registers 
the driver in the system using the register_netdev function. 
The second function rtl8169_open is invoked when a user-level program
wants to start using the device. */

/*OS model:*/

#include <stdio.h>
#include <pthread.h>
#include <assert.h>

int init_sem_SHARED_BUSY = 1;
int hw_start_SHARED = 0;
int start_device_SHARED = 0;

//#pragma region threads
/*
int start_device() {
    return 0;
}
*/

void* thread1(void* arg)
{
    hw_start_SHARED = start_device_SHARED;  // (2)
    //hw_start = &start_device;

    //register_netdev();
    init_sem_SHARED_BUSY = 1;   // (1)
}

void* thread2(void* arg)
{
    //down(init_sem);
    //init_sem_SHARED--;
    while(init_sem_SHARED_BUSY == 0) {};
	
	//rtl8169_open();
    
    int tmp = hw_start_SHARED;
}

/*
int register_netdev()
{
    up(init_sem);
}

int rtl8169_open()
{
    (*hw_start)();
}
*/

//#pragma endregion threads

void main() {
	init_sem_SHARED_BUSY = 0;
    hw_start_SHARED = 0;

    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);
}
