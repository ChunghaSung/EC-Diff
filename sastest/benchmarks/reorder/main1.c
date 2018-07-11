#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <assert.h>

// sas vars
#include <stdbool.h>
pthread_mutex_t sas0;
bool rf_check;
bool rf_read;
bool rf_write0;


pthread_cond_t cond2 = PTHREAD_COND_INITIALIZER;
int cond2_bool = 0;
pthread_mutex_t mutex2 = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond1 = PTHREAD_COND_INITIALIZER;
int cond1_bool = 0;
pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond0 = PTHREAD_COND_INITIALIZER;
int cond0_bool = 0;
pthread_mutex_t mutex0 = PTHREAD_MUTEX_INITIALIZER;

// special var for chekcing order
int order1_SHARED = 0;
int order2_SHARED = 0;
int order3_SHARED = 0;

//#define USAGE "./reorder <param1> <param2>\n"
//#define ISET 2
//#define ICHECK 2
static int iSet_SHARED = 2;
static int iCheck_SHARED = 2;

static int a_SHARED = 0;
static int b_SHARED = 0;

void *setThread1(void *param);
void *setThread2(void *param);
void *checkThread1(void *param);
void *checkThread2(void *param);

void nop1() {}

int main(int argc, char *argv[]) {

    int i, err;

    rf_read = false;
    rf_check = false;
    rf_write0 = false;


    //pthread_t setPool[iSet_SHARED];
    pthread_t t1, t2, t3, t4;
    //pthread_t checkPool[iCheck_SHARED];

    /*
       for (i = 0; i < iSet_SHARED; i++) {
       if (0 != (err = pthread_create(&setPool[i], NULL, &setThread, NULL))) {
       fprintf(stderr, "Error [%d] found creating set thread.\n", err);
       exit(-1);
       }
       }
     */
    pthread_create(&t1, NULL, &setThread1, NULL);
    pthread_create(&t2, NULL, &setThread2, NULL);

    /*
       for (i = 0; i < iCheck_SHARED; i++) {
       if (0 != (err = pthread_create(&checkPool[i], NULL, &checkThread,
       NULL))) {
       fprintf(stderr, "Error [%d] found creating check thread.\n", err);
       exit(-1);
       }
       }
     */
    pthread_create(&t3, NULL, &checkThread1, NULL);
    pthread_create(&t4, NULL, &checkThread2, NULL);

    /*
       for (i = 0; i < iSet_SHARED; i++) {
       if (0 != (err = pthread_join(setPool[i], NULL))) {
       fprintf(stderr, "pthread join error: %d\n", err);
       exit(-1);
       }
       }
     */
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    /*
       for (i = 0; i < iCheck_SHARED; i++) {
       if (0 != (err = pthread_join(checkPool[i], NULL))) {
       fprintf(stderr, "pthread join error: %d\n", err);
       exit(-1);
       }
       }
     */
    pthread_join(t3, NULL);
    pthread_join(t4, NULL);

    assert(!rf_check);

    return 0;
}

void *setThread1(void *param) {

    a_SHARED = 1;

    pthread_mutex_lock(&sas0);
    int tmp = order1_SHARED;
    rf_read = true;
    if (rf_write0 )
        rf_check = true;
    pthread_mutex_unlock(&sas0);


    tmp = order2_SHARED;
    tmp = order3_SHARED;

    nop1();
    cond0_bool = 1;
    nop1();

    nop1();
    cond1_bool = 1;
    nop1();

    nop1();
    cond2_bool = 1;
    nop1();

    b_SHARED = -1;
    nop1();

    nop1();

    nop1();


    return NULL;
}

void *setThread2(void *param) {
    nop1();
    if (!cond0_bool) {
        nop1();
    }
    nop1();

    pthread_mutex_lock(&sas0);
    if (!rf_read)
        rf_write0 = true;
    order1_SHARED = 1;
    pthread_mutex_unlock(&sas0);


    a_SHARED = 1;
    b_SHARED = -1;

    return NULL;
}

void *checkThread1(void *param) {
    //assert(((a == 0 && b == 0) || (a == 1 && b == -1)));
    nop1();
    if (!cond1_bool) {
        nop1();
    }
    nop1();

    order2_SHARED = 1;

    if (! ((a_SHARED == 0 && b_SHARED == 0) || (a_SHARED == 1 && b_SHARED == -1))) {
        //assert(0);
    }

    return NULL;
}

void *checkThread2(void *param) {
    //assert(((a == 0 && b == 0) || (a == 1 && b == -1)));
    nop1();
    if (!cond2_bool) {
        nop1();
    }
    nop1();

    order3_SHARED = 1;

    if (! ((a_SHARED == 0 && b_SHARED == 0) || (a_SHARED == 1 && b_SHARED == -1))) {
        //assert(0);
    }

    return NULL;
}
