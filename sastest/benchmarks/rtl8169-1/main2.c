// Modified by 
// Updated rtl8169 driver by changing semaphore into lock pairs and inlining functions

/*  This is a skeleton of the rtl8169 driver.  It contains only code
    related to synchronisation, including all the threads found
    in the real driver (seven threads overall).  It contains 4 
    concurrency bugs, all of which can be fixed using the REORDER pattern
    and 1 deadlock bug.

1. Race between driver initialisation function (drv_probe), and network interface
initialisation (drv_open)

pci_thread                                      network_thread
----------                                      --------------

|- drv_probe()
   |- register_netdev()
      |- registered = true
                                                |- open
                                                   |- registered == true
                                                   |- drv_open()
                                                      |- (*hw_start)(); // uninitialised pointer
   |- hw_start = drv_hw_start

Possible solution: swap register_netdev() and (hw_start = drv_hw_start) in drv_probe


2. Race between network_thread and napi_thread

network_thread                                  napi_thread
--------------                                  -----------

|- close()
   |- drv_close()
      |- dev_down()
         |- dev_on = false
                                                |- drv_napi_poll
                                                   |- write_IntrMask(1);
                                                      |- assert(dev_on)  !!!
      |- napi_disable()

Possible solution: swap dev_down and napi_disable in the body of drv_close


3. Race condition between drv_up and drv_irq running in the irq_thread.


network_thread                    irq_thread
--------------                    ----------------

|- open
  |- drv_open
     |- dev_up
        |- write_IntrMask(1);
								   |if (IntrMask)
                                   |-drv_irq()
								     | if (!intr_mask)
										|- handled = 0
                                   |- assert(handled != 0)

		|- intr_mask = 1;
		
Possible solution: swap write_IntrMask(1) and intr_mask=1 in the body of dev_up

                                        
4.  Race between interrupt handler and NAPI thread

irq_thread                                      napi_thread
----------                                      -----------

(irq_enabled && IntrStatus && IntrMask)
|- drv_irq
   |- write_IntrMask(0);
   |- intr_mask = 0;
   |- napi_schedule ();
                                                |- drv_napi_poll()
                                                   |- write_IntrMask(255);

(irq_enabled && IntrStatus && IntrMask)
|- drv_irq
   |- intr_mask==0
   |- assert(0)
                                                   |- intr_mask = 255;

Possible solution: swap write_IntrMask(255) and (intr_mask = 255) in the body 
of drv_napi_poll()


5. Deadlock in sysfs_thread

sysfs_thread                                    pci_thread                             
------------                                    ----------

|- lock(sysfs_lock)
                                                |- lock(dev_lock)
                                                |- drv_disconnect
                                                   |- remove_sysfs_files
                                                      |- lock(sysfs_lock);  // DEADLOCK
|- lock(dev_lock)                               
                                                        
Possible solution: change the order the sysfs_thread locks sysfs_lock and dev_lock

*/

#include <stdio.h>
#include <pthread.h>
#include <assert.h>




typedef unsigned char u8;

typedef int bool;
#define true  1
#define false 0

//typedef int mutex_t;

//#define locked   1
//#define unlocked 0

//typedef int semaphore_t;


/* Forward declarations of driver methods */
//int  drv_open();
//void drv_close();
//void drv_disconnect();
//int  drv_irq();
//void drv_napi_poll();
//void drv_start_xmit();
//void drv_xmit_timeout();
//void drv_reset_task();
//unsigned int drv_sysfs_read(int off);

/**************************************************************
 * Environment model.  
 **************************************************************/

/* Global state */
bool registered_SHARED_BUSY       = false; // true when the driver interface is open by the OS
bool netif_running_SHARED  = false; // true after the driver has been registered with the TCP/IP stack

bool irq_enabled_SHARED       = false;

bool napi_enabled_SHARED  = false;
bool napi_scheduled_SHARED    = false;

bool reset_task_ready_SHARED  = false;

bool sysfs_registered_SHARED  = false;

//mutex_t dev_lock      = unlocked;
//mutex_t sysfs_lock    = unlocked;
//mutex_t rtnl_lock     = unlocked;
pthread_mutex_t dev_lock;
pthread_mutex_t sysfs_lock;
pthread_mutex_t rtnl_lock;

