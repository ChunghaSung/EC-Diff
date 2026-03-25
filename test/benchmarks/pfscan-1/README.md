// Author: 
// Date: Apr 12 2018

 The patch has been done by adding lock regions with conditional statements.
 Two versions are test with locks & conds and without locks & conds.
 I kept the semantics of read/write operations in this program.
 This is not original code since it has been updated for testing purpose.
 Original code is from inspect paper (http://www.cs.utah.edu/~yuyang/inspect/)

The patch has been done by adding conditional statements with locks in worker thread.

void *worker1(void *arg)
{

    ...

    // patches
    pthread_mutex_lock(&aworker_lock);
    --aworkers_SHARED;
    pthread_mutex_unlock(&aworker_lock);
    pthread_cond_signal(&aworker_cv);
}

int main()
{
    ...
    pthread_mutex_lock(&aworker_lock);
    while (aworkers_SHARED > 0)
        pthread_cond_wait(&aworker_cv, &aworker_lock);
    pthread_mutex_unlock(&aworker_lock);
}


tested with

void *worker1(void *arg)
{

    ...

    // patches
    nop1();
    --aworkers_SHARED;
    nop1();
    nop1();
}

int main()
{
    ...
    nop1();
    while (aworkers_SHARED > 0)
        nop1();
    nop1();
}
