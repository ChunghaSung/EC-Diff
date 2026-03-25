// Author: 
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

void nop1(pthread_t a) {

}

void* thread1(void *arg)
{
    a_SHARED = 1;
    int tmp = a_SHARED;
    a_SHARED = 1;
    return (NULL);
}

void* thread2(void *arg)
{
    a_SHARED = 1;
    int tmp = a_SHARED;
    a_SHARED = 1;
    return (NULL);
}

int main()
{
    pthread_t t1;
    pthread_t t2;

    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    a_SHARED = 1;

    return 0;
}
