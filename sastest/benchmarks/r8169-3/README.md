// Modified by Chungha Sung
// This code is a modified version for standard C style
// from Abstract (Semantic) Diffing of Evolving Concurrent Programs [Bouajjani et al.] in SAS 2017.
// And, there is no any semantic difference from the original code.
// The original code is r8169-3-buggy.c

/* This example from the r8169 driver illustrates the REORDER.LOCK pattern.

 The example consists of three threads.*/

/*
The above code contains calls to functions stuff1(), stuff2(), 
stuff3().  These functions represent device-specific code that 
accesses device registers.  Since we do not have an accurate 
device model, we have to assume that these functions are not 
commutative and are only safe to execute in the order consistent 
with sequential execution.

Consider lines (1) and (2).  (2) disables the NAPI thread: 
after this lines has been executed, no new calls to the 
rtl8169_poll method will be performed.  In the simplified 
concurrency model the rtl8169_poll entry point cannot be invoked 
while rtl8169_down is running.  As a result, this model rules out 
any execution where stuff3() is called after stuff1().  

In the realistic concurrency model, a call to rtl8169_poll can 
occur between (1) and (2), thus violating the above invariant.  
This race can be eliminated by simply reordering lines (1) and 
(2), which is exactly what the RTL driver does.
*/
#if 0
int napi_poll = 0;
int shutdown = 0;

void stuff1();
void stuff2();
void stuff3();

#pragma region threads

/*Thread 1 (Interface down thread)
==================================*/

// driver entry point
void thread1()
{
/*(1)*/ stuff1();
/*(2)*/ lock(napi_poll); // disable NAPI loop
}

void stuff1() {
	shutdown = 1;
}

/*Thread 2 (Shutdown thread)
===========================*/

// OS model
void thread2()
{
    // Call rtl_shutdown at random point
    rtl_shutdown();
}

void stuff2() {
}

// driver entry point
void rtl_shutdown()
{
	stuff2();
};


/*Thread 3 (NAPI thread)
======================*/

// OS model
void thread3()
{
	lock(napi_poll);
	rtl8169_poll();
	unlock(napi_poll);
}

// driver entry point
void rtl8169_poll()
{
	stuff3();
}

void stuff3() {
	assert(shutdown == 0);
}

#pragma endregion threads

void main() {
	napi_poll = 0;
	shutdown = 0;
	thread1();
	thread2();
	thread3();
}

