// Author: Chungha Sung
// This patch has been done by ISSTA repair paper.
// However, I found a bug for this so I changed the patch with a simpler version.

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


pthread_mutex_t mutex0;

//trigger structure
int trigger_use_count_SHARED;
int trigger_has_ops_SHARED;
int trigger_reenable_function_SHARED;
int trigger_ops_has_tryreenable_function_SHARED;


//constants
int CONFIG_IIO_CONSUMERS_PER_TRIGGER_SHARED=2;
int trig_subirqs_enabled_SHARED=0;

void nop1(){}

//threads
void *thread1(void *args)   //iio_trigger_poll()
{
    int tmp=0;
    int i=0;
    int j=0;

    nop1();

    if (trigger_use_count_SHARED != 0) {
        //while (i < CONFIG_IIO_CONSUMERS_PER_TRIGGER_SHARED) {
            if (i < trig_subirqs_enabled_SHARED) {
                //BEGIN ASEC
                tmp = trigger_use_count_SHARED;

                pthread_mutex_lock(&sas0);
                if (!rf_read & rf_write0)
                    rf_write1 = true;
                trigger_use_count_SHARED = tmp + 1;
                pthread_mutex_unlock(&sas0);

                //END ASEC
            } else {
                //inline iio_trigger_notify_done();
                //BEGINN_ASEC
                tmp = trigger_use_count_SHARED;

                pthread_mutex_lock(&sas0);
                if (!rf_read & rf_write0)
                    rf_write2 = true;
                trigger_use_count_SHARED = tmp + 1;
                pthread_mutex_unlock(&sas0);

                pthread_mutex_lock(&sas0);
                tmp = trigger_use_count_SHARED;
                rf_read = true;
                if (rf_write0 && !rf_write1 && !rf_write2 && !rf_write3)
                    rf_check = true;
                pthread_mutex_unlock(&sas0);

                if (tmp) {
                    if(trigger_has_ops_SHARED && trigger_ops_has_tryreenable_function_SHARED){
                        //END ASEC
                        if (trigger_reenable_function_SHARED) {
                            // Missed an interrupt so launch new poll now 
                            //inline iio_trigger_poll()
                            if (trigger_use_count_SHARED != 0) {
                                while(j < CONFIG_IIO_CONSUMERS_PER_TRIGGER_SHARED) {
                                    if (j < 2) {
                                        //BEGIN ASEC
                                        tmp = trigger_use_count_SHARED;

                                        pthread_mutex_lock(&sas0);
                                        if (!rf_read & rf_write0)
                                            rf_write3 = true;
                                        trigger_use_count_SHARED = tmp + 1;
                                        pthread_mutex_unlock(&sas0);

                                        //END ASEC
                                    }
                                    j++;
                                } // while (j < CONFIG ...
                            }
                        }
                    }
                }
            } 
            i++;
        //} // while (i < CONF...
    } // if ( trigger_use_count_SHARED != 0)

    nop1();
    return NULL;
}

void *thread2(void *args)  
{				
    nop1();

    int tmp = trigger_use_count_SHARED;
    pthread_mutex_lock(&sas0);
    if (!rf_read)
        rf_write0 = true;
    trigger_use_count_SHARED = tmp + 1;
    pthread_mutex_unlock(&sas0);


    nop1();

    return NULL;
}


int main() {
    pthread_t t1, t2;

    trigger_use_count_SHARED = 5;
    trigger_has_ops_SHARED = 5;
    trigger_reenable_function_SHARED = 5;
    trigger_ops_has_tryreenable_function_SHARED = 5;

    rf_read = false;
    rf_check = false;
    rf_write0 = false;
    rf_write1 = false;
    rf_write2 = false;
    rf_write3 = false;



    //constants
    //CONFIG_IIO_CONSUMERS_PER_TRIGGER_SHARED = 1;
    //trig_subirqs_enabled_SHARED = 0;

    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    if (trigger_use_count_SHARED != 3) {
        //assert(0);
    }
    //assert(trigger_use_count_SHARED == 3);

    assert(!rf_check);

    return 0;
}
