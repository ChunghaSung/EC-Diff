#include <pthread.h>
#include <stdint.h>
#include <assert.h>

#define INT_TYPE int8_t

pthread_mutex_t mutex0;

/**
 * Global val_SHAREDue that is manipulated by threads in t_main()
 */
INT_TYPE val_SHARED;

void nop1() {}

/**
 * Calls atomic add on val_SHARED to add 2 to it
 *
 * \param args unused
 * \return Returns NULL upon completion
 */

// Increment the val_SHAREDue stored at the passed memory location by the passed
// ammount
// Increment the val_SHAREDue stored at the passed memory location by the passed
// ammount

void *t1_main(void *args) {

    int v = 2;

    nop1();

    int tmp = val_SHARED;
    tmp += v;
    val_SHARED = tmp;
    nop1();

    return NULL;
}

void *t2_main(void *args) {

    int v = 2;

    nop1();
    int tmp = val_SHARED;
    tmp += v;
    val_SHARED = tmp;
    nop1();

    return NULL;
}

/**
 * Creates two threads in t{1,2}_main() after initializing val_SHARED to 0.
 * Then, checks if the final state of val_SHARED is 4.
 *
 * \return Returns 0 upon completion
 */
int main() {
    pthread_t t1, t2;

    // Initialize val_SHARED
    val_SHARED = 0;

    // Create threads
    pthread_create(&t1, NULL, t1_main, NULL);
    pthread_create(&t2, NULL, t2_main, NULL);

    // Wait for the threads to finish
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    // Since both threads add 2 to val_SHARED, the correct final state should be 4.
    // However, since they are racing to read-modify-write val_SHARED, the end result
    // can be 2.
    if (val_SHARED != 4) {
        assert(0);
    }

    return 0;
}
