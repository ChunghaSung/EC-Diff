#include <assert.h>
#include <pthread.h>

int vec1_SHARED;
int vec2_SHARED;

int res_SHARED;

pthread_mutex_t mutex0;

void nop1() {}

void *thread1(void *args)
{
    int tmp = 0;
    int num = 0;
    tmp = 0;
    if(vec1_SHARED!=0)
        tmp = vec1_SHARED;
    vec1_SHARED = 0;
    num=res_SHARED;
    if(tmp!=0)
    {
        if((tmp==2) || 
                (tmp==3) || 

                (tmp==5) || 
                (tmp==7) || 
                (tmp==11) || 
                (tmp==13) || 
                (tmp==17) || 

                (tmp==19) || 
                (tmp==23) || 
                (tmp==29) || 
                (tmp==31) || 
                (tmp==37) || 

                (tmp==41) || 
                (tmp==43) || 
                (tmp==47) || 
                (tmp==53) || 
                (tmp==59) || 
                (tmp==61) || 

                (tmp==67) || 
                (tmp==71) || 
                (tmp==73) || 
                (tmp==79) || 
                (tmp==83) || 

                (tmp==89)) 
                pthread_mutex_lock(&mutex0);

        num = res_SHARED + 1;  
        res_SHARED = num;
        pthread_mutex_unlock(&mutex0);

    }

    return NULL;
}

void *thread2(void *args)
{
    int tmp = 0;
    int num = 0;
    tmp = 0;
    if(vec2_SHARED!=0)
        tmp = vec2_SHARED;
    vec2_SHARED = 0;
    num=res_SHARED;
    if(tmp!=0)
    {
        if((tmp==2) || 
                (tmp==3) || 
                (tmp==5) || 
                (tmp==7) || 
                (tmp==11) || 
                (tmp==13) || 
                (tmp==17) || 
                (tmp==19) || 
                (tmp==23) || 
                (tmp==29) || 
                (tmp==31) || 
                (tmp==37) || 
                (tmp==41) || 
                (tmp==43) || 
                (tmp==47) || 
                (tmp==53) || 
                (tmp==59) || 
                (tmp==61) || 
                (tmp==67) || 
                (tmp==71) || 
                (tmp==73) || 
                (tmp==79) || 
                (tmp==83) || 
                (tmp==89)) 
                pthread_mutex_lock(&mutex0);

        num = res_SHARED + 1;  
        res_SHARED = num;
        pthread_mutex_unlock(&mutex0);

    }
    return NULL;
}

int main() {
    res_SHARED = 0;
    vec1_SHARED = 11;
    vec2_SHARED = 23;
    pthread_t t1;
    pthread_t t2;

    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    if (res_SHARED != 2) {
        assert(0);
    }

    return 0;
}
