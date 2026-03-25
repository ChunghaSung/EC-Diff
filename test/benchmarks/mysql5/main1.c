#include <pthread.h>
#include <assert.h>

pthread_mutex_t mutex0;

int x_SHARED;
int y_SHARED;

void *Thrd1(void* i) {

    pthread_mutex_lock(&mutex0);

    // added read part
    int tmp = x_SHARED;
    tmp = y_SHARED;

    x_SHARED = 0;
    y_SHARED = 0;

    pthread_mutex_unlock(&mutex0);

    return 0;
}

void *Thrd2(void* i) {

    pthread_mutex_lock(&mutex0);

    // added read part
    int tmp = x_SHARED;
    tmp = y_SHARED;

    x_SHARED = 1;
    y_SHARED = 1;

    pthread_mutex_unlock(&mutex0);

    return 0; 
}

int main(int argc, char **argv) {

    x_SHARED = 4;
    y_SHARED = 4;

    pthread_t thread1, thread2;

    pthread_create(&thread1, 0, Thrd1, 0);
    pthread_create(&thread2, 0, Thrd2, 0);

    pthread_join(thread1, 0);
    pthread_join(thread2, 0);
    
    if (x_SHARED != y_SHARED) {
        assert(0);
    }

    return 0;
}
