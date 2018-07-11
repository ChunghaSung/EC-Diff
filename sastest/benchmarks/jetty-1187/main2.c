#include <pthread.h>
#include <assert.h>

// sas vars
#include <stdbool.h>
pthread_mutex_t sas0;
pthread_mutex_t sas1;
bool rf_read1;
bool rf_read2;
bool rf_check1;
bool rf_check2;
bool rf_write01; bool rf_write02;
bool rf_write11; bool rf_write12;
bool rf_write21; bool rf_write22;
bool rf_write31; bool rf_write32;


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
    nop1();

    pthread_mutex_lock(&sas0);
    int tmp = _set_SHARED + 1;
    rf_read1 = true;
    if (rf_write01 && !rf_write11 && !rf_write21)
        rf_check1 = true;
    pthread_mutex_unlock(&sas0);


    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    _set_SHARED = tmp;
    if (!rf_read1 && rf_write01)
        rf_write11 = true;
    if (!rf_read2 && rf_write02)
        rf_write12 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);

    nop1();

    return NULL;
}

void *t2_main(void *args) {
    pthread_mutex_lock(&m);
    nop1();

    pthread_mutex_lock(&sas1);
    int tmp = _set_SHARED - 1;
    rf_read2 = true;
    if (rf_write02 && !rf_write12 && !rf_write12)
        rf_check2 = true;
    pthread_mutex_unlock(&sas1);



    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    _set_SHARED = tmp;
    if (!rf_read1 && rf_write01)
        rf_write21 = true;
    if (!rf_read2 && rf_write02)
        rf_write22 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);


    nop1();

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
    rf_read1 = false;
    rf_read2 = false;
    rf_check1 = false;
    rf_check2 = false;
    rf_write01 = false;
    rf_write02 = false;
    rf_write11 = false; rf_write12 = false;
    rf_write21 = false; rf_write22 = false;
    rf_write31 = false; rf_write32 = false;

    // Initialize val_SHARED
    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    _set_SHARED = 0;
    if (!rf_read1)
        rf_write01 = true;
    if (!rf_read2)
        rf_write02 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);



    // Spawn threads into t_main
    pthread_create(&t1, NULL, t1_main, NULL);
    pthread_create(&t2, NULL, t2_main, NULL);


    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    //assert(_set_SHARED == 0);
    if (rf_check1 && rf_check2)
        assert(0);


    return 0;
}
