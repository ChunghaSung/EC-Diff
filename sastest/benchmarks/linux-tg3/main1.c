#include <pthread.h>
#include <assert.h>

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
bool rf_write5;
bool rf_write6;
bool rf_write7;
bool rf_write8;
bool rf_write9;
bool rf_write10;
bool rf_write11;
bool rf_write12;
bool rf_write13;
bool rf_write14;
bool rf_write15;
bool rf_write16;
bool rf_write17;



pthread_cond_t cond0 = PTHREAD_COND_INITIALIZER;
int cond0_bool = 0;
pthread_mutex_t mutex0 = PTHREAD_MUTEX_INITIALIZER;

//variables
int dev_SHARED = 1;
int stats_SHARED = 1;
int old_stats_SHARED; //not relevant how old_stats_SHARED get assigned
int buffertoprint_SHARED = 1;
int dev_SHARED_isalive = 1;

//constants
int EINVAL=22;

int rx_packets_SHARED = 1;
int tx_packets_SHARED = 1;
int rx_bytes_SHARED = 1;
int tx_bytes_SHARED = 1;
int rx_errors_SHARED = 1;
int tx_errors_SHARED = 1;
int multicast_SHARED = 1;
int collisions_SHARED = 1;
int length_erros_SHARED = 1;
int rx_over_errors_SHARED = 1;
int rx_frame_errors_SHARED = 1;
int tx_aborted_errors_SHARED = 1;
int tx_carrier_errors_SHARED_SHARED = 1;
int rx_crc_errors_SHARED = 1;
int rx_missed_errors_SHARED = 1;
int tp_rx_dropped_SHARED = 1;
int tp_tx_dropped_SHARED = 1;

void nop1() {}

void *thread1(void *args);
void *thread2(void *args);

// Thread 1: Modification thread
void *thread1(void *args)//netstat_show()
{
    int tmp = 0;
    int ret = EINVAL;

    if (dev_SHARED_isalive) {
        if(!stats_SHARED)
        {
            ret =  old_stats_SHARED;
        }
        else {
            tmp = old_stats_SHARED;
            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write1 = true;
            stats_SHARED = tmp + rx_packets_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write2 = true;
            stats_SHARED = tmp + tx_packets_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write3 = true;
            stats_SHARED = tmp + rx_bytes_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write4 = true;
            stats_SHARED = tmp + tx_bytes_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write5 = true;
            stats_SHARED = tmp + rx_errors_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write6 = true;
            stats_SHARED = tmp + tx_errors_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write7 = true;
            stats_SHARED = tmp + multicast_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write8 = true;
            stats_SHARED = tmp + collisions_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write9 = true;
            stats_SHARED = tmp + length_erros_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write10 = true;
            stats_SHARED = tmp + rx_over_errors_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write11 = true;
            stats_SHARED = tmp + rx_frame_errors_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write12 = true;
            stats_SHARED = tmp + tx_aborted_errors_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write13 = true;
            stats_SHARED = tmp + tx_carrier_errors_SHARED_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write14 = true;
            stats_SHARED = tmp + rx_crc_errors_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write15 = true;
            stats_SHARED = tmp + rx_missed_errors_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write16 = true;
            stats_SHARED = tmp + tp_rx_dropped_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = old_stats_SHARED;

            nop1();
            cond0_bool = 1;

            pthread_mutex_lock(&sas0);
            if (stats_SHARED == 0) { 
                //assert(0); 
            }
            rf_read = true;

            if (rf_write0 && !rf_write1 && !rf_write2 && !rf_write3 && !rf_write4 && !rf_write5 && !rf_write6 && !rf_write7 && !rf_write8 && !rf_write9 && !rf_write10 && !rf_write11 && !rf_write12 && !rf_write13 &&!rf_write14 && !rf_write15 && !rf_write16 && !rf_write17)
                rf_check = true;

            pthread_mutex_unlock(&sas0);

            nop1();

            nop1();

            pthread_mutex_lock(&sas0);
            if (!rf_read & rf_write0)
                rf_write17 = true;
            stats_SHARED = tmp + tp_tx_dropped_SHARED;
            pthread_mutex_unlock(&sas0);

            tmp = buffertoprint_SHARED;
            ret = tmp + stats_SHARED;
        }
    }
    return NULL;
}

// Thread 2: Free()ing thread
// tg3_free_consistent()
void *thread2(void *args) 
{
    if (dev_SHARED_isalive) {
        if(stats_SHARED)
        {
            nop1();
            if (!cond0_bool) {
                nop1();
            }
            nop1();

            pthread_mutex_lock(&sas0);
            if (!rf_read)
                rf_write0 = true;
            stats_SHARED = 0;
            pthread_mutex_unlock(&sas0);

        }
    }
    return NULL;
}

int main() {
    pthread_t t1, t2;

    rf_read = false;
    rf_check = false;
    rf_write0 = false;
    rf_write1 = false;
    rf_write2 = false;
    rf_write3 = false;
    rf_write4 = false;
    rf_write5 = false;
    rf_write6 = false;
    rf_write7 = false;
    rf_write8 = false;
    rf_write9 = false;
    rf_write10 = false;
    rf_write11 = false;
    rf_write12 = false;
    rf_write13 = false;
    rf_write14 = false;
    rf_write15 = false;
    rf_write16 = false;
    rf_write17 = false;


    // Everything is statically initialized at the top of the file
    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);


    assert(!rf_check);

}
