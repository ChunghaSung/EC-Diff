#include <pthread.h>
#include <assert.h>


int i_SHARED=1, j_SHARED=1;

pthread_cond_t cond0 = PTHREAD_COND_INITIALIZER;
int cond0_bool = 0;
pthread_mutex_t mutex0 = PTHREAD_MUTEX_INITIALIZER;

// Manually unrolled
#define NUM 6

void nop1() {}

void *t1(void* arg)
{
    nop1();
    if (!cond0_bool) {
        nop1();
    }
    nop1();

    i_SHARED+=j_SHARED;
    i_SHARED+=j_SHARED;
    i_SHARED+=j_SHARED;
    i_SHARED+=j_SHARED;
    i_SHARED+=j_SHARED;
    i_SHARED+=j_SHARED;
    pthread_exit(NULL);
}

void *t2(void* arg)
{
    i_SHARED+=j_SHARED;
    i_SHARED+=j_SHARED;
    i_SHARED+=j_SHARED;
    i_SHARED+=j_SHARED;
    i_SHARED+=j_SHARED;
    i_SHARED+=j_SHARED;
    pthread_exit(NULL);
}

int main(int argc, char **argv)
{
    pthread_t id1, id2;

    pthread_create(&id1, NULL, t1, NULL);
    pthread_create(&id2, NULL, t2, NULL);

    pthread_join(id2, NULL);

    nop1();
    cond0_bool = 1;
    nop1();

    if (i_SHARED >= 377 || j_SHARED >= 377) {
        nop1();
        assert(0);
    }

    return 0;
}
