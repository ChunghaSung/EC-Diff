#include <pthread.h>
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
bool rf_write4;
bool rf_write5;
bool rf_write6;
bool rf_write7;
bool rf_write8;
bool rf_write9;
bool rf_write10;
bool rf_write11;
bool rf_write12;
bool rf_write13;


int i_SHARED=1, j_SHARED=1;

pthread_cond_t cond0 = PTHREAD_COND_INITIALIZER;
int cond0_bool = 0;
pthread_mutex_t mutex0 = PTHREAD_MUTEX_INITIALIZER;

// Manually unrolled
#define NUM 6

void nop1() {}

void *t1(void* arg)
{
    nop1();
    if (!cond0_bool) {
        nop1();
    }
    nop1();

    int tmp;

    tmp = i_SHARED + j_SHARED;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write1 = true;
    i_SHARED = tmp;
    pthread_mutex_unlock(&sas0);

    tmp = i_SHARED + j_SHARED;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write2 = true;
    i_SHARED = tmp;
    pthread_mutex_unlock(&sas0);

    tmp = i_SHARED + j_SHARED;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write3 = true;
    i_SHARED = tmp;
    pthread_mutex_unlock(&sas0);

    tmp = i_SHARED + j_SHARED;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write4 = true;
    i_SHARED = tmp;
    pthread_mutex_unlock(&sas0);

    tmp = i_SHARED + j_SHARED;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write5 = true;
    i_SHARED = tmp;
    pthread_mutex_unlock(&sas0);

    tmp = i_SHARED + j_SHARED;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write6 = true;
    i_SHARED = tmp;
    pthread_mutex_unlock(&sas0);

    tmp = i_SHARED + j_SHARED;

    pthread_mutex_lock(&sas0);
    if (!rf_read)
        rf_write0 = true;
    i_SHARED = tmp;
    pthread_mutex_unlock(&sas0);

    pthread_exit(NULL);
}

void *t2(void* arg)
{
    int tmp;

    tmp = i_SHARED + j_SHARED;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write7 = true;
    i_SHARED = tmp;
    pthread_mutex_unlock(&sas0);

    tmp = i_SHARED + j_SHARED;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write8 = true;
    i_SHARED = tmp;
    pthread_mutex_unlock(&sas0);

    tmp = i_SHARED + j_SHARED;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write9 = true;
    i_SHARED = tmp;
    pthread_mutex_unlock(&sas0);

    tmp = i_SHARED + j_SHARED;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write10 = true;
    i_SHARED = tmp;
    pthread_mutex_unlock(&sas0);

    tmp = i_SHARED + j_SHARED;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write11 = true;
    i_SHARED = tmp;
    pthread_mutex_unlock(&sas0);

    tmp = i_SHARED + j_SHARED;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write12 = true;
    i_SHARED = tmp;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas0);
    tmp = i_SHARED + j_SHARED;
    rf_read = true;
    if (rf_write0 && !rf_write1 && !rf_write2 && !rf_write3 && !rf_write4 && !rf_write5 && !rf_write6 && !rf_write7 && !rf_write8 && !rf_write9 && !rf_write10 && !rf_write11 && !rf_write12 && !rf_write13)
        rf_check = true;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write13 = true;
    i_SHARED = tmp;
    pthread_mutex_unlock(&sas0);

    pthread_exit(NULL);
}

int main(int argc, char **argv)
{
    pthread_t id1, id2;

    rf_read = false;
    rf_check = false;
    rf_write0 = false;
    rf_write1 = false;
    rf_write2 = false;
    rf_write3 = false;
    rf_write4 = false;
    rf_write5 = false;
    rf_write6 = false;
    rf_write7 = false;
    rf_write8 = false;
    rf_write9 = false;
    rf_write10 = false;
    rf_write11 = false;
    rf_write12 = false;
    rf_write13 = false;


    pthread_create(&id1, NULL, t1, NULL);
    pthread_create(&id2, NULL, t2, NULL);

    pthread_join(id2, NULL);

    pthread_mutex_lock(&mutex0);
    cond0_bool = 1;
    pthread_cond_signal(&cond0);

    if (i_SHARED >= 377 || j_SHARED >= 377) {
        //assert(0);
    }
    pthread_mutex_unlock(&mutex0);

    assert(!rf_check);

    return 0;
}
