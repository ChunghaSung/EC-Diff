#include <pthread.h>
#include <stdio.h>
#include <assert.h>

int cond0_bool = 0;

pthread_cond_t cond0;
pthread_mutex_t mutex0;
pthread_mutex_t m;


int x_SHARED, y_SHARED, z_SHARED, balance_SHARED;
_Bool deposit_done_SHARED=0, withdraw_done_SHARED=0;

void nop1() {}

void *deposit(void *arg) 
{
    nop1();
    if (!cond0_bool) {
        nop1();
    }
    nop1();

    balance_SHARED = balance_SHARED + y_SHARED;
    deposit_done_SHARED=1;

    return NULL;
}

void *withdraw(void *arg) 
{
    balance_SHARED = balance_SHARED - z_SHARED;
    withdraw_done_SHARED=1;

    return NULL;
}

void *check_result(void *arg) 
{
    pthread_mutex_lock(&m);
    nop1();
    if (deposit_done_SHARED && withdraw_done_SHARED && (balance_SHARED != (x_SHARED - y_SHARED) - z_SHARED)){
        assert(0);
    }
    cond0_bool = 1;
    nop1();

    nop1();

    pthread_mutex_unlock(&m);

    return NULL;
}

int main() 
{
    pthread_t t1, t2, t3;

    //pthread_mutex_init(&m, 0);

    x_SHARED = 1;
    y_SHARED = 2;
    z_SHARED = 4;
    balance_SHARED = x_SHARED;

    pthread_create(&t3, 0, check_result, 0);
    pthread_create(&t1, 0, deposit, 0);
    pthread_create(&t2, 0, withdraw, 0);

    pthread_join(t3, NULL);
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    if (balance_SHARED != x_SHARED + y_SHARED - z_SHARED) {
        assert(0);
    }

    return 0;
}
