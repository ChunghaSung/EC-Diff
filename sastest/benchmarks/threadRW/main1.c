/* Testcase from Threader's distribution. For details see:
http://www.model.in.tum.de/~popeea/research/threader

This file is adapted from the example introduced in the paper:
Thread-Modular Verification for Shared-Memory Programs 
by Cormac Flanagan, Stephen Freund, Shaz Qadeer.
 */

#include <pthread.h>
#include <assert.h>

// sas vars
#include <stdbool.h>
pthread_mutex_t sas0;
bool rf_check;
bool rf_read;
bool rf_write0;


pthread_cond_t cond1 = PTHREAD_COND_INITIALIZER;
int cond1_bool = 0;
pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond0 = PTHREAD_COND_INITIALIZER;
int cond0_bool = 0;
pthread_mutex_t mutex0 = PTHREAD_MUTEX_INITIALIZER;

// special variables for checking orders
int order1_SHARED = 0;
int order2_SHARED = 0;

//#define assert(e) if (!(e)) ERROR: goto ERROR;
int w_SHARED=0, r_SHARED=0, x_SHARED, y_SHARED;

void nop1() {}

void *writer1(void *arg) { //writer

    pthread_mutex_lock(&sas0);
    int tmp = order1_SHARED;
    rf_read = true;
    if (rf_write0)
        rf_check = true;
    pthread_mutex_unlock(&sas0);



    tmp = order2_SHARED;

    //take_write_lock();  
    // inlined take_write_lock()
    w_SHARED = 1;
    r_SHARED = 2;
    nop1();
    cond0_bool = 1;
    nop1();

    nop1();
    cond1_bool = 1;
    nop1();

    nop1();

    nop1();

    // end inline: take_write_lock()
    x_SHARED = 3;
    w_SHARED = 0;
    return NULL;
}

void *writer2(void *arg) { //writer
    //take_write_lock();  
    // inlined take_write_lock()
    w_SHARED = 1;
    // end inline: take_write_lock()
    x_SHARED = 3;
    w_SHARED = 0;
    return NULL;
}

void *reader1(void *arg) { //reader
    int l;

    //take_read_lock();
    // inlined: take_read_lock()
    int tmp = r_SHARED;
    tmp = tmp + 1;
    r_SHARED = tmp;
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


    // end inline: take_read_lock()

    l = x_SHARED;
    y_SHARED = l;
    
    if (y_SHARED != x_SHARED) {
        assert(0);
    }

    l = r_SHARED-1;
    r_SHARED = l;
    //y = x;
    //if (y != x) {
    //assert(0);
    //}
    return NULL;
}

void *reader2(void *arg) { //reader

    int l;

    //take_read_lock();
    // inlined: take_read_lock()
    int tmp = r_SHARED;
    tmp = tmp + 1;
    r_SHARED = tmp;
    nop1();
    if (!cond1_bool) {
        nop1();
    }
    nop1();

    order2_SHARED = 2;

    // end inline: take_read_lock()

    l = x_SHARED;
    y_SHARED = l;

    if (y_SHARED != x_SHARED) {
        assert(0);
    }

    l = r_SHARED-1;
    r_SHARED = l;
    //y = x;
    //if (y != x) {
    //assert(0);
    //}
    return NULL;
}

int main() {
    pthread_t t1, t2, t3, t4;

    rf_read = false;
    rf_check = false;
    rf_write0 = false;


    pthread_create(&t1, 0, writer1, 0);
    pthread_create(&t2, 0, reader1, 0);
    pthread_create(&t3, 0, writer2, 0);
    pthread_create(&t4, 0, reader2, 0);

    //  pthread_join(t1, 0);
    //  pthread_join(t2, 0);
    //  pthread_join(t3, 0);
    //  pthread_join(t4, 0);

    assert(!rf_check);

    return 0;
}
