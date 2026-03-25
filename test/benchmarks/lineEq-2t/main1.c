#include <pthread.h>
#include <assert.h>


pthread_mutex_t mutex0;

// Coefficients of the equation
int c0_SHARED;

// Input tuple
int var0_SHARED;

// intermediate products
int p0_SHARED;

int result_SHARED;

void nop1() {}

void *thread1(void *args) {

    int local1 = 0;

    pthread_mutex_lock(&mutex0);

    local1 = p0_SHARED;
    if(p0_SHARED==0) { 
        local1 = var0_SHARED * c0_SHARED; 
    }

    p0_SHARED = local1;

    pthread_mutex_unlock(&mutex0);

    int tmp1 = p0_SHARED;

    result_SHARED = tmp1;

    return NULL;
}

void *thread2(void *args) {

    int local2 = 0;

    pthread_mutex_lock(&mutex0);

    local2 = p0_SHARED;

    if(p0_SHARED == 0) { 
        local2 = var0_SHARED * c0_SHARED; 
    }

    p0_SHARED = local2;	

    pthread_mutex_unlock(&mutex0);


    int tmp2 = p0_SHARED;

    result_SHARED = tmp2;

    return NULL;
}

void main() {

    var0_SHARED = 2;

    c0_SHARED = 4;

    p0_SHARED = 0;

    result_SHARED = 0;

    pthread_t t1;
    pthread_t t2;

    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    if (result_SHARED != p0_SHARED) {
        assert(0);
    }

    return;
}
