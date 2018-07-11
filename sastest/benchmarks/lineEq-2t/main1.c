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



pthread_mutex_t mutex0;

// Coefficients of the equation
int c0_SHARED;

// Input tuple
int var0_SHARED;

// intermediate products
int p0_SHARED;

int result_SHARED;

void nop1() {}

void *thread1(void *args) {

    int local1 = 0;

    pthread_mutex_lock(&mutex0);

    pthread_mutex_lock(&sas0);
    local1 = p0_SHARED;
    rf_read1 = true;
    if (rf_write01 && !rf_write11 && !rf_write21)
        rf_check1 = true;
    pthread_mutex_unlock(&sas0);


    if (p0_SHARED==0) { 
        local1 = var0_SHARED * c0_SHARED; 
    }

    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    p0_SHARED = local1;
    if (!rf_read1 && rf_write01)
        rf_write11 = true;
    if (!rf_read2 && rf_write02)
        rf_write12 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);


    pthread_mutex_unlock(&mutex0);

    int tmp1 = p0_SHARED;

    result_SHARED = tmp1;

    return NULL;
}

void *thread2(void *args) {

    int local2 = 0;

    pthread_mutex_lock(&mutex0);

    pthread_mutex_lock(&sas1);
    local2 = p0_SHARED;
    rf_read2 = true;
    if (rf_write02 && !rf_write12 && !rf_write12)
        rf_check2 = true;
    pthread_mutex_unlock(&sas1);


    if(p0_SHARED == 0) { 
        local2 = var0_SHARED * c0_SHARED; 
    }

    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    p0_SHARED = local2;	
    if (!rf_read1 && rf_write01)
        rf_write21 = true;
    if (!rf_read2 && rf_write02)
        rf_write22 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);



    pthread_mutex_unlock(&mutex0);


    int tmp2 = p0_SHARED;

    result_SHARED = tmp2;

    return NULL;
}

void main() {

    var0_SHARED = 2;

    c0_SHARED = 4;


    result_SHARED = 0;

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
    p0_SHARED = 0;
    if (!rf_read1)
        rf_write01 = true;
    if (!rf_read2)
        rf_write02 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);



    pthread_t t1;
    pthread_t t2;

    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    /*
    if (result_SHARED != p0_SHARED) {
        assert(0);
    }
    */

    if (rf_check1 && rf_check2)
        assert(0);


    return;
}
