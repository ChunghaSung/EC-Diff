#include <pthread.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>

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

void nop1() {}

/* Comment out to remove debugging calls to printf() */
//#define DEBUG

/* Comment out to remove calls to sleep() with attempt to force the bug */
//#define FORCE

#ifdef FORCE
#include <unistd.h>
#endif

/**
 * Table that is contended for. The table_SHARED_ is as a character representing it
 * being valid or invalid
 */
char table_SHARED_1 = 'A'; // A for allocated!

/**
 * Another table_SHARED_ that is contended for. It is the same as table_SHARED_1. These two
 * table_SHARED_s are joined in `join_init_cache()`.
 */
char table_SHARED_2 = 'A'; // A for allocated!

/**
 * Iterates over the table_SHARED_s and checks if the table_SHARED_s have equal fields
 *
 * \param args Unused
 * \return Return's NULL upon completion
 */
void *join_init_cache(void *args);


/**
 * Removes a two fields from the end of table_SHARED_2
 *
 * \param args Unused
 * \return Return's NULL upon completion
 */
void *fix_field(void *args);

void *join_init_cache(void *args) {

    // Check that the state of both table_SHARED_s is valid
    pthread_mutex_lock(&sas0);
    if (table_SHARED_1 == 'X') {
        //assert(0);
    }
    rf_read = true;
    if (rf_write0 && !rf_write1)
        rf_check = true;
    pthread_mutex_unlock(&sas0);

    if (table_SHARED_2 == 'X') {
        //assert(0);
    }
    nop1();
    cond0_bool = 1;
    nop1();

    nop1();


    return NULL;
}

void *fix_field(void *args) {

    char tmp = table_SHARED_2;
    tmp = 'B'; // B for Best!
    nop1();
    if (!cond0_bool) {
        nop1();
    }
    nop1();

    pthread_mutex_lock(&sas0);
    if (!rf_read)
        rf_write0 = true;
    table_SHARED_2 = 'X'; // X for unallocated :C
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write1 = true;
    table_SHARED_2 = tmp;
    pthread_mutex_unlock(&sas0);

    return NULL;
}

/**
 * Initializes the table_SHARED_s and then spawns threads in join_init_cache() and
 * fix_field()
 *
 * \return Returns 0 upon completion
 */
int main(void) {
    pthread_t t1, t2;

    rf_read = false;
    rf_check = false;
    rf_write0 = false;
    rf_write1 = false;


    /* allocate memory for the table_SHARED_s */
    //table_SHARED_1 = malloc(sizeof(char) * 8);
    //table_SHARED_2 = malloc(sizeof(char) * 8);

    /* Initialize the table_SHARED_s */
    //memcpy(table_SHARED_1, "abcdefg\0", 8);
    //memcpy(table_SHARED_2, "hijklmn\0", 8);

    pthread_create(&t1, NULL, join_init_cache, NULL);
    pthread_create(&t2, NULL, fix_field, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    assert(!rf_check);
}

