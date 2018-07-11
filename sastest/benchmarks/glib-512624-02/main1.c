#include <pthread.h>
#include <assert.h>

// sas vars
#include <stdbool.h>
pthread_mutex_t sas0;
bool rf_check;
bool rf_read;
bool rf_write0;
bool rf_write1;
bool rf_write2;
bool rf_write3;
bool rf_write4;
bool rf_write5;
bool rf_write6;
bool rf_write7;
bool rf_write8;
bool rf_write9;
bool rf_write10;
bool rf_write11;
bool rf_write12;
bool rf_write13;
bool rf_write14;
bool rf_write15;
bool rf_write16;
bool rf_write17;
bool rf_write18;
bool rf_write19;
bool rf_write20;


/**
 * Value that is incremented or decremented by t1_main() or t2_main()
 */
int shared_SHARED;

pthread_mutex_t mutex0;

/**
 * Increments shared_SHARED a bunch
 *
 * \param args Unused
 * \return Returns NULL upon completion
 */

/**
 * Decrements shared_SHARED a bunch
 *
 * \param args Unused
 * \return Returns NULL upon completin
 */

void nop1() {};

void *t1_main(void *args) {

    nop1();

    pthread_mutex_lock(&sas0);
    if (!rf_read)
        rf_write0 = true;
    shared_SHARED++;
    pthread_mutex_unlock(&sas0);
    
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write2 = true;
    shared_SHARED++;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write3 = true;
    shared_SHARED++;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write4 = true;
    shared_SHARED++;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write5 = true;
    shared_SHARED++;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write6 = true;
    shared_SHARED++;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write7 = true;
    shared_SHARED++;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write8 = true;
    shared_SHARED++;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write9 = true;
    shared_SHARED++;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write10 = true;
    shared_SHARED++;
    pthread_mutex_unlock(&sas0);

    nop1();

    return NULL;
}

void *t2_main(void *args) {

    nop1();

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write11 = true;
    shared_SHARED--;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write12 = true;
    shared_SHARED--;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write13 = true;
    shared_SHARED--;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas0);
    shared_SHARED--;
    rf_read = true;
    if (rf_write0 && !rf_write1 && !rf_write2 && !rf_write3 && !rf_write4 && !rf_write5 && !rf_write6 && !rf_write7 && !rf_write8 && !rf_write9 && !rf_write10 && !rf_write11 && !rf_write12 && !rf_write13 && !rf_write14 && !rf_write15 && !rf_write16 && !rf_write17 && !rf_write18 && !rf_write19 && !rf_write20)
        rf_check = true;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write14 = true;
    shared_SHARED--;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write15 = true;
    shared_SHARED--;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write16 = true;
    shared_SHARED--;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write17 = true;
    shared_SHARED--;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write18 = true;
    shared_SHARED--;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write19 = true;
    shared_SHARED--;
    pthread_mutex_unlock(&sas0);


    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write20 = true;
    shared_SHARED--;
    pthread_mutex_unlock(&sas0);

    nop1();

    return NULL;
}

/**
 * Initialized shared_SHARED to 0 and then spawns threads in t1_main() and t2_main.
 * calls pthread_join on both the threads and checks if the end value of shared_SHARED
 * is 0 (using assert()).
 *
 * \param argc Unused
 * \param argv Unused
 * \return Returns NULL upon completion
 */

int main(int argc, char *argv[]) {
    /* threads for t1_main and t2_main */
    pthread_t t1, t2;

    /* initialize shared_SHARED */
    shared_SHARED = 0;

    rf_read = false;
    rf_check = false;
    rf_write0 = false;
    rf_write1 = false;
    rf_write2 = false;
    rf_write3 = false;
    rf_write4 = false;
    rf_write5 = false;
    rf_write6 = false;
    rf_write7 = false;
    rf_write8 = false;
    rf_write9 = false;
    rf_write10 = false;
    rf_write11 = false;
    rf_write12 = false;
    rf_write13 = false; 
    rf_write14 = false;
    rf_write15 = false;
    rf_write16 = false; 
    rf_write17 = false;
    rf_write18 = false;
    rf_write19 = false; 
    rf_write20 = false; 

    /* create the threads */
    pthread_create(&t1, NULL, t1_main, NULL);
    pthread_create(&t2, NULL, t2_main, NULL);

    /* wait for them to exit */
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    /* the two thread should decrement and increment the same number of times */
    //assert(shared_SHARED == 0);

    assert(!rf_check);

    return 0;
}

