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

void nop1(){}


pthread_mutex_t mutex0;

int x_SHARED;
int y_SHARED;

void *Thrd1(void* i) {

    pthread_mutex_lock(&mutex0);

    // added read part
    pthread_mutex_lock(&sas0);
    int tmp = x_SHARED;
    rf_read1 = true;
    if (rf_write01 && !rf_write11 && !rf_write21)
        rf_check1 = true;
    pthread_mutex_unlock(&sas0);



    tmp = y_SHARED;

    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    x_SHARED = 0;
    if (!rf_read1 && rf_write01)
        rf_write11 = true;
    if (!rf_read2 && rf_write02)
        rf_write12 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);



    y_SHARED = 0;

    pthread_mutex_unlock(&mutex0);

    return 0;
}

void *Thrd2(void* i) {

    pthread_mutex_lock(&mutex0);

    // added read part
    pthread_mutex_lock(&sas1);
    int tmp = x_SHARED;
    rf_read2 = true;
    if (rf_write02 && !rf_write12 && !rf_write12)
        rf_check2 = true;
    pthread_mutex_unlock(&sas1);



    tmp = y_SHARED;

    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    x_SHARED = 1;
    if (!rf_read1 && rf_write01)
        rf_write21 = true;
    if (!rf_read2 && rf_write02)
        rf_write22 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);



    y_SHARED = 1;

    pthread_mutex_unlock(&mutex0);

    return 0; 
}

int main(int argc, char **argv) {

    y_SHARED = 4;

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
    x_SHARED = 4;
    if (!rf_read1)
        rf_write01 = true;
    if (!rf_read2)
        rf_write02 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);


    pthread_t thread1, thread2;

    pthread_create(&thread1, 0, Thrd1, 0);
    pthread_create(&thread2, 0, Thrd2, 0);

    pthread_join(thread1, 0);
    pthread_join(thread2, 0);
    
    if (x_SHARED != y_SHARED) {
        //assert(0);
    }

    if (rf_check1 && rf_check2)
        assert(0);


    return 0;
}
