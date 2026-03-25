#include <stdlib.h>
#include <pthread.h>
#include <assert.h>

void nop1(){}

pthread_mutex_t mutex0;

int count_SHARED;

void *t1_main(void *arg) {
    pthread_mutex_lock(&mutex0);
    int tmp = count_SHARED;
    tmp += 1;
    count_SHARED = tmp;
    pthread_mutex_unlock(&mutex0);

    return NULL;
}

void *t2_main(void *arg) {
    pthread_mutex_lock(&mutex0);
    int tmp = count_SHARED;
    tmp += 1;
    count_SHARED = tmp;
    pthread_mutex_unlock(&mutex0);

    return NULL;
}

int main() {
    count_SHARED = 0;
    pthread_t t1;
    pthread_t t2;

    pthread_create(&t1, NULL, t1_main, NULL);
    pthread_create(&t2, NULL, t2_main, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    if (count_SHARED != 2) {
        assert(0);
    }

    return 0;
}
