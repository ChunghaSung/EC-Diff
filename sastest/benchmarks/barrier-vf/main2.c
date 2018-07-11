#include <pthread.h>


// sas vars
#include <stdbool.h>
#include <assert.h>
pthread_mutex_t sas0;
bool rf_check;
bool rf_read;
bool rf_write0;
bool rf_write1;
bool rf_write2;
bool rf_write3;
bool rf_write4;
bool rf_write5;


pthread_cond_t cond2 = PTHREAD_COND_INITIALIZER;
int cond2_bool = 0;
pthread_mutex_t mutex2 = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond1 = PTHREAD_COND_INITIALIZER;
int cond1_bool = 0;
pthread_mutex_t mutex1 = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond0 = PTHREAD_COND_INITIALIZER;
int cond0_bool = 0;
pthread_mutex_t mutex0 = PTHREAD_MUTEX_INITIALIZER;

//#define assume(e) __VERIFIER_assume(e)
//#define assert(e) { if(!(e)) { ERROR: goto ERROR; (void)0; } }

void nop1(){}

volatile unsigned int count_SHARED = 0; //shared
int c_SHARED;
//_Bool MTX = 0; //shared mutex
//_thread Bool COND = 0; //condition variables become local flag indicating whether the thread was signaled

/*
void __VERIFIER_atomic_acquire()
{
    assume(MTX==0);
    MTX = 1;
}

void __VERIFIER_atomic_release()
{
    assume(MTX==1);
    MTX = 0;
}
*/

/*
#define cnd_wait(c,m){ \
    __VERIFIER_atomic_begin(); \
    assume(c); \
    c = 0; \
    __VERIFIER_atomic_end(); }

#define cnd_broadcast(c) (c = 1) //BP must be post-processed manually by changing "b*_COND := 1" to "b*_COND$ := 1"
*/


void* thr1(void* arg){

    pthread_mutex_lock(&mutex0);
    cond0_bool = 1;
    pthread_cond_signal(&cond0);
    pthread_mutex_unlock(&mutex0);

    pthread_mutex_lock(&mutex1);
    cond1_bool = 1;
    pthread_cond_signal(&cond1);
    pthread_mutex_unlock(&mutex1);

    pthread_mutex_lock(&mutex2);
    if (!cond2_bool) {
        pthread_cond_wait(&cond2, &mutex2);
    }
    pthread_mutex_unlock(&mutex2);

    int tmp = count_SHARED + 1;

    pthread_mutex_lock(&sas0);
    count_SHARED = tmp;
    if (!rf_read)
        rf_write0 = true;
    pthread_mutex_unlock(&sas0);



    if (count_SHARED > 0) { 
        //cnd_broadcast(COND); 
        c_SHARED = 1;
        pthread_mutex_lock(&sas0);
        count_SHARED = 0; 
        if (!rf_read && rf_write0)
            rf_write1 = true;
        pthread_mutex_unlock(&sas0);
        return 0;
    }

    c_SHARED = 0;
    //cnd_wait(COND,MTX);
    //assert(0);

    return 0;
} 

void* thr2(void* arg){

    pthread_mutex_lock(&mutex0);
    if (!cond0_bool) {
        pthread_cond_wait(&cond0, &mutex0);
    }
    pthread_mutex_unlock(&mutex0);

    pthread_mutex_lock(&sas0);
    int tmp = count_SHARED + 1;
    rf_read = true;
    if (rf_write0 && !rf_write1 && !rf_write2 && !rf_write3 && !rf_write4 && !rf_write5)
        rf_check = true;
    pthread_mutex_unlock(&sas0);


    pthread_mutex_lock(&sas0);
    count_SHARED = tmp;
    if (!rf_read && rf_write0)
        rf_write2 = true;
    pthread_mutex_unlock(&sas0);



    pthread_mutex_lock(&mutex2);
    cond2_bool = 1;
    pthread_cond_signal(&cond2);

    if (count_SHARED > 0) { 
        //cnd_broadcast(COND); 
        c_SHARED = 1;

        pthread_mutex_lock(&sas0);
        count_SHARED = 0; 
        if (!rf_read && rf_write0)
            rf_write3 = true;
        pthread_mutex_unlock(&sas0);

        return 0;
    }
    pthread_mutex_unlock(&mutex2);

    c_SHARED = 0;
    //assert(0);

    return 0;
} 

void* thr3 (void* arg){
    pthread_mutex_lock(&mutex1);
    if (!cond1_bool) {
        pthread_cond_wait(&cond1, &mutex1);
    }
    pthread_mutex_unlock(&mutex1);

    int tmp = count_SHARED + 1;

    pthread_mutex_lock(&sas0);
    count_SHARED = tmp;
    if (!rf_read && rf_write0)
        rf_write4 = true;
    pthread_mutex_unlock(&sas0);

    if (count_SHARED > 0) { 
        //cnd_broadcast(COND); 
        c_SHARED = 1;

        pthread_mutex_lock(&sas0);
        count_SHARED = 0; 
        if (!rf_read && rf_write0)
            rf_write5 = true;
        pthread_mutex_unlock(&sas0);

        return 0;
    }
    //cnd_wait(COND,MTX);
    c_SHARED = 0;
    //assert(0);

    return 0;
} 

int main(){
    pthread_t t1, t2, t3;

    rf_check = false;
    rf_read = false;
    rf_write0 = false;
    rf_write1 = false;
    rf_write2 = false;
    rf_write3 = false;
    rf_write4 = false;
    rf_write5 = false;


    //while(1) { pthread_create(&t, 0, thr1, 0); }
    pthread_create(&t1, 0, thr1, 0);
    pthread_create(&t2, 0, thr2, 0);
    pthread_create(&t3, 0, thr3, 0);

    assert(!rf_check);

    return 0;
}
