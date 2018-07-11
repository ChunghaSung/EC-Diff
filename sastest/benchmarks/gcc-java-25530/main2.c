#include <assert.h>
#include <pthread.h>
#include <stdbool.h>

// sas vars
#include <stdbool.h>
pthread_mutex_t sas0;
pthread_mutex_t sas1;
bool rf_read1;
bool rf_read2;
bool rf_check1;
bool rf_check2;
bool rf_write01;
bool rf_write02;
bool rf_write11;
bool rf_write12;
bool rf_write21;
bool rf_write22;
bool rf_write31;
bool rf_write32;


pthread_mutex_t mutex0 = PTHREAD_MUTEX_INITIALIZER;

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
    pthread_mutex_lock(&mutex0);

    pthread_mutex_lock(&sas0);
    if (removed_SHARED) {
        // commented out for getting postdom relations
        //assert(0);
    }
    rf_read1 = true;
    if (rf_write01 && !rf_write11 && !rf_write21)
        rf_check1 = true;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    removed_SHARED = true;
    if (!rf_read1 && rf_write01)
        rf_write11 = true;
    if (!rf_read2 && rf_write02)
        rf_write12 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);

    pthread_mutex_unlock(&mutex0);


    return NULL;
}

void *t2_main(void *args) {
    // write some data_SHARED
    data_SHARED = 'a'; 


    // remove the temporary file
    pthread_mutex_lock(&mutex0);

    pthread_mutex_lock(&sas1);
    if (removed_SHARED) {
        // commented out for getting postdom relations
        //assert(0);
    }
    rf_read2 = true;
    if (rf_write02 && !rf_write12 && !rf_write22)
        rf_check2 = true;
    pthread_mutex_unlock(&sas1);

    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    removed_SHARED = true;
    if (!rf_read1 && rf_write01)
        rf_write21 = true;
    if (!rf_read2 && rf_write02)
        rf_write22 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);

    pthread_mutex_unlock(&mutex0);


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

    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    removed_SHARED = false;
    if (!rf_read1)
        rf_write01 = true;
    if (!rf_read2)
        rf_write02 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);

    data_SHARED = 'x';

    pthread_create(&t1, NULL, t1_main, NULL);
    pthread_create(&t2, NULL, t2_main, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    if (rf_check1 && rf_check2)
        assert(0);

    return 0;
}
