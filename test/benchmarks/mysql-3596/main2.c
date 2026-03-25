#include <pthread.h>
#include <assert.h>
#include <stdlib.h>

pthread_cond_t cond0 = PTHREAD_COND_INITIALIZER;
int cond0_bool = 0;
pthread_mutex_t mutex0 = PTHREAD_MUTEX_INITIALIZER;

/* Commment out the following to disable debugging information */
//#define DEBUG

#ifdef DEBUG
#include <stdio.h>
#endif

/**
 * Data that is raced after 
 */
int *sharedData_SHARED;

/**
 * Calls free() and sharedData_SHARED()
 */

/**
 * Increments sharedData_SHARED. This accomplishes using the data to potentialy cause
 * an atomicity violation 
 */

void *delete(void* arg) {

    free(sharedData_SHARED);

    pthread_mutex_lock(&mutex0);

    if (!cond0_bool) {
        pthread_cond_wait(&cond0, &mutex0);
    }
    pthread_mutex_unlock(&mutex0);

    sharedData_SHARED = NULL;

#ifdef DEBUG
    printf("Data freed\n");
#endif

    return NULL;
}

void *use(void *arg) {

#ifdef DEBUG
    printf("About to use the data\n");
#endif

    pthread_mutex_lock(&mutex0);
    cond0_bool = 1;

    if (sharedData_SHARED == NULL) {
        assert(0);
    }

    pthread_cond_signal(&cond0);

    pthread_mutex_unlock(&mutex0);


    return NULL;
}

/**
 * Allocates memory for sharedData_SHARED and creates two threads: one in use() and
 * one in delete()
 *
 * \return Returns 0 upon completion
 */
int main() {
    /* Allocate memory for the shared data */
    sharedData_SHARED = malloc(sizeof(int));

    pthread_t user, deleter;

    pthread_create(&user, NULL, use, NULL);
    pthread_create(&deleter, NULL, delete, NULL);

    /* Prevent main() from "falling off" and terminating the process before the
     * threads complete */

    //pthread_exit(NULL);
}