//semaphore_t irq_sem   = 1;
//semaphore_t napi_sem  = 1;
pthread_mutex_t irq_sem;
pthread_mutex_t napi_sem;
pthread_mutex_t napi;

u8 IntrStatus_SHARED;
u8 IntrMask_SHARED;

/**************************************************************
 * Driver definitions from below  
 **************************************************************/

u8 intr_mask_SHARED;
bool dev_on_SHARED = false;

#define budget 100

//void dev_up();
//void dev_down();
//int  handle_interrupt();
//void create_sysfs_files();
//void remove_sysfs_files();
//void write_IntrMask(u8 val);
//void write_IntrStatus(u8 val);
//void napi_schedule();
//void device_remove_bin_file();
//void napi_enable();
//void synchronize_irq();
//int drv_probe();
//int register_netdev();
//void unregister_netdev();
//void napi_complete();
//void napi_disable();
//void device_create_bin_file();
//int request_irq();
//int open();
//int close();

//void (*hw_start)();
int hw_start_SHARED;;

// sas var
#include <stdbool.h>
#define ITER 10
pthread_mutex_t sas0;
bool rf_check;
bool rf_write0;
bool rf_write1;
bool rf_read;



#pragma region threads

/* PCI thread: PCI bus probe, shutdown, and unplug operations 
 */
void* pci_thread(void* arg)
{
	int probe;
	//probe = drv_probe();
    int rc;
    //create_sysfs_files();
    pthread_mutex_lock(&sysfs_lock);
    //device_create_bin_file();
    sysfs_registered_SHARED  = true;
    pthread_mutex_unlock(&sysfs_lock);


    /************** (2) **************/
	//hw_start = drv_hw_start; /* (2) */
    pthread_mutex_lock(&sas0);
    if (rf_write0 && !rf_read)
        rf_write1 = true;
    hw_start_SHARED = 1;
    pthread_mutex_unlock(&sas0);
    /*********************************/

    /************** (1) **************/
    //rc = register_netdev(); /* (1) */
    registered_SHARED_BUSY = true;

    rc = 0;
    /*********************************/

    if (rc < 0) {
        probe = rc;
    } else {
        probe = 0;
    }
    /*
    if (probe)
        return;
        */

    pthread_mutex_lock(&dev_lock);
    //drv_disconnect();
    //unregister_netdev();
    //registered_SHARED = false;
    while (netif_running_SHARED  != 0) {};
    //remove_sysfs_files();
    pthread_mutex_lock(&sysfs_lock);
    //device_remove_bin_file();
    sysfs_registered_SHARED  = false;
    pthread_mutex_unlock(&sysfs_lock);
    pthread_mutex_unlock(&dev_lock);
}

/* Configuration thread
 */
