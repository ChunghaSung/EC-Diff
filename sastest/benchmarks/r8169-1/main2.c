// Modified by Chungha Sung
// This code is a modified version for standard C style
// from Abstract (Semantic) Diffing of Evolving Concurrent Programs [Bouajjani et al.] in SAS 2017.
// And, there is no any semantic difference from the original code.
// The original code is r8169-1-buggy.c

/* The following example from the r8169 driver illustrates the REORDER.RW pattern.   

There are 2 state variables involved in this example:

* IntrMask is a hardware register used to diable interrupts
* intr_mask is a software variable that mirrors the value of 
  IntrMask (for reasons related to performance and memory 
  coherency)*/

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
bool rf_write2;


int IntrMask_SHARED_BUSY;
int intr_mask_SHARED;
int handled_SHARED;

//#pragma region threads

void* thread1(void* arg) /*(interrupt thread):*/
{
    /* In harware: wait for interrupts to become enabled */
    while (IntrMask_SHARED_BUSY == 0){};

    /* Software interrupt handler */
    if (intr_mask_SHARED == 1) {
        /* handle interrupt */
        pthread_mutex_lock(&sas0);
        if (!rf_read & rf_write0)
            rf_write1 = true;
        handled_SHARED = 1;
        pthread_mutex_unlock(&sas0);
    } else {
        pthread_mutex_lock(&sas0);
        if (!rf_read)
            rf_write0 = true;
        handled_SHARED = 0;
        pthread_mutex_unlock(&sas0);
    }

    pthread_mutex_lock(&sas0);
    if (handled_SHARED != 1) {
        //assert(0);
    }
    rf_read = true;
    if (rf_write0 && !rf_write1 && !rf_write2)
        rf_check = true;
    pthread_mutex_unlock(&sas0);


	//assert (handled == 1);
}

void* thread2(void* arg) /*(delayed interrupt handled):*/
{
        /* enable interrupts */
/*(!!)*/    intr_mask_SHARED = 1;
/*(!)*/     IntrMask_SHARED_BUSY = 1;
}

//#pragma endregion threads

int main() {

    rf_read = false;
    rf_check = false;
    rf_write0 = false;
    rf_write1 = false;
    rf_write2 = false;


    IntrMask_SHARED_BUSY = 0;
    intr_mask_SHARED = 0;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write2 = true;
    handled_SHARED = 0;
    pthread_mutex_unlock(&sas0);

    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);
  //thread1();
  //thread2();

    assert(!rf_check);
    return 0;
}
