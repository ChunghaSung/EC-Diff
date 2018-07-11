#include <stdlib.h>
#include <pthread.h>
#include <assert.h>

// sas vars
#include <stdbool.h>
pthread_mutex_t sas0;
pthread_mutex_t sas1;
bool rf_write11;
bool rf_write12;
bool rf_write21;
bool rf_write22;
bool rf_write31;
bool rf_write32;
bool rf_read1;
bool rf_read2;
bool rf_check1;
bool rf_check2;


void nop1(){}

pthread_mutex_t mutex0;

int count_SHARED;

void *t1_main(void *arg) {
    nop1();

    pthread_mutex_lock(&sas0);
    int tmp = count_SHARED;
    rf_read1 = true;
    if (rf_write11 & !rf_write21 & !rf_write31)
        rf_check1 = true;
    pthread_mutex_unlock(&sas0);
    tmp += 1;

    pthread_mutex_lock(&sas0);
    pthread_mutex_lock(&sas1);
    count_SHARED = tmp;
    if (!rf_read1 && rf_write11)
        rf_write21 = true;
    if (!rf_read2 && rf_write12)
        rf_write22 = true;
    pthread_mutex_unlock(&sas1);
    pthread_mutex_unlock(&sas0);


    nop1();

    return NULL;
}

void *t2_main(void *arg) {
    nop1();

    pthread_mutex_lock(&sas1);
    int tmp = count_SHARED;
    rf_read2 = true;
    if (rf_write12 & !rf_write22 & !rf_write32)
        rf_check2 = true;
    pthread_mutex_unlock(&sas1);


    tmp += 1;

    pthread_mutex_lock(&sas0);
    pthread_mutex_lock(&sas1);
    count_SHARED = tmp;
    if (!rf_read1 && rf_write11)
        rf_write31 = true;

    if (!rf_read2 && rf_write12)
        rf_write32 = true;
    pthread_mutex_unlock(&sas1);
    pthread_mutex_unlock(&sas0);

    nop1();

    return NULL;
}

int main() {

    rf_check1 = false;
    rf_check2 = false;
    rf_read1 = false;
    rf_read2 = false;
    rf_write11 = false;
    rf_write12 = false;
    rf_write21 = false;
    rf_write22 = false;
    rf_write31 = false;
    rf_write32 = false;

    pthread_mutex_lock(&sas0);
    pthread_mutex_lock(&sas1);
    count_SHARED = 0;
    if (!rf_read1)
        rf_write11 = true;
    if (!rf_read2)
        rf_write12 = true;
    pthread_mutex_unlock(&sas1);
    pthread_mutex_unlock(&sas0);


    pthread_t t1;
    pthread_t t2;

    pthread_create(&t1, NULL, t1_main, NULL);
    pthread_create(&t2, NULL, t2_main, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    if (count_SHARED != 2) {
        //assert(0);
    }

    if (rf_check1 && rf_check2)
        assert(0);

    return 0;
}
