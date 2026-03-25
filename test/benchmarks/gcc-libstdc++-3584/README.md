From ISSTA 2014

Source: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=3584

### Description
Data race in GCC's libstdc++ in the ARM implementation of atomic functions.

The bug reporter provides an outline of how the implementation is not atomic.

~~~~~~~~~~
The atomic_add() for ARM (with instructions numbering):

static inline void
__attribute__ ((__unused__))
__atomic_add (volatile _Atomic_word *__mem, int __val)
{
  _Atomic_word __tmp, __tmp2, __tmp3;
  __asm__ __volatile__ (
        "\n"
        "0:\t"
1       "ldr     %0, [%3] \n\t"
2       "add     %1, %0, %4 \n\t"
3       "swp     %2, %1, [%3] \n\t"
4       "cmp     %0, %2 \n\t"
5       "swpne   %1, %2, [%3] \n\t"
6       "bne     0b \n\t"
7       ""
        : "=&r"(__tmp), "=&r"(__tmp2), "=&r"(__tmp3) 
        : "r" (__mem), "r"(__val) 
        : "cc", "memory");
}


Example of sequence that produces an invalid result (*__mem == 2 instead of 4 at
the end):

T1 (%0 %1 %2)   T2 (%0 %1 %2)   *__mem

1 (x x x) __val=1               0
2 (0 x x)
3 (0 1 x) <-- reschedule
                1 (x x x) __val=1
                2 (0 x x)
                3 (0 1 x)
                4 (0 1 0)       1
                5 (0 1 0)
                6 (0 1 0)
                7 (0 1 0)
                ...      <-- reschedule
4 (0 1 1)                       1
5 (0 1 1) <-- reschedule
                1 (x x x) __val=2
                2 (1 x x)
                3 (1 3 x)
                4 (1 3 1)       3
                5 (1 3 1)
                6 (1 3 1)
                7 (1 3 1)
                ....      <-- reschedule
6 (0 3 1)                       1
1 (0 3 1)
2 (1 3 1)
3 (1 2 1)
4 (1 2 1)                       2
5 (1 2 1)
6 (1 2 1)
7 (1 2 1)
....
~~~~~~~~~~

The bug is fixed with the following log message.


~~~~~~~~~~
Richard Earnshaw 2002-10-03 15:58:29 UTC

From: rearnsha@gcc.gnu.org
To: gcc-gnats@gcc.gnu.org
Cc:  
Subject: libstdc++/3584
Date: 3 Oct 2002 15:58:29 -0000

 CVSROOT:	/cvs/gcc
 Module name:	gcc
 Changes by:	rearnsha@gcc.gnu.org	2002-10-03 08:58:29
 
 Modified files:
 	libstdc++-v3   : ChangeLog 
 	libstdc++-v3/config/cpu/arm: atomicity.h 
 
 Log message:
 	PR libstdc++/3584
 	* config/cpu/arm/atomicity.h (__exchange_and_add): Don't try to use
 	ASM sequences that don't give us atomic addition operations.  Instead
 	just add a comment explaining why it doesn't work.
 	(__atomic_add): Just use __exchange_and_add.
 	(__test_and_set, __always_swap): Delete.
 
 Patches:
 http://gcc.gnu.org/cgi-bin/cvsweb.cgi/gcc/libstdc++-v3/ChangeLog.diff?cvsroot=gcc&r1=1.1374&r2=1.1375
 http://gcc.gnu.org/cgi-bin/cvsweb.cgi/gcc/libstdc++-v3/config/cpu/arm/atomicity.h.diff?cvsroot=gcc&r1=1.3&r2=1.4
~~~~~~~~~~

A revision that has the bug is 33317 (it has the file `atomicity.h` that has
the same `atomic_add()` functin as above. This revisio was checkout and and is
included in gcc.tar.gz

### Example program
An example program was used that simpley includes `atomicity.h` and runs the
function `atomic_add()` in two threads.

This is being done in an x86 machine so the example was not able to be tested
and very likely has bugs.

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
