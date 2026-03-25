// Author: 
// Date: Apr 11 2018
// this patch is when we need to add pthread_join 
// to force the order of variables accesses between threads

// This example needs rank 2 to be solved.
// Because of a lock pair, read-from from 1 to 2 and from 1 to 3 cannot happen toghether.
// Specifically, once 1-3 happens 1-2 cannot happen.
// However, once 1-2 happens, 1-3 can happen.
// Therefore, for program after a change (after removing lock pair), new program have a trace 
// for both orders (1-2, 1-3) & (1-3, 1-2) of read-from edges,
// but original program only has (1-2, 1-3) and (1-3) only.


/*
      main            t1               t2
   1:x = 1;
                   cond_signal      cond_wait
                   lock(a);         lock(a);
                   ...              3: x = x + 2;
                   unlock(a);       unlock(a);
                   2: t = x + 1;

*/

#include <pthread.h>
#include <stdbool.h>

int x_SHARED;
int t_SHARED;

pthread_mutex_t a;
pthread_mutex_t b;
pthread_cond_t cond;
bool cond_bool = false;

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

    x_SHARED = 1;

    t_SHARED = 0;

    pthread_t t2;

    pthread_create(&t2, NULL, thread2, NULL);

    nop1();

    tmp = 1; // dummy

    t_SHARED = x_SHARED;

    nop1();

    return (NULL);
}

void* thread2(void *arg)
{
    
    nop1();

    t_SHARED = x_SHARED;

    x_SHARED = 2;

    nop1();

    return (NULL);
}

int main()
{
    pthread_t t1;

    pthread_create(&t1, NULL, thread1, NULL);

    return 0;
}
