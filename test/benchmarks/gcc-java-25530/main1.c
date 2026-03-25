#include <assert.h>
#include <pthread.h>
#include <stdbool.h>

pthread_mutex_t mutex0;

void nop1(){}

// Booleans to represent the state of the file
bool renamed_SHARED;
bool removed_SHARED;
char data_SHARED;

/**
 * Opens a file with write permission with the file writes some
 * information to it and then attempts to rename and remvoe the temporary file.
 *
 * \param args Unused
 * \return Returns NULL upon completion
 */

/**
 * Opens a file with , writes some information to it and then attempts to
 * rename and remvoe the temporary file.
 *
 * \param args Unused
 * \return Returns NULL upon completion
 */

void *t1_main(void *args) {
    // write some data_SHARED
    data_SHARED = 'a'; 


    // remove the temporary file
    nop1();

    if (removed_SHARED) {
        // commented out for getting postdom relations
        //assert(0);
    }
    removed_SHARED = true;
    
    nop1();

    return NULL;
}

void *t2_main(void *args) {
    // write some data_SHARED
    data_SHARED = 'a'; 


    // remove the temporary file
    nop1();

    if (removed_SHARED) {
        // commented out for getting postdom relations
        //assert(0);
    }
    removed_SHARED = true;
    nop1();

    return NULL;
}

/**
 * Spawns threads into t1_main() and t2_main()
 *
 * Returns NULL upon completion.
 */
int main(void) {
    pthread_t t1, t2;

    // initialize everything
    renamed_SHARED = false;
    removed_SHARED = false;
    data_SHARED = 'x';

    pthread_create(&t1, NULL, t1_main, NULL);
    pthread_create(&t2, NULL, t2_main, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    return 0;
}
