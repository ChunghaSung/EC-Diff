//extern void __VERIFIER_error() __attribute__ ((__noreturn__));

#include <pthread.h>
#include <assert.h>

pthread_cond_t cond0 = PTHREAD_COND_INITIALIZER;
int cond0_bool = 0;
pthread_mutex_t mutex0 = PTHREAD_MUTEX_INITIALIZER;

pthread_mutex_t  mutex;

int data_SHARED = 0;

void nop1() {}

void *thread1(void *arg)
{
    nop1();
    if (!cond0_bool) {
        nop1();
    }
    nop1();

    nop1();
    int tmp = data_SHARED;
    tmp = tmp + 1;
    data_SHARED = tmp;
    nop1();
}


void *thread2(void *arg)
{
    nop1();
    int tmp = data_SHARED;
    tmp = tmp + 2;
    data_SHARED = tmp;
    nop1();
}



void *thread3(void *arg)
{
    nop1();
    cond0_bool = 1;
    nop1();

    nop1();
    nop1();

    if (data_SHARED >= 3){
        assert(0);
    }
    nop1();
}


int main()
{
    pthread_mutex_init(&mutex, 0);

    data_SHARED = 0;

    pthread_t t1, t2, t3;

    pthread_create(&t1, 0, thread1, 0);
    pthread_create(&t2, 0, thread2, 0);
    pthread_create(&t3, 0, thread3, 0);

    pthread_join(t1, 0);
    pthread_join(t2, 0);
    pthread_join(t3, 0);

    return 0;
}
