#include <pthread.h>
#include <stdlib.h>
#include <stdio.h> 
#include <stdint.h>
#include <assert.h>

/* Comment out to remove debugging messages and calls to sleep() to foce the
 * bug */

pthread_mutex_t mutex0;

#if 0

/** 
 * Number of characters allocated to the data section of the buffer */
#define BUFF_SIZE 256	

/**
 * Struct that exemplifies the output buffer found in the original program
 */
typedef struct buffer {
    char *data;	/**< The data contained in the buffer */
    int used;	/**< Number of bytes written to the buffer */
} Buffer;

/**
 * Argument to be passed to the function insLog()
 */
typedef struct command {
    Buffer *buf;    /**< A buffer to be written to */
    char *txt;	    /**< String to be written to the buffer */
    int size;	    /**< Number of bytes of txt to write to buffer */
} Command;
#endif

#define UINT_TYPE uint8_t

// Buffer
char buffer_SHARED[2];
// Number of bytes used in the buffer
uint8_t used_SHARED;

// sas vars
#include <stdbool.h>
pthread_mutex_t sas0;
bool rf_check;
bool rf_read;
bool rf_write1;
bool rf_write2;
bool rf_write3;



/** 
 * Copy the size bytes of txt into buf->data. The atomicity violation occurs
 * since calls to memcpy() and updating the number of bytes used in the buffer
 * are assumed to be atomic, but no synchronization variables are used
 *
 * \param buf: Initialized buffer for the data to be copied into
 * \param txt: Character string to be copied into the buffer
 * \param size: Number of bytes of txt to be copied into buf->data
 */
//void bufferUpdate_t1();
//void bufferUpdate_t2();

/**
 * Thread function to call bufferUpdate().
 *
 * \param arg Command struct that has information to be passed to bufferUpdate
 * \return Returns NULL upon completion
 */
void nop1(){}

void *insLog_t1(void* arg) {
    /* These statements are incorrectly assumed  to be atomic */
    nop1();
    int tmp = used_SHARED + 1;

    pthread_mutex_lock(&sas0);
    used_SHARED  = tmp;
    if (!rf_read)
        rf_write1 = true;
    pthread_mutex_unlock(&sas0);

    buffer_SHARED[used_SHARED] = 'a';
    nop1();
    return NULL;
}


void *insLog_t2(void* arg) {
    /* These statements are incorrectly assumed  to be atomic */
    nop1();
    int tmp = used_SHARED + 1;

    pthread_mutex_lock(&sas0);
    used_SHARED  = tmp;
    if (!rf_read && rf_write1)
        rf_write3 = true;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas0);
    rf_read = true;
    buffer_SHARED[used_SHARED] = 'a';
    if (rf_write1 && !rf_write2 && !rf_write3)
        rf_check = true;
    pthread_mutex_unlock(&sas0);
    nop1();
    return NULL;
}


/**
 * Initilizes the buffer and two Command structs to send to two instances of
 * isnLog() then exits.
 *
 * \return Returns 0 upon completion
 */
int main() {
    pthread_t t1, t2;
#if 0
    Buffer *buff;
    Command *c1, *c2;

    /* Initialize the buffer */
    buff = malloc(sizeof(Buffer));
    buff->data = malloc(sizeof(char) * BUFF_SIZE);
    buff->used = 0;

    /* Set up two commands to send to insLog() */
    c1 = malloc(sizeof(Command));
    c1->buf = buff;
    c1->txt = malloc(sizeof("12345"));
    memcpy(c1->txt, "12345", 5);
    c1->size = 5;

    c2 = malloc(sizeof(Command));
    c2->buf = buff;
    c2->txt = malloc(sizeof("56789"));
    memcpy(c2->txt, "56789", 5);
    c2->size = 5;
#endif
    // Initialize everything

    rf_read = false;
    rf_write1 = false;
    rf_write2 = false;
    rf_write3 = false;
    rf_check = false;



    pthread_mutex_lock(&sas0);
    used_SHARED = -1;
    if (!rf_read && rf_write1)
        rf_write2 = true;
    pthread_mutex_unlock(&sas0);

    buffer_SHARED[0] = 'x';
    buffer_SHARED[1] = 'x';

    pthread_create(&t1, NULL, insLog_t1, NULL);
    pthread_create(&t2, NULL, insLog_t2, NULL);

#if 0
#ifdef DEBUG
    /* if debugging is enabled, wait for the writes to buffer to be completed
     * then print out the buffer. */

    /* Spin, waiting for the two writes to be completed */
    while (buff->used < 10);

    /* Spin, waiting for the last \0 to be inserted */
    while (buff->data[buff->used] != '\0');

    /* Print out the buffer */
    int i;
    printf("Buffer Contents: ");
    for (i = 0; i < 10; i++) {
	putchar(buff->data[i]);
    }
    putchar('\n');
#endif

    pthread_exit((void *) 0);
#endif

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    if (buffer_SHARED[1] == 'x') {
      //assert(0);
    }

    assert(!rf_check);

    return 0;
}
