#include <stdlib.h>
#include <pthread.h>
#include <stdint.h>
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


pthread_cond_t cond3 = PTHREAD_COND_INITIALIZER;
int cond3_bool = 0;
pthread_mutex_t mutex3 = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond2 = PTHREAD_COND_INITIALIZER;
int cond2_bool = 0;
pthread_mutex_t mutex2 = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond1 = PTHREAD_COND_INITIALIZER;
int cond1_bool = 0;
pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond0 = PTHREAD_COND_INITIALIZER;
int cond0_bool = 0;
pthread_mutex_t mutex0 = PTHREAD_MUTEX_INITIALIZER;

/* Comment out to remove debugging messages */
//#define DEBUG

#ifdef DEBUG
#include <stdio.h>
#endif

#define INT_TYPE int8_t

void nop1() {}

//INT_TYPE unprotected_SHARED;
int8_t unprotected_SHARED;

void *doWork_t1(void* arg) {
#ifdef DEUBG
    printf("Work Function Entered\n");
#endif 

    nop1();

    if (!cond0_bool) {
        nop1();
    }

    nop1();

    if (unprotected_SHARED > 2) {
        return NULL;
    }

    nop1();

    int tmp = unprotected_SHARED + 1;

    pthread_mutex_lock(&sas0);
    unprotected_SHARED = tmp;
    if (!rf_read)
        rf_write0 = true;
    pthread_mutex_unlock(&sas0);

    cond1_bool = 1;

    nop1();

    nop1();


#ifdef DEBUG
    printf("The Value of unprotected_SHARED is: %d\n", unprotected_SHARED);
#endif

    return NULL;
}

void *doWork_t2(void *arg) {
#ifdef DEUBG
    printf("Work Function Entered\n");
#endif 

    nop1();
    if (!cond1_bool) {
        nop1();
    }
    nop1();


    if (unprotected_SHARED > 2) {

        return NULL;
    }

    nop1();

    int tmp = unprotected_SHARED + 1;

    pthread_mutex_lock(&sas0);
    unprotected_SHARED = tmp;
    if (rf_write0 && !rf_read)
        rf_write1 = true;
    pthread_mutex_unlock(&sas0);

    cond2_bool = 1;

    nop1();


    nop1();


#ifdef DEBUG
    printf("The Value of unprotected_SHARED is: %d\n", unprotected_SHARED);
#endif

    return NULL;
}

void *doWork_t3(void* arg) {

    nop1();
    if (!cond2_bool) {
    nop1();
    }
    nop1();

    if (unprotected_SHARED > 2) {
        return NULL;
    }

    int tmp = unprotected_SHARED + 1;

    pthread_mutex_lock(&sas0);
    unprotected_SHARED = tmp;
    if (rf_write0 && !rf_read)
        rf_write2 = true;
    pthread_mutex_unlock(&sas0);

    nop1();

    pthread_mutex_lock(&sas0);
    tmp = unprotected_SHARED + 1;
    rf_read = true;
    if (rf_write0 && !rf_write1 && !rf_write2 && !rf_write3)
        rf_check = true;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas0);
    unprotected_SHARED = tmp;
    if (rf_write0 && !rf_read)
        rf_write3 = true;
    pthread_mutex_unlock(&sas0);

    cond3_bool = 1;

    nop1();


    nop1();

#ifdef DEBUG
    printf("The Value of unprotected_SHARED is: %d\n", unprotected_SHARED);
#endif

    return NULL;
}

/**
 * Spawns three threads in the doWork() function 
 *
 * \return Returns NULL upon completion
 */
int main() {

    pthread_t t1, t2, t3;

    unprotected_SHARED = 0;

    rf_check = false;
    rf_read = false;
    rf_write0 = false;
    rf_write1 = false;
    rf_write2 = false;
    rf_write3 = false;


    pthread_create(&t1, NULL, doWork_t1, NULL);
    pthread_create(&t2, NULL, doWork_t2, NULL);
    pthread_create(&t3, NULL, doWork_t3, NULL);

    //pthread_join(t1, NULL);
    //pthread_join(t2, NULL);
    //pthread_join(t3, NULL);

    nop1();

    cond0_bool = 1;

    nop1();

    nop1();

    nop1();

    if (!cond3_bool) {
        nop1();
    }

    nop1();

    if (unprotected_SHARED != 2) {
        //assert(0);
    }

    assert(!rf_check);

    return 0;
}
