// Modified by Chungha Sung
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

// sas vars
#include <stdbool.h>
pthread_mutex_t sas0;
bool rf_check;
bool rf_read;
bool rf_write0;
bool rf_write1;


int init_sem_SHARED_BUSY = 1;
int hw_start_SHARED = 0;
int start_device_SHARED = 1;

//#pragma region threads
/*
int start_device() {
    return 0;
}
*/

void* thread1(void* arg)
{
    //register_netdev();
    init_sem_SHARED_BUSY = 1;   // (1)
    
    pthread_mutex_lock(&sas0);
    if (!rf_read)
        rf_write0 = true;
    hw_start_SHARED = start_device_SHARED;  // (2)
    pthread_mutex_unlock(&sas0);
    //hw_start = &start_device;
}

void* thread2(void* arg)
{
    //down(init_sem);
    //init_sem_SHARED--;
    while(init_sem_SHARED_BUSY == 0) {};
	
	//rtl8169_open();
    if (hw_start_SHARED == 0) {

        pthread_mutex_lock(&sas0);
        int tmp = hw_start_SHARED;
        rf_read = true;
        if (rf_write0 && !rf_write1)
            rf_check = true;
        pthread_mutex_unlock(&sas0);


    } else {
        int tmp = hw_start_SHARED;
    }

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

    rf_read = false;
    rf_check = false;
    rf_write0 = false;
    rf_write1 = false;


	init_sem_SHARED_BUSY = 0;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write1 = true;
    hw_start_SHARED = 0;
    pthread_mutex_unlock(&sas0);


    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);

    assert(!rf_check);
}
