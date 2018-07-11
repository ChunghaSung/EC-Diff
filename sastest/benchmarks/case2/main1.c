#include <stdio.h>
#include <pthread.h>

//sas variable
#include <stdbool.h>
pthread_mutex_t sas0;
bool rf_read;
bool rf_write1;
bool rf_write2;
bool rf_check;


pthread_mutex_t a;
pthread_mutex_t b;
pthread_cond_t cond0;

int cond0_bool;

void nop1(void) {
    return;
}

int x_SHARED, y_SHARED, z_SHARED;
int temp_SHARED;
// thread id #x0001
void* thread1(void* arg) 
{
    pthread_mutex_lock(&a); //#xff00
    pthread_mutex_lock(&sas0);
    y_SHARED = 1;    // Wy
    if (!rf_read)
        rf_write1 = true;
    pthread_mutex_unlock(&sas0);

    int tmp = y_SHARED; // Ry
    if (!cond0_bool) {
        pthread_cond_wait(&cond0, &a);
    }
    x_SHARED = 1; // Wx
    tmp = z_SHARED; // Rz
    z_SHARED = 1;  // Wz
    pthread_mutex_unlock(&a); //#xff01
}

// thread id #x0002
void* thread2(void* arg) 
{
    pthread_mutex_lock(&a);
    pthread_mutex_lock(&sas0);
    y_SHARED = 1;    // Wy
    if (rf_write1 && !rf_read)
        rf_write2 = true;
    pthread_mutex_unlock(&sas0);

    pthread_mutex_lock(&sas0);
    int tmp = y_SHARED;  // Ry
    rf_read = true;
    if (rf_write1 && !rf_write2)
        rf_check = true;
    pthread_mutex_unlock(&sas0);

    tmp = x_SHARED;  // Rx
    cond0_bool = 1;
    pthread_cond_signal(&cond0);
    tmp = z_SHARED;  // Rz
    z_SHARED = 1; // Wz
    x_SHARED = 1;  
    pthread_mutex_lock(&a); //#xff04
}

int main()
{
    pthread_t t1, t2;
    
    rf_check = false;
    rf_write1 = false;
    rf_write2 = false;
    rf_read = false;

    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);

    assert(!rf_check);

    return 0;
}
