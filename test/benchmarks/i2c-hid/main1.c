#include <pthread.h>
#include <stdio.h>
#include <assert.h>

int open_SHARED = 0;
int power_on_SHARED = 0;


void nop1(void) {
    return;
}

void* thread_open(void* arg) {
    while (1) {
        // function inlining
        //i2c_hid_open();

        nop1();

        if (open_SHARED == 0) {

            power_on_SHARED = 1; // (b)

        }

        open_SHARED++;
        
        if (power_on_SHARED == 0) {
            assert(0);
        }
        //assert (power_on_SHARED != 0); // (c)

        nop1();
    }
}

void* thread_close(void* arg) {
    while (1) {
        //assume(open > 0);
        if (open_SHARED > 0) {

            // function inlining
            //i2c_hid_close();

            nop1();

            open_SHARED--;

            if (open_SHARED == 0) {
                power_on_SHARED = 0;  // (d)
            }

            if (power_on_SHARED != 0) {
                assert(0);
            }
            //assert (power_on_SHARED == 0); // (e)

            nop1();

        }
    }
}

#pragma endregion threads

int main() {

    open_SHARED = 0;
    power_on_SHARED = 0;

    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread_open, NULL);
    pthread_create(&t2, NULL, thread_close, NULL);

    return 0;
}