void* network_thread(void* arg)
{
	int open1;
	int nondet;
    int i = 0;
    while (i < ITER) {
		//open1 = open();
        open1 = 0;
        pthread_mutex_lock(&rtnl_lock);
        if (registered_SHARED_BUSY  != 0) {
            //ret = drv_open();
            int rc;
            //(*hw_start)();
            int tmp;

            pthread_mutex_lock(&sas0);
            tmp = hw_start_SHARED;
            rf_read = true;
            if (rf_write0 && !rf_write1)
                rf_check = true;
            pthread_mutex_unlock(&sas0);

            
            if (tmp == 0) {
                // uninitialized pointer access
                tmp = hw_start_SHARED;
            } else {
                // correct access
                tmp = hw_start_SHARED;
            }

            IntrMask_SHARED = 0; // (IntrMask.1)
            //rc = request_irq();
            irq_enabled_SHARED  = true;
            rc = 0;
            //if (rc < nd()) {
            //} else {
                open1 = rc;
                napi_enabled_SHARED  = true;
                //dev_up();
                dev_on_SHARED  = true;

                /*********** (1) **************/
                //write_IntrMask(1);  /* (1) */
                // To support dominate & post-dominate analysis
                int tmp2 = dev_on_SHARED;
                /*
                if (dev_on_SHARED  == 0) {
                    assert(0);
                }
                */
                IntrMask_SHARED = 1;
                /******************************/

                /*********** (2) **************/
                intr_mask_SHARED = 1;     /* (2) */
                /******************************/

                open1 = rc;
            //}
            //if (ret == 0) {netif_running = true;}
            netif_running_SHARED  = true;
        }
        pthread_mutex_unlock(&rtnl_lock);



        if (!open1){

            //drv_xmit_timeout();
            reset_task_ready_SHARED  = true;

			//close();
            pthread_mutex_lock(&rtnl_lock);
            if (netif_running_SHARED  != 0) {
                netif_running_SHARED  = false;
                //drv_close();

                /************ (1) *************/
                //dev_down();   /* (1) */
                //write_IntrMask(0);
                // To support dominate & post-dominate analysis
                int tmp1 = dev_on_SHARED;
                /*
                if (dev_on_SHARED  == 0) {
                    assert(0);
                }
                */
                IntrMask_SHARED = 0;

                //synchronize_irq();
                //pthread_mutex_lock(&irq_sem);
                //pthread_mutex_unlock(&irq_sem);

                dev_on_SHARED  = false;
                /*******************************/

                /************ (2) *************/
                //napi_disable();  /* (2) */
                napi_enabled_SHARED  = false;
                pthread_mutex_lock(&napi_sem);
                /*******************************/

                dev_on_SHARED  = true;
                pthread_mutex_unlock(&napi_sem);
                //free_irq();
                irq_enabled_SHARED  = false;
            }
            pthread_mutex_unlock(&rtnl_lock);
        }
        i++;
    }
}


/* Interrupt thread.  Contains a very coarse model of how the device 
 * generates async interrupts, calls the irq entry point in a loop. 
 */
void* irq_thread(void* arg)
{
    int handled;
    int i = 0;
    while (i <ITER) {
        //down(irq_sem);
        pthread_mutex_lock(&irq_sem);
        if (irq_enabled_SHARED !=0 && IntrStatus_SHARED!=0 && IntrMask_SHARED!=0) { // (IntrMask.5)
            //handled = drv_irq();
            u8 status;
            status = IntrStatus_SHARED;;
            while (status) {
                if (intr_mask_SHARED != 0) {
                    //write_IntrMask(0);
                    // To support dominate & post-dominate analysis
                    int tmp1 = dev_on_SHARED;
                    /*
                       if (dev_on_SHARED  == 0) {
                       assert(0);
                       }
                     */
                    IntrMask_SHARED = 0xff;
                    intr_mask_SHARED = 0;
                    //napi_schedule ();
                    pthread_mutex_lock(&napi);
                    if (napi_enabled_SHARED !=0)
                        napi_scheduled_SHARED  = true;
                    pthread_mutex_unlock(&napi);
                    handled = 1;
                }
                //write_IntrStatus(status);
                // To support dominate & post-dominate analysis
                int tmp2 = dev_on_SHARED;
                /*
                   if (dev_on_SHARED  == 0) {
                   assert(0);
                   }
                 */
                IntrStatus_SHARED = IntrStatus_SHARED & (~status);
                status = IntrStatus_SHARED;;
            }
            // To support dominate & post-dominate analysis
            int tmp3 = handled;
            /*
            if (handled == 0) {
                assert(0);
            }
            */
        }
        //up(irq_sem);
        pthread_mutex_unlock(&irq_sem);
        i++;
    }
}

void* dev_thread(void* arg)
{
    int i = 0;
    while (i < ITER) {
        IntrStatus_SHARED = 1;
        i++;
	}
}

/* NAPI thread: delayed interrupt handling. 
 */

