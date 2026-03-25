#include <pthread.h>
#include <assert.h>

/**
 * Value that is incremented or decremented by t1_main() or t2_main()
 */
int shared_SHARED;

pthread_mutex_t mutex0;

/**
 * Increments shared_SHARED a bunch
 *
 * \param args Unused
 * \return Returns NULL upon completion
 */

/**
 * Decrements shared_SHARED a bunch
 *
 * \param args Unused
 * \return Returns NULL upon completin
 */

void nop1() {};

void *t1_main(void *args) {

    pthread_mutex_lock(&mutex0);

    shared_SHARED++;
    shared_SHARED++;
    shared_SHARED++;
    shared_SHARED++;
    shared_SHARED++;
    shared_SHARED++;
    shared_SHARED++;
    shared_SHARED++;
    shared_SHARED++;
    shared_SHARED++;
    pthread_mutex_unlock(&mutex0);

    return NULL;
}

void *t2_main(void *args) {

    pthread_mutex_lock(&mutex0);

    shared_SHARED--;
    shared_SHARED--;
    shared_SHARED--;
    shared_SHARED--;
    shared_SHARED--;
    shared_SHARED--;
    shared_SHARED--;
    shared_SHARED--;
    shared_SHARED--;
    shared_SHARED--;
    pthread_mutex_unlock(&mutex0);

    return NULL;
}

/**
 * Initialized shared_SHARED to 0 and then spawns threads in t1_main() and t2_main.
 * calls pthread_join on both the threads and checks if the end value of shared_SHARED
 * is 0 (using assert()).
 *
 * \param argc Unused
 * \param argv Unused
 * \return Returns NULL upon completion
 */

int main(int argc, char *argv[]) {
    /* threads for t1_main and t2_main */
    pthread_t t1, t2;

    /* initialize shared_SHARED */
    shared_SHARED = 0;

    /* create the threads */
    pthread_create(&t1, NULL, t1_main, NULL);
    pthread_create(&t2, NULL, t2_main, NULL);

    /* wait for them to exit */
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    /* the two thread should decrement and increment the same number of times */
    assert(shared_SHARED == 0);

    return 0;
}

