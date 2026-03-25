#include <pthread.h>
#include <assert.h>
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
            stats_SHARED = tmp + rx_packets_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + tx_packets_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + rx_bytes_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + tx_bytes_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + rx_errors_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + tx_errors_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + multicast_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + collisions_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + length_erros_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + rx_over_errors_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + rx_frame_errors_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + tx_aborted_errors_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + tx_carrier_errors_SHARED_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + rx_crc_errors_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + rx_missed_errors_SHARED;
            tmp = old_stats_SHARED;
            stats_SHARED = tmp + tp_rx_dropped_SHARED;
            tmp = old_stats_SHARED;
            nop1();
            cond0_bool = 1;

            if (stats_SHARED == 0) { 
                assert(0); 
            }

            nop1();


            nop1();

            stats_SHARED = tmp + tp_tx_dropped_SHARED;
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

            stats_SHARED = 0;
        }
    }
    return NULL;
}

int main() {
    pthread_t t1, t2;
    // Everything is statically initialized at the top of the file
    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);

}
