#include <pthread.h>
#include <assert.h>

// Comment out to remove the call to assert() in main
// #define ASSERT

pthread_mutex_t mutex0;

/**
 * Global variable that is raced after
 */
int _set_SHARED;
pthread_mutex_t m;

void nop1();

/**
 * Increments _set_SHARED
 */

/**
 * Decrements _set_SHARED but holds a lock while doing so
 */

void *t1_main(void *args) {
    pthread_mutex_lock(&mutex0);

    _set_SHARED++;
    pthread_mutex_unlock(&mutex0);

    return NULL;
}

void *t2_main(void *args) {
    pthread_mutex_lock(&m);
    pthread_mutex_lock(&mutex0);

    _set_SHARED--;
    pthread_mutex_unlock(&mutex0);

    pthread_mutex_unlock(&m);
    return NULL;
}

/**
 * Initializes _set_SHARED to zero and spawns three threads in t_main(). Waits for the
 * threads to return and then asserts that _set_SHARED == 0 
 *
 *
 * \return Returns 0 upon completion
 */
int main(void) {
    pthread_t t1, t2, t3, t4;

    // Initialize set to zero
    _set_SHARED = 0;

    // Spawn threads into t_main
    pthread_create(&t1, NULL, t1_main, NULL);
    pthread_create(&t2, NULL, t2_main, NULL);


    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    assert(_set_SHARED == 0);

    return 0;
}
