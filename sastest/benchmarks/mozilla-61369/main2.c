
#include <pthread.h>
#include <assert.h>
#include <stdlib.h>

// sas vars
#include <stdbool.h>
pthread_mutex_t sas0;
bool rf_check;
bool rf_read;
bool rf_write0;
bool rf_write1;


pthread_cond_t cond0 = PTHREAD_COND_INITIALIZER;
int cond0_bool = 0;
pthread_mutex_t mutex0 = PTHREAD_MUTEX_INITIALIZER;

/* Comment out to disable debugging information */
//#define DEBUG

/**
 * Struct that in the mozilla code holds more information, but the variable
 * this program is concerned with is only state, which is what the bug is
 * circled around
 */
//struct mthread_ {
    //char state;    /**< Variable that is raced after */
//} mthread;  /**< instance of the mthread_ struct */

char mthread_state_SHARED;

/**
 * Initialize the thread structure.
 *
 * \param arg Unused
 * \return Returns NULL upon completion
 */

void nop1() {}

void *threadInit(void *arg) {

    nop1();

    cond0_bool = 1;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write1 = true;
    mthread_state_SHARED = 'A'; // A for allocated!
    pthread_mutex_unlock(&sas0);

    nop1();

    nop1();

    return NULL;
}

/** 
 * Spawn a thread to initialize the thread structure and then access the state
 * information. There is assumed atomicity between these operations but no
 * synchronization exisits
 *
 * \return Returns 0 upon completion
 */
int main() {
    pthread_t initer;

    char getState;

    rf_read = false;
    rf_check = false;
    rf_write0 = false;
    rf_write1 = false;


    pthread_mutex_lock(&sas0);
    if (!rf_read)
        rf_write0 = true;
    mthread_state_SHARED = 'X'; // X for BAD!
    pthread_mutex_unlock(&sas0);

    pthread_create(&initer, NULL, threadInit, NULL);

    // Access the state information, the atomicity violation occurs here. It is
    // assumed that the state has been initialized but no synchornization
    // variables are in place to ensure that.

    nop1();
    if (!cond0_bool) {
        nop1();
    }
    nop1();

    //getState = mthread.state;
    pthread_mutex_lock(&sas0);
    getState = mthread_state_SHARED;
    rf_read = true;
    if (rf_write0 && !rf_write1)
        rf_check = true;
    pthread_mutex_unlock(&sas0);


    if (getState == 'X') {
        //assert(0);
    }
    //assert(getState != 'X');

    //pthread_exit((void *) 0);

    assert(!rf_check);

    return 0;
}
