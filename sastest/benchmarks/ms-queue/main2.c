#include <stdlib.h>
#include <pthread.h>
#include <assert.h>
#include <stdint.h>

// sas vars
#include <stdbool.h>
pthread_mutex_t sas0;
pthread_mutex_t sas1;
bool rf_read1;
bool rf_read2;
bool rf_check1;
bool rf_check2;
bool rf_write01; bool rf_write02;
bool rf_write11; bool rf_write12;
bool rf_write21; bool rf_write22;
bool rf_write31; bool rf_write32;


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

    pthread_mutex_lock(&mutex0);

    pthread_mutex_lock(&sas0);
    int tmp = size_SHARED + 1;
    rf_read1 = true;
    if (rf_write01 && !rf_write11 && !rf_write21)
        rf_check1 = true;
    pthread_mutex_unlock(&sas0);


    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    size_SHARED = tmp;
    if (!rf_read1 && rf_write01)
        rf_write11 = true;
    if (!rf_read2 && rf_write02)
        rf_write12 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);

    pthread_mutex_unlock(&mutex0);

    items_SHARED[tail_SHARED] = 1;

    return NULL;
}

void *t2_main(void *arg) {
    //Queue_Enqueue_t2(2);

    tail_SHARED += 1;

    pthread_mutex_lock(&mutex0);

    pthread_mutex_lock(&sas1);
    int tmp = size_SHARED + 1;
    rf_read2 = true;
    if (rf_write02 && !rf_write12 && !rf_write12)
        rf_check2 = true;
    pthread_mutex_unlock(&sas1);


    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    size_SHARED = tmp;
    if (!rf_read1 && rf_write01)
        rf_write21 = true;
    if (!rf_read2 && rf_write02)
        rf_write22 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);

    pthread_mutex_unlock(&mutex0);

    items_SHARED[tail_SHARED] = 2;

    return NULL;
}

int main() {
    pthread_t t1;
    pthread_t t2;

    //Queue_Init();
    head_SHARED = 0;
    tail_SHARED = 0;



    rf_read1 = false;
    rf_read2 = false;
    rf_check1 = false;
    rf_check2 = false;
    rf_write01 = false;
    rf_write02 = false;
    rf_write11 = false; rf_write12 = false;
    rf_write21 = false; rf_write22 = false;
    rf_write31 = false; rf_write32 = false;

    // Initialize val_SHARED
    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    size_SHARED = 0;
    if (!rf_read1)
        rf_write01 = true;
    if (!rf_read2)
        rf_write02 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);

    


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
        //assert(0);
    }
    if (r2 == -1) {
        //assert(0);
    }

    if (rf_check1 && rf_check2)
        assert(0);


    return 0;
}
