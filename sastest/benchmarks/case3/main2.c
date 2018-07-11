// Chungha Sung (chunghas@usc.edu)
// Date: Apr 11 2018
// this patch is when we need to add pthread_join 
// to force the order of variables accesses between threads

// This example has a a_SHARED order from main and two threads.
// The patch will have less behavior by forcing the order from threads to a_SHARED access in main thread

/*
      main            t1               t2
                a_SHARED = 1;     a_SHARED = 1;
                tmp = a_SHARED;   tmp = a_SHARED;
                a_SHARED = 1;     a_SHARED = 1;

   (join t1)
   (join t2)
   a_SHARED = 1;

   If we have join statements ``a_SHARED = 1`` in main 
   cannot happen any statements in t1 and t2
*/

#include <pthread.h>

int a_SHARED;

// when we want to patch pthread_join,
// we need to add an argument for nop1 function
// The reason is the instruction of pthread_join 
// takes a thread paramter for function.
// So, there will be one more load instruction.

// sas vars
#include <stdbool.h>
pthread_mutex_t sas0;
bool rf_check;
bool rf_read;
bool rf_write1;
bool rf_write2;
bool rf_write3;
bool rf_write4;
bool rf_write5;


void nop1(pthread_t a) {

}

void* thread1(void *arg)
{
    pthread_mutex_lock(&sas0);
    a_SHARED = 1;
    if (rf_write1 && !rf_read)
        rf_write2 = true;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas0);
    int tmp = a_SHARED;
    rf_read = true;
    if (rf_write1 && !rf_write2 && !rf_write3 && !rf_write4 && !rf_write5)
        rf_check = true;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas0);
    a_SHARED = 1;
    if (rf_write1 && !rf_read)
        rf_write3 = true;
    pthread_mutex_unlock(&sas0);

    return (NULL);
}

void* thread2(void *arg)
{
    pthread_mutex_lock(&sas0);
    a_SHARED = 1;
    if (rf_write1 && !rf_read)
        rf_write4 = true;
    pthread_mutex_unlock(&sas0);

    int tmp = a_SHARED;

    pthread_mutex_lock(&sas0);
    a_SHARED = 1;
    if (rf_write1 && !rf_read)
        rf_write5 = true;
    pthread_mutex_unlock(&sas0);

    return (NULL);
}

int main()
{
    pthread_t t1;
    pthread_t t2;

    rf_write1 = false;
    rf_write2 = false;
    rf_write3 = false;
    rf_write4 = false;
    rf_write5 = false;
    rf_check = false;
    rf_read = false;


    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    pthread_mutex_lock(&sas0);
    a_SHARED = 1;
    if (!rf_read) 
        rf_write1 = true;
    pthread_mutex_unlock(&sas0);

    assert(!rf_check);

    return 0;
}
