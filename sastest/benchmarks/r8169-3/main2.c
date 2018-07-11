#include <stdio.h>
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


//int napi_poll_SHARED = 0;
pthread_mutex_t napi_poll;
int shutdown_SHARED = 0;

/*
void stuff1();
void stuff2();
void stuff3();
*/

//#pragma region threads

/*Thread 1 (Interface down thread)
==================================*/

// driver entry point
void* thread1(void* arg)
{
///*(2)*/ lock(napi_poll); // disable NAPI loop
    pthread_mutex_lock(&napi_poll);
    pthread_mutex_lock(&sas0);
    shutdown_SHARED = 1;
    if (!rf_read)
        rf_write0 = true;
    pthread_mutex_unlock(&sas0);
// /*(1)*/ stuff1();
    pthread_mutex_unlock(&napi_poll);
}

/*
void stuff1() {
	shutdown = 1;
}
*/

/*Thread 2 (Shutdown thread)
===========================*/

// OS model
void* thread2(void* arg)
{
    // Call rtl_shutdown at random point
    //rtl_shutdown();
    //return;
}

/*
void stuff2() {
}

// driver entry point
void rtl_shutdown()
{
	stuff2();
};
*/


/*Thread 3 (NAPI thread)
======================*/

// OS model
void* thread3(void* arg)
{
	//lock(napi_poll);
    pthread_mutex_lock(&napi_poll);

	//rtl8169_poll();
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write1 = true;
    shutdown_SHARED = 0;
    pthread_mutex_unlock(&sas0);


    pthread_mutex_lock(&sas0);
    if (shutdown_SHARED != 0) {
        //assert(0);
    }
    rf_read = true;
    if (rf_write0 && !rf_write1 && !rf_write2)
        rf_check = true;
    pthread_mutex_unlock(&sas0);




    pthread_mutex_unlock(&napi_poll);
	//unlock(napi_poll);
}

// driver entry point
/*
void rtl8169_poll()
{
	stuff3();
}

void stuff3() {
	assert(shutdown == 0);
}
*/

//#pragma endregion threads

void main() {
    /*
	napi_poll = 0;
	shutdown = 0;
    */
    rf_read = false;
    rf_check = false;
    rf_write0 = false;
    rf_write1 = false;
    rf_write2 = false;


    //napi_poll_SHARED = 0;
    pthread_mutex_lock(&sas0);
    if (!rf_read & rf_write0)
        rf_write2 = true;
    shutdown_SHARED = 0;
    pthread_mutex_unlock(&sas0);

    pthread_t t1, t2, t3;
    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);
    pthread_create(&t3, NULL, thread3, NULL);

    assert(!rf_check);
}
