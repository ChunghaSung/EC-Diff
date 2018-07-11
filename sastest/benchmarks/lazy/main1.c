//extern void __VERIFIER_error() __attribute__ ((__noreturn__));

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


pthread_cond_t cond0 = PTHREAD_COND_INITIALIZER;
int cond0_bool = 0;
pthread_mutex_t mutex0 = PTHREAD_MUTEX_INITIALIZER;

pthread_mutex_t  mutex;

int data_SHARED = 0;

void nop1() {}

void *thread1(void *arg)
{
    pthread_mutex_lock(&mutex0);
    if (!cond0_bool) {
        pthread_cond_wait(&cond0, &mutex0);
    }
    pthread_mutex_unlock(&mutex0);

    pthread_mutex_lock(&mutex);

    pthread_mutex_lock(&sas0);
    int tmp = data_SHARED;
    rf_read1 = true;
    if (rf_write01 && !rf_write11 && !rf_write21)
        rf_check1 = true;
    pthread_mutex_unlock(&sas0);


    tmp = tmp + 1;

    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    data_SHARED = tmp;
    if (!rf_read1 && rf_write01)
        rf_write11 = true;
    if (!rf_read2 && rf_write02)
        rf_write12 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);


    pthread_mutex_unlock(&mutex);
}


void *thread2(void *arg)
{
    pthread_mutex_lock(&mutex);

    pthread_mutex_lock(&sas1);
    int tmp = data_SHARED;
    rf_read2 = true;
    if (rf_write02 && !rf_write12 && !rf_write12)
        rf_check2 = true;
    pthread_mutex_unlock(&sas1);


    tmp = tmp + 2;

    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    data_SHARED = tmp;
    if (!rf_read1 && rf_write01)
        rf_write21 = true;
    if (!rf_read2 && rf_write02)
        rf_write22 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);


    pthread_mutex_unlock(&mutex);
}



void *thread3(void *arg)
{
    pthread_mutex_lock(&mutex0);
    cond0_bool = 1;
    pthread_cond_signal(&cond0);

    pthread_mutex_lock(&mutex);
    pthread_mutex_unlock(&mutex0);

    int tmp = data_SHARED;
    if (tmp >= 3){
        //assert(0);
    }
    pthread_mutex_unlock(&mutex);    
}


int main()
{
    pthread_mutex_init(&mutex, 0);

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
    data_SHARED = 0;
    if (!rf_read1)
        rf_write01 = true;
    if (!rf_read2)
        rf_write02 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);


    pthread_t t1, t2, t3;

    pthread_create(&t1, 0, thread1, 0);
    pthread_create(&t2, 0, thread2, 0);
    pthread_create(&t3, 0, thread3, 0);

    pthread_join(t1, 0);
    pthread_join(t2, 0);
    pthread_join(t3, 0);

    if (rf_check1 && rf_check2)
        assert(0);


    return 0;
}
