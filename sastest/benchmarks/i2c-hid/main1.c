#include <pthread.h>
#include <stdio.h>
#include <assert.h>

// sas vars
#include <stdbool.h>
pthread_mutex_t sas0;
bool rf_check;
bool rf_read;
bool rf_write0;
bool rf_write1;
bool rf_write2;


int open_SHARED = 0;
int power_on_SHARED = 0;


void nop1(void) {
    return;
}

void* thread_open(void* arg) {
    int i = 3;
    while (i > 0) {
        // function inlining
        //i2c_hid_open();

        nop1();

        if (open_SHARED == 0) {

            power_on_SHARED = 1; // (b)

        }

        int tmp = open_SHARED + 1;

        pthread_mutex_lock(&sas0);
        if (!rf_read)
            rf_write0 = true;
        open_SHARED = tmp;
        pthread_mutex_unlock(&sas0);

        if (power_on_SHARED == 0) {
            //assert(0);
        }

        //assert (power_on_SHARED != 0); // (c)

        nop1();
        i--;
    }
}

void* thread_close(void* arg) {
    int i = 3;
    while (i > 0) {
        assume(open_SHARED > 0);
        if (open_SHARED > 0) {

            // function inlining
            //i2c_hid_close();

            nop1();

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write1 = true;
            open_SHARED--;
            pthread_mutex_unlock(&sas0);


            pthread_mutex_lock(&sas0);
            if (open_SHARED == 0) {
                power_on_SHARED = 0;  // (d)
            }
            rf_read = true;
            if (rf_write0 && !rf_write1 && !rf_write2) {
                rf_check = true;
            }
            pthread_mutex_unlock(&sas0);




            if (power_on_SHARED != 0) {
                //assert(0);
            }
            //assert (power_on_SHARED == 0); // (e)

            nop1();

        }
        i--;
    }
}

#pragma endregion threads

int main() {

    rf_read = false;
    rf_check = false;
    rf_write0 = false;
    rf_write1 = false;
    rf_write2 = false;


    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write2 = true;
    open_SHARED = 5;
    pthread_mutex_unlock(&sas0);


    power_on_SHARED = 0;

    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread_open, NULL);
    pthread_create(&t2, NULL, thread_close, NULL);

    assert(!rf_check);

    return 0;
}
