#include <stdio.h>
#include <pthread.h>

// sas variables
#include <stdbool.h>
pthread_mutex_t sas0;
bool rf_read;
bool rf_write1;
bool rf_write2;
bool rf_write3;
bool rf_check;


pthread_mutex_t a;
pthread_mutex_t b;

void nop1(void) {
    return;
}

int x_SHARED, y_SHARED, z_SHARED;
int temp_SHARED;
// thread id #x0001
void* thread1(void* arg) 
{
    nop1();

    pthread_mutex_lock(&sas0);
    x_SHARED = 1;    //#x0000
    if (!rf_read)
        rf_write1 = true;
    pthread_mutex_unlock(&sas0);

    temp_SHARED = x_SHARED; 
    y_SHARED = 1;
    z_SHARED = 2;    //#x0003
    pthread_mutex_lock(&b); //#xff02
    temp_SHARED = x_SHARED;
    y_SHARED = 2;
    pthread_mutex_unlock(&b); //#xff03
    z_SHARED = 3;

    nop1();
}

// thread id #x0002
void* thread2(void* arg) 
{
    nop1();

    pthread_mutex_lock(&sas0);
    x_SHARED = 1;    //#x0000
    if (rf_write1 && !rf_read)
        rf_write2 = true;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas0);
    temp_SHARED = x_SHARED; 
    rf_read = true;
    if (rf_write1 && !rf_write2 && !rf_write3)
        rf_check = true;
    pthread_mutex_unlock(&sas0);


    temp_SHARED = y_SHARED;
    z_SHARED = 4;     //#x000a
    pthread_mutex_lock(&b); //#xff06

    pthread_mutex_lock(&sas0);
    x_SHARED = 1;    //#x0000
    if (rf_write1 && !rf_read)
        rf_write3 = true;
    pthread_mutex_unlock(&sas0);

    temp_SHARED = y_SHARED;
    pthread_mutex_unlock(&b); //#xff07
    z_SHARED = 5;     //#x000d
    nop1();
}

int main()
{
    pthread_t t1, t2;

    rf_write1 = false;
    rf_write2 = false;
    rf_write3 = false;
    rf_check = false;
    rf_read = false;


    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);

    assert(!rf_check);

    return 0;
}
