// Author: 
// Patch provided by ISSTA repair paper.
// Still there was a race, I added one more lock pair to keep serialization.

#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <assert.h>

#include <unistd.h>

#define UINT_TYPE uint8_t

pthread_cond_t cond0 = PTHREAD_COND_INITIALIZER;
int cond0_bool = 0;
pthread_mutex_t mutex0 = PTHREAD_MUTEX_INITIALIZER;

pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;

/// Typedef for the AttributeList structure. It simply only contains a reference
// count and some data. 

// Global AttributeList that is raced after

// reference counted data structure
UINT_TYPE ref_count_g_SHARED;
char data_g_SHARED;
bool destroyed_t1_g_SHARED;
bool destroyed_t2_g_SHARED;

void *t1_main(void *args);
void *t2_main(void *args);

void nop1() {}


// Begin thread one functions
void *t1_main(void *args) {
    // Increment the reference count to refelect the strucutre being used
    //inc_att_list_ref_count_t1();
    nop1();
    if (!cond0_bool) {
        nop1();
    }
    nop1();

    nop1();

    ref_count_g_SHARED++;

    // Modify the data section
    data_g_SHARED = 'a';

    // We're done using the structure so decrement the ref_count
    //dec_att_list_ref_count_t1();
    ref_count_g_SHARED--;

    if (ref_count_g_SHARED == 0) {
        //att_list_destroy_t1();
        destroyed_t1_g_SHARED = true;
    }

    nop1();

    return NULL;
}
// End thread one functions

// Begin thread two functions
void *t2_main(void *args) {
    // Increment the reference count to refelect the strucutre being used
    //inc_att_list_ref_count_t2();

    nop1();

    ref_count_g_SHARED++;

    // Modify the data section
    data_g_SHARED = 'a';

    // We're done using the structure so decrement the ref_count
    //dec_att_list_ref_count_t2();
    ref_count_g_SHARED--;

    if (ref_count_g_SHARED == 0) {
        destroyed_t2_g_SHARED = true;
    }

    nop1();

    return NULL;
}


// End thread two functions
/// Initializes the global AttributeList att_list and then creates two threads
// in t_main()
//
// \return Return's 0 upon completion
int main(void) {
    pthread_t t1;
    pthread_t t2;

    //att_list_init();
    data_g_SHARED = 'x';
    ref_count_g_SHARED = 0;
    destroyed_t1_g_SHARED = false;

    pthread_create(&t1, NULL, t1_main, NULL);
    pthread_create(&t2, NULL, t2_main, NULL);

    //pthread_join(t1, NULL);
    //pthread_join(t2, NULL);

    nop1();
    cond0_bool = 1;
    nop1();

    if (destroyed_t1_g_SHARED && destroyed_t2_g_SHARED) assert(0);
    nop1();


    return 0;
}

