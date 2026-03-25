
#include <pthread.h>
#include <assert.h>
#include <stdlib.h>

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

    pthread_mutex_lock(&mutex0);

    cond0_bool = 1;

    mthread_state_SHARED = 'A'; // A for allocated!

    pthread_cond_signal(&cond0);

    pthread_mutex_unlock(&mutex0);

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

    mthread_state_SHARED = 'X'; // X for BAD!

    pthread_create(&initer, NULL, threadInit, NULL);

    // Access the state information, the atomicity violation occurs here. It is
    // assumed that the state has been initialized but no synchornization
    // variables are in place to ensure that.

    pthread_mutex_lock(&mutex0);
    if (!cond0_bool) {
        pthread_cond_wait(&cond0, &mutex0);
    }
    pthread_mutex_unlock(&mutex0);

    //getState = mthread.state;
    getState = mthread_state_SHARED;
    if (getState == 'X') {
        assert(0);
    }
    //assert(getState != 'X');

    //pthread_exit((void *) 0);

    return 0;
}
