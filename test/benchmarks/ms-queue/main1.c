#include <stdlib.h>
#include <pthread.h>
#include <assert.h>
#include <stdint.h>

#define SIZE_TYPE int8_t
#define VALUE_TYPE char
#define MAX_SIZE 5

pthread_mutex_t mutex0;

// Queue
SIZE_TYPE head_SHARED;
SIZE_TYPE tail_SHARED;
SIZE_TYPE size_SHARED;
VALUE_TYPE items_SHARED[MAX_SIZE];
pthread_mutex_t head_SHAREDLock;
//pthread_mutex_t tail_SHAREDLock;
// =======

void nop1() {}


void *t1_main(void *arg) {
    //Queue_Enqueue_t1(1);

    tail_SHARED += 1;

    nop1();

    size_SHARED++;

    nop1();

    items_SHARED[tail_SHARED] = 1;

    return NULL;
}

void *t2_main(void *arg) {
    //Queue_Enqueue_t2(2);

    tail_SHARED += 1;

    nop1();

    size_SHARED++;

    nop1();

    items_SHARED[tail_SHARED] = 2;

    return NULL;
}

int main() {
    pthread_t t1;
    pthread_t t2;

    //Queue_Init();
    head_SHARED = 0;
    tail_SHARED = 0;
    size_SHARED = 0;
    //pthread_mutex_init(&head_SHAREDLock, NULL);

    pthread_create(&t1, NULL, t1_main, NULL);
    pthread_create(&t2, NULL, t2_main, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    VALUE_TYPE v1;
    VALUE_TYPE v2;

    //int r1 = Queue_Dequeue();
    int r1;
    pthread_mutex_lock(&head_SHAREDLock);

    SIZE_TYPE h = head_SHARED;

    if (size_SHARED == 0) {
        pthread_mutex_unlock(&head_SHAREDLock);
        r1 = -1; // queue was empty
    } else {
        r1 = 0;
        head_SHARED += 1;
        size_SHARED--;
        pthread_mutex_unlock(&head_SHAREDLock);
    }


    //int r2 = Queue_Dequeue();
    int r2;
    pthread_mutex_lock(&head_SHAREDLock);

    h = head_SHARED;

    if (size_SHARED == 0) {
        pthread_mutex_unlock(&head_SHAREDLock);
        r2 = -1; // queue was empty
    } else {
        r2 = 0;
        head_SHARED += 1;
        size_SHARED--;
        pthread_mutex_unlock(&head_SHAREDLock);
    }

    if (r1 == -1) {
        assert(0);
    }
    if (r2 == -1) {
        assert(0);
    }

    return 0;
}
