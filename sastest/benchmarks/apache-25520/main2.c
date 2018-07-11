#include <pthread.h>
#include <string.h>
#include <assert.h>
#include <stdio.h>
#include <stdbool.h>

/* Comment out to suppress calls to printf() displaying debugging messages and
 * calls to nanosleep() to attempt to force the buggy interleaving */
#define DEBUG false

// sas variables
pthread_mutex_t sas0;
pthread_mutex_t sas1;
bool rf_read1;
bool rf_read2;
bool rf_check1;
bool rf_check2;
bool rf_write11;
bool rf_write21;
bool rf_write31;
bool rf_write12;
bool rf_write22;
bool rf_write32;

/*
#ifdef DEBUG
#include <stdio.h>
#include <time.h>
#endif
*/

/**
 * Array the threads will write to
 */
//char buffer[256];
//char buffer[2];
char b1_SHARED;
char b2_SHARED;

/**
 * Next open index in buffer
 */
int outcnt_SHARED;

void nop1();

pthread_mutex_t mutex0;

/**
 * Write the passed char * to buffer
 *
 * \param s String to write to buffer
 * \return Returns NULL upon completion
 */
//void *writeSentence(void *s);

void *writeSentence_t1(void *arg) {

#ifdef DEBUG
    struct timespec waitTime;
    waitTime.tv_sec = 0;
    waitTime.tv_nsec = 1000;

    printf("Copying string\n");
#endif

    /* copy the string into buffer */
    //memcpy(buffer + outcnt_SHARED, (char *) s, strlen(s) + 1);

#ifdef DEBUG
    nanosleep(&waitTime, &waitTime);
    printf("Updating outcnt_SHARED\n");
#endif
    //outcnt_SHARED = strlen(s) + 1;

    pthread_mutex_lock(&mutex0);

    if (outcnt_SHARED == 0) {
      b1_SHARED = 'a';
    }
    else {
      b2_SHARED = 'a';
    }

    pthread_mutex_lock(&sas0);
    int tmp = outcnt_SHARED - 1;
    rf_read1 = true;
    if (rf_write11 && !rf_write21 && !rf_write31)
        rf_check1 = true;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    outcnt_SHARED = tmp;
    if (rf_write11 && !rf_read1)
        rf_write21 = true;

    if (rf_write12 && !rf_read2)
        rf_write22 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);


    pthread_mutex_unlock(&mutex0);

    //buffer[outcnt_SHARED] = 'a';
    //outcnt_SHARED++;


    return NULL;
}

void *writeSentence_t2(void* arg) {

#ifdef DEBUG
    struct timespec waitTime;
    waitTime.tv_sec = 0;
    waitTime.tv_nsec = 1000;

    printf("Copying string\n");
#endif

    /* copy the string into buffer */
    //memcpy(buffer + outcnt_SHARED, (char *) s, strlen(s) + 1);

#ifdef DEBUG
    nanosleep(&waitTime, &waitTime);
    printf("Updating outcnt_SHARED\n");
#endif
    //outcnt_SHARED = strlen(s) + 1;

    pthread_mutex_lock(&mutex0);

    if (outcnt_SHARED == 0) {
      b1_SHARED = 'b';
    }
    else {
      b2_SHARED = 'b';
    }

    pthread_mutex_lock(&sas1);
    int tmp = outcnt_SHARED - 1;
    rf_read2 = true;
    if (rf_write12 && !rf_write22 && !rf_write32)
        rf_check2 = true;
    pthread_mutex_unlock(&sas1);

    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    outcnt_SHARED = tmp;
    if (rf_write11 && !rf_read1)
        rf_write31 = true;

    if (rf_write12 && !rf_read2)
        rf_write32 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);

    pthread_mutex_unlock(&mutex0);

    //buffer[outcnt_SHARED] = 'b';
    //outcnt_SHARED++;

    return NULL;
}

/**
 * Spawns two threads with to writeSentence() with two different setences to
 * write.
 *
 * \return Returns 0 upon completion
 */
int main() {
    pthread_t t1, t2;

    /* Some pangrams to write to the buffer */
    char *sent1 = "The quick brown fox jumps over the lazy dog.";
    char *sent2 = "Vamp fox held quartz duck just by wing.";

#ifdef DEBUG
    printf("Spawning first thread\n");
#endif
    //pthread_create(&t1, NULL, writeSentence, (void *) sent1);
#ifdef DEBUG
    printf("Spawning second thread\n");
#endif
    //pthread_create(&t2, NULL, writeSentence, (void *) sent2);

#ifdef DEBUG
    /* Have main() wait until both sentences have been written */
    //pthread_join(t1, NULL);
    //pthread_join(t2, NULL);

    //buffer[outcnt_SHARED + 1] = '\0';

    //printf("Final String: %s\n", buffer);

    //return 0;
#endif

#ifndef DEBUG
    //pthread_exit((void *) 0);
#endif

    // Initialize the buffer
    //buffer[0] = 'x';
    //buffer[1] = 'x';
    b1_SHARED = 'x';
    b2_SHARED = 'x';

    rf_read1 = false;
    rf_read2 = false;
    rf_check1 = false;
    rf_check2 = false;
    rf_write11 = false;
    rf_write21 = false;
    rf_write31 = false;
    rf_write12 = false;
    rf_write22 = false;
    rf_write32 = false;

    pthread_mutex_lock(&sas1);
    pthread_mutex_lock(&sas0);
    outcnt_SHARED = 0;
    if (!rf_read1)
        rf_write11 = true;
    if (!rf_read2)
        rf_write12 = true;
    pthread_mutex_unlock(&sas0);
    pthread_mutex_unlock(&sas1);

    pthread_create(&t1, NULL, writeSentence_t1, NULL);
    pthread_create(&t2, NULL, writeSentence_t2, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    //if (buffer[0] != 'a' || buffer[0] != 'b') {
    //if (b1_SHARED != 'x' || b2_SHARED != 'b') {
    if (b2_SHARED == 'x') {
      //assert(0);
    }

    if (rf_check1 && rf_check2)
        assert(0);


    //if (buffer[1] != 'a' || buffer[1] != 'b') {
    //if (b2_SHARED != 'a' || b2_SHARED != 'b') {
      //assert(0);
    //}

    return 0;

}
