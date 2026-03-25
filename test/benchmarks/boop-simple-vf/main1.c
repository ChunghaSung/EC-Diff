#include <pthread.h>
#include <assert.h>

//extern int __VERIFIER_nondet_int();	//I added this! CBMC was saying this was not declared
//#define assert(e) { if(!(e)) { ERROR: goto ERROR; (void)0; } }

int usecount_SHARED;
int locked_SHARED;
int flag1_SHARED = 0;
int flag2_SHARED = 0;
int release_thr1_SHARED = 0;

pthread_mutex_t mutex0;

void nop1(){}

void* thr2 (void* arg) //dummy_open
{
    //while(!release_thr1_SHARED);
    nop1();

    //__VERIFIER_assume(release_thr1_SHARED);

    usecount_SHARED = usecount_SHARED + 1;

    if (locked_SHARED)
        return 0;
    locked_SHARED = 1;
    flag1_SHARED = 1;
    nop1();

    return 0;
}

/*
inline void dummy_release ()
{
    usecount_SHARED = usecount_SHARED - 1;
    locked_SHARED = 0;
    return;
}

inline void unregister_chrdev ()
{
    if (usecount_SHARED != 0)
    {
        // this should fail
        assert (0);
    }
    else
        return;
}
*/

void* thr1 (void* arg)
{
    void* rval;
    int count;

    usecount_SHARED = 0;
    locked_SHARED = 0;

    nop1();

    release_thr1_SHARED = 1;

    /*
       while(1)
       {
       if(flag1_SHARED)
       break;
       }
     */
    //__VERIFIER_assume(flag1_SHARED);



    /*
       do {
       rval = (void*)__VERIFIER_nondet_int();
       if (rval == 0) {
       count = 1;
       dummy_release();
       }
       else {
       count = 0;
       }
       } while	(count != 0);
     */
    // Manually unrolled
    //rval = (void*)__VERIFIER_nondet_int();
    rval = (void*)1;
    if (rval == 0) {
        count = 1;
        //dummy_release();
        usecount_SHARED = usecount_SHARED - 1;
        locked_SHARED = 0;
    }
    else {
        count = 0;
    }

    //dummy_release ();
    usecount_SHARED = usecount_SHARED - 1;
    locked_SHARED = 0;

    //unregister_chrdev ();
    if (usecount_SHARED != 0)
    {
        // this should fail
        assert (0);
    }

    nop1();

    return 0;
}

int main(){

    pthread_t t1, t2;

    flag1_SHARED = 0;
    flag2_SHARED = 0;
    release_thr1_SHARED = 0;

    pthread_create(&t1, 0, thr1, 0);
    //while(1) { pthread_create(&t, 0, thr2, 0); }
    pthread_create(&t2, 0, thr2, 0);

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
}

