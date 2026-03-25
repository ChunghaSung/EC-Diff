#include <pthread.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>

/* Comment out to remove debugging printf() calls and calls to sleep() to
 * attempt to force the buggy interleaving */
//#define DEBUG

pthread_mutex_t mutex0;

int refCount_SHARED;

// flags to indicate the operations performed by the threads
bool t1_free_SHARED;
bool t2_free_SHARED;

void nop1() {}

void *decRefCount_t1(void *arg) {
    /* decrement the reference count */
    pthread_mutex_lock(&mutex0);

    refCount_SHARED--;

    /* if the reference count == 0, then free it */
    if (refCount_SHARED == 0) {
        t1_free_SHARED = true;
    }

    pthread_mutex_unlock(&mutex0);

    return NULL;
}

void *decRefCount_t2(void *arg) {
    /* decrement the reference count */
    pthread_mutex_lock(&mutex0);

    refCount_SHARED--;

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

    pthread_create(&t1, NULL, decRefCount_t1, NULL);
    pthread_create(&t2, NULL, decRefCount_t2, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    if (t1_free_SHARED && t2_free_SHARED) {
        assert(0);
    }

}
