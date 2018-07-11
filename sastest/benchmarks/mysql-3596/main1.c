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

void nop1() {}

void *delete(void* arg) {
    free(sharedData_SHARED);
    nop1();
    if (!cond0_bool) {
        nop1();
    }
    nop1();

    pthread_mutex_lock(&sas0);
    if (!rf_read)
        rf_write0 = true;
    sharedData_SHARED = NULL;
    pthread_mutex_unlock(&sas0);

#ifdef DEBUG
    printf("Data freed\n");
#endif

    return NULL;
}

void *use(void *arg) {

#ifdef DEBUG
    printf("About to use the data\n");
#endif

    nop1();
    cond0_bool = 1;

    pthread_mutex_lock(&sas0);
    if (sharedData_SHARED == NULL) {
        //assert(0);
    }
    rf_read = true;
    if (rf_write0 && !rf_write1)
        rf_check = true;
    pthread_mutex_unlock(&sas0);



    nop1();

    nop1();


    return NULL;
}

/**
 * Allocates memory for sharedData_SHARED and creates two threads: one in use() and
 * one in delete()
 *
 * \return Returns 0 upon completion
 */
int main() {

    rf_read = false;
    rf_check = false;
    rf_write0 = false;
    rf_write1 = false;


    /* Allocate memory for the shared data */
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write1 = true;
    sharedData_SHARED = malloc(sizeof(int));
    pthread_mutex_unlock(&sas0);


    pthread_t user, deleter;

    pthread_create(&user, NULL, use, NULL);
    pthread_create(&deleter, NULL, delete, NULL);

    /* Prevent main() from "falling off" and terminating the process before the
     * threads complete */

    //pthread_exit(NULL);

    assert(!rf_check);
}



