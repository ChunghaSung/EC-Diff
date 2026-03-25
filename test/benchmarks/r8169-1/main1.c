// Modified by 
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
        handled_SHARED = 1;
    } else {
		handled_SHARED = 0;
	}
	
    if (handled_SHARED != 1) {
        assert(0);
    }
	//assert (handled == 1);
}

void* thread2(void* arg) /*(delayed interrupt handled):*/
{
        /* enable interrupts */
/*(!)*/     IntrMask_SHARED_BUSY = 1;
/*(!!)*/    intr_mask_SHARED = 1;
}

//#pragma endregion threads

int main() {
    IntrMask_SHARED_BUSY = 0;
    intr_mask_SHARED = 0;
    handled_SHARED = 0;

    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);
  //thread1();
  //thread2();
    return 0;
}
