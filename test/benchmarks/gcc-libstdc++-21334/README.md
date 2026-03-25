ISSTA 2014 paper

Source: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=21334

### Description
Data race found in gcc's libstdc++ implementation of std::string. 

The source provides an example program (located also in `example_bug.cc`) and a
trace of the buggy interleaving.

The following is the trace:

> Consider the following scenario:

> -- Thread 2 executes first.  It gets to the expression
>    g.begin() (which for purposes of argument, we will suppose
>    is called before g.end() -- the problem will occur in which
>    ever function is called first), and starts executing it.

>    At this point, the value _M_refcount in the _Rep_base is 0,
>    since there is only one instance, g, which shares the
>    representation.  The representation is not "leaked", so we
>    call _M_leak_hard.

>    _M_leak_hard calls _M_rep()->_M_is_shared(), which returns
>    false.

> -- Thread 1 interupts.  Thread 2[1, typo] calls the copy constructor,
>    with g as a parameter, which ultimately calls _M_grab on the
>    _M_is_leaked() returns false, since the _M_refcount is still
>    0 in the representation.  Thread 2 thus calls _M_refcopy()
>    on the representation, which (atomically) increments
>    _M_refcount.  Thread 1 leaves the copy constructor.

> -- Now back to thread 2.   Since _M_is_shared() returned false,
>    thread 2 doesn't call _M_mutate -- is simply calls
>    _M_set_leaked() on the representation, which sets
>    _M_refcount to -1.

>    We will suppose that this modification is visible to all
>    other threads, despite the fact that there are no memory
>    barriers around it (which means that this supposition will
>    be false on certain platforms).

> -- And life goes on.  The second call to begin()/end() doesn't
>    change anything, because it finds that the representation is
>    already "leaked".

> -- Finally, suppose that thread 1 finishes while thread 1[2, typo] is
>    still using its iterators.  Thread 1 calls the destructor
>    for its string.  It sees that _M_refcount < 0, concludes
>    that the representation is leaked, and deletes it.  Despite
>    the fact that thread 2 still holds iterators refering to it,
>    and despite the fact that there is still a global variable
>    (usable after the pthread_joins in main) which depends on
>    it.

The problem is, of course, that the sequence which tests whether
we have to leak, and then leaks, is not atomic.

Note, I beleive there is a type in bullet 2, as noted by [1, typo]. The
reference should be to thread 1, not thread 2. 

## Example Program
A version of GCC that contains the bug is found in `gcc_3_4_branch.tar.gz`. As
of writing (2012-07-20) the bug is still in GCC. 

See http://gcc.gnu.org/install/ for how to install GCC.

A C implementation that follows the interleaving quoted above is in
`gcc_data_race.c`

Usage:
~~~~~~~~~~
gcc std_string.c gcc_data_race.c -lpthread
./a.out
~~~~~~~~~~

Enableing the preprocessor directive DEBUG and FORCE in `std_string.c` and
`gcc_data_race.c` shows that memory that has been free()'d is used when the
buggy interleaving occurs.

###Buggy Example Program Interleaving
Initially, `s->ref_count == 0`;
~~~~~~~~~~
Thread 1				|Thread 2
----------------------------------------|--------------------------------------
t1_main() {				|t2_main() {
    copy = s->fops.copy(s) {		|
	...				|
	s->ref_count += 1;		|   ...
	...				|
    }					|
					|   begin = s->fops.begin();
					|   end = s->fops.end(s) {
					|	...
					|	s->refcount = - 1;	
					|	...
					|	return s->string + s->used;
					|
					|   }
    s->fops.dest(s) {			|
	if (s->ref_count < 0) {		|
	    free(s->string)		|
	    ...				|
	}				|
    }					|
}					|
					|   memcpy(begin, "T", 1);
					|   memcpy(end, "O", 1);
					|}
~~~~~~~~~~

The above interleaving results in memory that has been free()'d being used

### Building GCC
Acording to http://gcc.gnu.org/install/prerequisites.html the following are
required to build GCC.

*   ISO C90 Compiler
*   POSIX Shell / GNU Bash
*   Awk
*   GNU binutils
*   gzip version 1.2.4 (or later) or
*   bzip2 version 1.0.2 (or later)
*   GNU Make 3.80 (or later)
*   GNU tar 1.14 (or later)
*   Perl version 5.6.1
*   jar or InfoZip (zip and unzip)
*   GNU Multiple Precision Library (GMP) version 4.3.2 (or later)
*   MPFR Library version 2.4.2 (or later)
*   MPC Library version 0.8.1 (or later)
*   ISL Library version 0.10
*   CLooG 0.17.0

See the above link for much more information.

