#include <assert.h>
#include <pthread.h>

// sas vars
#include <stdbool.h>
pthread_mutex_t sas0;
bool rf_check;
bool rf_read;
bool rf_write0;
bool rf_write1;
bool rf_write2;
bool rf_write3;
bool rf_write4;


/**
 * The Rep object in std::string
 *
 * This can be viewed as a global Rep object held in a global string which is
 * modified by the threads in t1_main() and t2_main()
 */
int length_SHARED;	///< The length_SHARED of the string
int capacity_SHARED;   ///< Max length_SHARED of string
int ref_count_SHARED;   ///< The number of references to the string

pthread_mutex_t mutex0;

void nop1() {}

/**
 * Sets all the members of the global "rep object" to zero.
 *
 * According to the bug report, even if two threads are writing 0 this should
 * not happen. The fix is simply to bail out earlier (i.e., bail out if the
 * assertion is true).
 */

/**
 * Calls erase() on the global Rep empty_rep
 *
 * \param args Unused
 * \return Returns NULL upon completion
 */


void *t1_main(void *args) {
    // Bail out early
    pthread_mutex_lock(&mutex0);

    pthread_mutex_lock(&sas0);
    if (!rf_read)
        rf_write0 = true;
    length_SHARED = 1;
    pthread_mutex_unlock(&sas0);



    if (length_SHARED == 0) {
        //return NULL;
    }
    // Otherwise, erase. There is still a data race!
    // erase();
    int tmp = length_SHARED;

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write1 = true;
    length_SHARED = 0;
    pthread_mutex_unlock(&sas0);


    pthread_mutex_unlock(&mutex0);

    if (tmp == 0) {
        //assert(0);
    }
    capacity_SHARED = 0;
    ref_count_SHARED = 0;

    return NULL;
}

void *t2_main(void *args) {
    // Bail out early
    pthread_mutex_lock(&mutex0);

    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write2 = true;
    length_SHARED = 1;
    pthread_mutex_unlock(&sas0);


    if (length_SHARED == 0) {
        //return NULL;
    }
    // Otherwise, erase. There is still a data race!
    // erase();
    pthread_mutex_lock(&sas0);
    int tmp = length_SHARED;
    rf_read = true;
    if (rf_write0 && !rf_write1 && !rf_write2 && !rf_write3 && !rf_write4)
        rf_check = true;
    pthread_mutex_unlock(&sas0);


    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write3 = true;
    length_SHARED = 0;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_unlock(&mutex0);

    if (tmp == 0) {
        //assert(0);
    }
    capacity_SHARED = 0;
    ref_count_SHARED = 0;

    return NULL;
}

/**
 * Initializes the global Rep empty_rep and creates threads in t1_main() and
 * t2_main()
 *
 * \return Returns 0 upon completion
 */
int main(void) {
    pthread_t t1, t2;

    rf_read = false;
    rf_check = false;
    rf_write0 = false;
    rf_write1 = false;
    rf_write2 = false;
    rf_write3 = false;
    rf_write4 = false;


    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write4 = true;
    length_SHARED = 1;
    pthread_mutex_unlock(&sas0);

    capacity_SHARED = 1;
    ref_count_SHARED = 1;

    pthread_create(&t1, NULL, t1_main, NULL);
    pthread_create(&t2, NULL, t2_main, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    assert(!rf_check);


    return 0;
}