void* napi_thread(void* arg)
{
    bool flag;

    int i = 0;

    while(i < ITER) {
        pthread_mutex_lock(&napi_sem);
        while (napi_scheduled_SHARED ) {
            //drv_napi_poll();
            //work_done = handle_interrupt();
            IntrStatus_SHARED = 0;
            if (0 < budget) {
                //napi_complete();
                napi_scheduled_SHARED  = false;

                /**************** (1) *************/
                //write_IntrMask(0xff);  /* (1) */
                // To support dominate & post-dominate analysis
                int tmp = dev_on_SHARED;
                /*
                if (dev_on_SHARED  == 0) {
                    assert(0);
                }
                */
                IntrMask_SHARED = 0xff;
                /**********************************/

                /**************** (2) *************/
                intr_mask_SHARED = 0xff;     /* (2) */
                /**********************************/
            }
        }
        pthread_mutex_unlock(&napi_sem);
        i++;
    }
}

/* Workqueue thread */
void* workqueue_thread(void *arg)
{
    int i = 0;
    while(i < ITER) {
        if (reset_task_ready_SHARED ) {
            //drv_reset_task();
            pthread_mutex_lock(&rtnl_lock);
            // Skip the reset sequence if a racing rtl8169_down disabled 
            // the device. 
            if (netif_running_SHARED  == 0)
                continue;
            // wait for in-progress send and receive operations to finish.
            //napi_disable();
            napi_enabled_SHARED  = false;
            pthread_mutex_lock(&napi_sem);

            // reset hardware
            //dev_down();
            // To support dominate & post-dominate analysis
            int tmp1 = dev_on_SHARED;
            /*
               if (dev_on_SHARED  == 0) {
               assert(0);
               }
             */
            IntrMask_SHARED = 0;

            //synchronize_irq();
            pthread_mutex_lock(&irq_sem);
            pthread_mutex_unlock(&irq_sem);

            dev_on_SHARED  = false;

            //dev_up();
            dev_on_SHARED  = true;

            /*********** (1) **************/
            //write_IntrMask(1);  /* (1) */
            // To support dominate & post-dominate analysis
            int tmp2 = dev_on_SHARED;
            /*
               if (dev_on_SHARED  == 0) {
               assert(0);
               }
             */
            IntrMask_SHARED = 1;
            /******************************/

            /*********** (2) **************/
            intr_mask_SHARED = 1;     /* (2) */
            /******************************/

            // insert it by supporting semaphore
            pthread_mutex_unlock(&napi_sem);

            //napi_enable();
            napi_enabled_SHARED  = true;
            pthread_mutex_unlock(&rtnl_lock);

            reset_task_ready_SHARED  = false;
        }
        i++;
    }
}

/* SysFS thread: user thread that reads driver configuration settings. */
void* sysfs_thread(void *arg)
{
	//int nondet;
    int i = 0;
    while (i<ITER) {
        pthread_mutex_lock(&sysfs_lock);
        pthread_mutex_lock(&dev_lock);
        if (sysfs_registered_SHARED  != 0) {
			//nondet = nd();
            //drv_sysfs_read(0);
        }
        pthread_mutex_unlock(&dev_lock);
        pthread_mutex_unlock(&sysfs_lock);
        i++;
    }
}


#pragma endregion threads

void main() {
	registered_SHARED_BUSY  = false; // true when the driver interface is open by the OS
	netif_running_SHARED = false; // true after the driver has been registered with the TCP/IP stack

    rf_check = false;
    rf_read = false;
    rf_write0 = false;
    rf_write1 = false;

    pthread_mutex_lock(&sas0);
    hw_start_SHARED = false;
    if (!rf_read)
        rf_write0 = true;
    pthread_mutex_unlock(&sas0);

	irq_enabled_SHARED   = false;

	napi_enabled_SHARED  = false;
	napi_scheduled_SHARED   = false;

	reset_task_ready_SHARED  = false;

	sysfs_registered_SHARED  = false;

	dev_on_SHARED     = false;
	
    pthread_t t1, t2, t3, t4, t5, t6, t7;
    pthread_create(&t1, NULL, pci_thread, NULL);
    pthread_create(&t2, NULL, network_thread, NULL);
    pthread_create(&t3, NULL, irq_thread, NULL);
    pthread_create(&t4, NULL, napi_thread, NULL);
    pthread_create(&t5, NULL, workqueue_thread, NULL);
    pthread_create(&t6, NULL, sysfs_thread, NULL);
    pthread_create(&t7, NULL, dev_thread, NULL);

    assert(!rf_check);
}
