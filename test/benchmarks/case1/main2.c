#include <stdio.h>
#include <pthread.h>

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
    x_SHARED = 1;    //#x0000
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
    x_SHARED = 1;  
    temp_SHARED = x_SHARED; 
    temp_SHARED = y_SHARED;
    z_SHARED = 4;     //#x000a
    pthread_mutex_lock(&b); //#xff06
    x_SHARED = 1;
    temp_SHARED = y_SHARED;
    pthread_mutex_unlock(&b); //#xff07
    z_SHARED = 5;     //#x000d
    nop1();
}

int main()
{
    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);

    return 0;
}
