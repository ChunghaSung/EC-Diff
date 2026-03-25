// Author: 
// Based on ISSTA repair paper, I added one more thread. 
// And, I applied patch for str_lock

#include <stdbool.h>
#include <stdint.h>
#include <pthread.h>
#include <assert.h>

// Data associated with the string "object"
char str_data_SHARED;
// Lock protecting the string
pthread_mutex_t str_lock;
pthread_mutex_t mutex0;
// True if the string is shared across multiple threads
bool str_is_shared_SHARED;
// Number of references of the string being used
int8_t ref_count_SHARED;
bool destroyed_SHARED;

void nop1() {}

void *t1_main(void *args) {
    // Copy the string. This is simply used as an operation incrementing the
    // reference count
    if (str_is_shared_SHARED) {
        pthread_mutex_lock(&str_lock);
        ref_count_SHARED++;
        pthread_mutex_unlock(&str_lock);
    }

    // Call the string destructor
    pthread_mutex_lock(&mutex0);

    pthread_mutex_lock(&str_lock);
    if (ref_count_SHARED < 0) {
        // no more reference to the string so we can destroy it
        pthread_mutex_unlock(&str_lock);
        destroyed_SHARED = true;
        pthread_mutex_unlock(&mutex0);

    }
    else {
        // still references out there, do nothing
        pthread_mutex_unlock(&str_lock);
    }
    // End destructor

    return NULL;
}

void *t2_main(void *args) {
    // Copy the string. This is simply used as an operation incrementing the
    // reference count
    if (str_is_shared_SHARED) {
        pthread_mutex_lock(&str_lock);
        ref_count_SHARED++;
        pthread_mutex_unlock(&str_lock);
    }

    // Call the string destructor
    pthread_mutex_lock(&mutex0);

    pthread_mutex_lock(&str_lock);
    if (ref_count_SHARED < 0) {
        // no more reference to the string so we can destroy it
        pthread_mutex_unlock(&str_lock);
        destroyed_SHARED = true;
        pthread_mutex_unlock(&mutex0);

    }
    else {
        // still references out there, do nothing
        pthread_mutex_unlock(&str_lock);
    }
    // End destructor

    return NULL;
}

void *t3_main(void *args) {
    // Code from obtaining the .end() iterator. This function has strange
    // behavior which causes the bug
    //
    // Note: str_is_shared_SHARED is always false so this branch is always taken
    if (!str_is_shared_SHARED) {
        pthread_mutex_lock(&str_lock);
        // Set ref_count_SHARED to -1. I think the intetion was for this to be an
        // optimization for the non-shared case.
        ref_count_SHARED = -1;

        pthread_mutex_unlock(&str_lock);
    }

    // At this point, thread one can come in and destroy the mutex since
    // str_is_shared_SHARED is false (so thread one will not increment the reference
    // count). The buggy behavior is that thread 2 can perform operations on the
    // thread after thread one destroys the string.

    // perform a modification

    pthread_mutex_lock(&mutex0);

    if (destroyed_SHARED) {

        assert(0);
    }

    pthread_mutex_unlock(&mutex0);

    str_data_SHARED = 'a';

    return NULL;
}

int main() {
    pthread_t t1, t2, t3;

    // Initialize everything
    //pthread_mutex_init(&str_lock, NULL);
    str_is_shared_SHARED = false;
    str_data_SHARED = 'x';
    ref_count_SHARED = 0;
    destroyed_SHARED = false;

    pthread_create(&t1, NULL, t1_main, NULL);
    pthread_create(&t2, NULL, t2_main, NULL);
    pthread_create(&t3, NULL, t3_main, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    pthread_join(t3, NULL);

    return 0;

}
