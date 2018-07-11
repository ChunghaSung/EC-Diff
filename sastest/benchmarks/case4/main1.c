// Author: 
// Date: Apr 11 2018
// this patch is when we need to add pthread_join 
// to force the order of variables accesses between threads


#include <pthread.h>
#include <stdbool.h>

int x_SHARED;
int t_SHARED;

pthread_mutex_t a;
pthread_mutex_t b;
pthread_cond_t cond;
bool cond_bool = false;

// sas variables
pthread_mutex_t sas0;
bool rf_check;
bool rf_read1;
bool rf_read2;
bool rf_write0;
bool rf_write1;


// when we want to patch pthread_join,
// we need to add an argument for nop1 function
// The reason is the instruction of pthread_join 
// takes a thread paramter for function.
// So, there will be one more load instruction.

void* thread1(void *arg);
void* thread2(void *arg);

void nop1() {

}

void* thread1(void *arg)
{
    int tmp = 1; // dummy

    pthread_mutex_lock(&sas0);
    x_SHARED = 1;
    if (!rf_read1 && !rf_read2)
        rf_write0 = true;
    pthread_mutex_unlock(&sas0);

    t_SHARED = 0;

    pthread_t t2;

    pthread_create(&t2, NULL, thread2, NULL);

    pthread_mutex_lock(&a);

    tmp = 1; // dummy


    pthread_mutex_lock(&sas0);
    t_SHARED = x_SHARED;
    rf_read2 = true;
    if (rf_write0 && !rf_write1 && rf_read1)
        rf_check = true;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_unlock(&a);

    return (NULL);
}

void* thread2(void *arg)
{
    
    pthread_mutex_lock(&a);

    pthread_mutex_lock(&sas0);
    t_SHARED = x_SHARED;
    if (rf_write0 && !rf_write1 && !rf_read2)
        rf_read1 = true;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas0);
    x_SHARED = 2;
    if (rf_write0)
        rf_write1 = true;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_unlock(&a);

    return (NULL);
}

int main()
{
    rf_check = false;
    rf_read1 = false;
    rf_read2 = false;
    rf_write0 = false;
    rf_write1 = false;

    pthread_t t1;

    pthread_create(&t1, NULL, thread1, NULL);


    assert(!rf_check);

    return 0;
}
