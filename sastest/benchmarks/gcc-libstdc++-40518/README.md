From ISSTA 2014

Source: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=40518

### Description
Data race in GCC's libstdc++ implementation of `std::string.earase()`.

The bug reporter describes the bug as follows:

> from http://etbe.coker.com.au/2009/06/22/valgrindhelgrind-and-stl-string

simplified test case:
~~~~~~~~~~
#include <pthread.h>
#include <string>


void *do_work(void *)
{
    std::string s;
    s.erase();
    return 0;
}

int main()
{
    pthread_t tid[2];
    pthread_create(&tid[0], NULL, do_work, NULL);
    pthread_create(&tid[1], NULL, do_work, NULL);
    pthread_join(tid[0], NULL);
    pthread_join(tid[1], NULL);

    return 0;
}
~~~~~~~~~~

> Helgrind shows data races, because calling erase() on an empty string calls
> _M_set_length_and_sharable() on the shared empty _Rep object, which assigns
> zero to the refcount, length, and refdata[0].

> Those locations contain zero already, so as long as the writes are atomic then
> no values are modified, but it is a race.

Acording to the bug reporters source in GCC's implementation even distinct
strings have the potential to share some storage due to what is likely an
optimization. Specifically, they all share a Rep object. When erasing, the
function `_M_set_length_and_sharable()` sets all the values for the
refcount, length and first character of the empty string to 0 without using any
synchronization. This isn't the most severe bug since the values for an empty
string are already zero but since multiple threads can read and write the Rep
object it is still a data race.

The bug is fixed in GCC trunk revision 148850. It was fixed in the gcc_4.4
branch in revision 158190. The following is the commit message.

The revision previous in trunk (the revision with the bug) is 145841.

~~~~~~~~~
Subject: Bug 40518

Author: paolo
Date: Tue Jun 23 12:36:43 2009
New Revision: 148850

URL: http://gcc.gnu.org/viewcvs?root=gcc&view=rev&rev=148850
Log:
2009-06-23  Paolo Carlini  <paolo.carlini@oracle.com>

    PR libstdc++/40518
    * include/bits/basic_string.h (basic_string<>::_Rep::
    _M_set_length_and_sharable): Do not write the empty rep.
    (basic_string<>::erase(iterator, iterator)): Likewise,
    move out of line...
    * include/bits/basic_string.tcc: ... here.

Modified:
    trunk/libstdc++-v3/ChangeLog
    trunk/libstdc++-v3/include/bits/basic_string.h
    trunk/libstdc++-v3/include/bits/basic_string.tcc
~~~~~~~~~~

The Rep object is defined in `libstdc++-v3/include/bits/basic_string.h` as:

~~~~~~~~~~
struct _Rep_base
{
    size_type _M_length;
    size_type _M_capacity;
    _Atomic_word _M_refcount;
};
~~~~~~~~~~

The function `_M_set_length_and_shrable()` is also defined in `basic_string.h`

~~~~~~~~~~
	void
_M_set_length_and_sharable(size_type __n)
{
#ifndef _GLIBCXX_FULLY_DYNAMIC_STRING
    if (__builtin_expect(this != &_S_empty_rep(), false))
#endif
    {
	this->_M_set_sharable(); // One reference.
	this->_M_length = __n;
	traits_type::assign(this->_M_refdata()[__n], _S_terminal);
	// grrr. (per 21.3.4)
	// You cannot leave those LWG people alone for a second.
    }
}
~~~~~~~~~~

The bug is fixed by not calling `_M_mutate()` is the string's size is zero.

~~~~~~~~~~
typename basic_string<_CharT, _Traits, _Alloc>::iterator
basic_string<_CharT, _Traits, _Alloc>::
erase(iterator __first, iterator __last)
{
    _GLIBCXX_DEBUG_PEDASSERT(__first >= _M_ibegin() && __first <= __last
    && __last <= _M_iend());
 	  	  	
    // NB: This isn't just an optimization (bail out early when
    // there is nothing to do, really), it's also a correctness
    // issue vs MT, see libstdc++/40518.
    const size_type __size = __last - __first;
    if (__size)
    {
	const size_type __pos = __first - _M_ibegin();
	_M_mutate(__pos, __size, size_type(0));
	_M_rep()->_M_set_leaked();
	return iterator(_M_data() + __pos);
    }
    else
	return __first;
}
~~~~~~~~~~
I could not find a defintion of `_M_mutate()` but based on the Hellgrind logs
from the Source this appears to be what eventually changes the Rep object.

### Example Program
An example program that recreates the shared Rep object that is access by
multiple threads can be found in `gcc-libstdc++_40518_data_race.c`

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
