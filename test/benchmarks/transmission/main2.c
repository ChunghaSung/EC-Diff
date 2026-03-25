#include <pthread.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>


pthread_cond_t cond0 = PTHREAD_COND_INITIALIZER;
int cond0_bool = 0;
pthread_mutex_t mutex0 = PTHREAD_MUTEX_INITIALIZER;

/* Comment out to remove debugging messages */
//#define DEBUG

#ifdef DEBUG
#include <stdio.h>
#endif

/**
 * Represents a variable in transmission that is raced after 
 */
char *bandwidth_SHARED;

void nop1() {}

/**
 * Thread function that mallocs bandwidth_SHARED
 *
 * \param arg Unused
 * \return Returns NULL upon completion
 */
void *init(void *arg);

/**
 * Writes data to bandwidth_SHARED. There is no atomicity between this and init()
 * which is where the bug comes from
 *
 * \param arg Unused
 * \return Returns NULL upon completion
 */
void *allocate(void *arg);

void *init(void *arg) {

    bandwidth_SHARED = malloc(sizeof(char));

    pthread_mutex_lock(&mutex0);
    cond0_bool = 1;
    pthread_cond_signal(&cond0);

    pthread_mutex_unlock(&mutex0);

    return NULL;
}


void *allocate(void *arg) {

    pthread_mutex_lock(&mutex0);

    if (!cond0_bool) {
        pthread_cond_wait(&cond0, &mutex0);
    }
    pthread_mutex_unlock(&mutex0);

    if (bandwidth_SHARED == NULL) { 
        assert(0); 
    }

    //memcpy(bandwidth_SHARED, "9", 1);
    // use malloc to represent write operation instead of memcpy
    bandwidth_SHARED = malloc(sizeof(char));

    return NULL;
}


/**
 * Sets bandwidht to NULL and spawns the thread functions
 *
 * \return Returns 0 upon completion
 */
int main() {
    pthread_t t1, t2;

    bandwidth_SHARED = NULL;

    pthread_create(&t1, NULL, init, NULL);
    pthread_create(&t2, NULL, allocate, NULL);

    //pthread_exit((void *) 0);
}
