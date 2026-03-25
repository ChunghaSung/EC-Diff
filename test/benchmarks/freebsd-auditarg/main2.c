#include <stdlib.h>
#include <pthread.h>
#include <stdint.h>
#include <assert.h>

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

    unprotected_SHARED++;

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

    unprotected_SHARED++;

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

    unprotected_SHARED++;

    nop1();

    unprotected_SHARED++;

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
        assert(0);
    }

    return 0;
}
