#include <pthread.h>
#include <stdint.h>
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


#define INT_TYPE int8_t

pthread_mutex_t mutex0;

/**
 * Global val_SHAREDue that is manipulated by threads in t_main()
 */
INT_TYPE val_SHARED;

void nop1(){}

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

    pthread_mutex_lock(&mutex0);

    pthread_mutex_lock(&sas0);
    int tmp = val_SHARED;
    rf_read1 = true;
    if (rf_write01 && !rf_write11 && !rf_write21)
        rf_check1 = true;
    pthread_mutex_unlock(&sas0);

    tmp += v;

    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    val_SHARED = tmp;
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

    int v = 2;

    pthread_mutex_lock(&mutex0);

    pthread_mutex_lock(&sas1);
    int tmp = val_SHARED;
    rf_read2 = true;
    if (rf_write02 && !rf_write12 && !rf_write12)
        rf_check2 = true;
    pthread_mutex_unlock(&sas1);

    tmp += v;
    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    val_SHARED = tmp;
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
 * Creates two threads in t{1,2}_main() after initializing val_SHARED to 0.
 * Then, checks if the final state of val_SHARED is 4.
 *
 * \return Returns 0 upon completion
 */
int main() {
    pthread_t t1, t2;

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
    val_SHARED = 0;
    if (!rf_read1)
        rf_write01 = true;
    if (!rf_read2)
        rf_write02 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);

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
        //assert(0);
    }

    if (rf_check1 && rf_check2)
        assert(0);

    return 0;
}
