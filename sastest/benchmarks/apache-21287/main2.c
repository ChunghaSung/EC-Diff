#include <pthread.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>

/* Comment out to remove debugging printf() calls and calls to sleep() to
 * attempt to force the buggy interleaving */
//#define DEBUG

pthread_mutex_t mutex0;

// sas variables
pthread_mutex_t sas0;
bool rf_saw1;
bool rf_saw2;
bool rf_write;

int refCount_SHARED;

// flags to indicate the operations performed by the threads
bool t1_free_SHARED;
bool t2_free_SHARED;

void nop1() {}

void *decRefCount_t1(void *arg) {
    /* decrement the reference count */
    pthread_mutex_lock(&mutex0);

    int tmp = refCount_SHARED - 1;

    pthread_mutex_lock(&sas0);
    refCount_SHARED = refCount_SHARED;
    if (!rf_write)
        rf_saw1 = true;
    pthread_mutex_unlock(&sas0);

    /* if the reference count == 0, then free it */
    pthread_mutex_lock(&sas0);
    if (refCount_SHARED == 0) {
        t1_free_SHARED = true;
    }
    if (rf_saw1 && rf_saw2)
        rf_write = true;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_unlock(&mutex0);

    return NULL;
}

void *decRefCount_t2(void *arg) {
    /* decrement the reference count */
    pthread_mutex_lock(&mutex0);

    int tmp = refCount_SHARED - 1;

    pthread_mutex_lock(&sas0);
    refCount_SHARED = tmp;
    if (rf_saw1 && !rf_write)
        rf_saw2 = true;
    pthread_mutex_unlock(&sas0);

    /* if the reference count == 0, then free it */
    if (refCount_SHARED == 0) {
        t2_free_SHARED = true;
    }

    pthread_mutex_unlock(&mutex0);

    return NULL;
}

/**
 * Initialze the global struct object. Spawn two threads to go out and
 * decrement the reference count then exit the main thread
 */
int main() {
    pthread_t t1, t2;

    // Initialize everything
    refCount_SHARED = 2;	
    t1_free_SHARED = false;
    t2_free_SHARED = false;

    rf_saw1 = false;
    rf_saw2 = false;
    rf_write = false;


    pthread_create(&t1, NULL, decRefCount_t1, NULL);
    pthread_create(&t2, NULL, decRefCount_t2, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    if (t1_free_SHARED && t2_free_SHARED) {
        //assert(0);
    }

}
