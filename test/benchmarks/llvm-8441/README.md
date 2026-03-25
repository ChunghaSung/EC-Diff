From ISSTA 2015
## Readme

Author: Markus Kusano (mukusano@vt.edu)

Source: http://llvm.org/bugs/show_bug.cgi?id=8441

### Description
Data race and atomicity violation found in LLVM involving a structure
`AttributesList` which uses a reference count to determine when the structure
should be free()'d. 

The bug occurs due to lack of atomicity in the check if the structures
reference count is zero and it being free()'d. Inbetween the check and the
free() another thread could start using the structure and increment the
reference count. 

The following is the description of the bug from the bug tracker:

> This bug seems to be a race condition relating to the static AttributesList in
> Attributes.cpp. Access to the AttributesList is locked, but my theory for what
> was going on is that at line 125-126, when dropping a reference, we decrement
> the count, then check to see if it's zero, then delete "this" (if the refcount
> was zero). After we've checked that the count is zero, but before deleting
> "this", "this" is still in the AttributesLists set. So in the mean time,
> another thread comes along, finds "this" in AttributesList, and references it.
> But the first thread has already determined that the count *was* 0, and then
> comes back and deletes "this", even though it's now in use by the second
> thread.

The bug is fixed in SVN revision 118461. The following is the commit message:

~~~~~~~~~~
r118461 | resistor | 2010-11-08 19:27:03 -0500 (Mon, 08 Nov 2010) | 3 lines

Fix PR8441, a race condition in the static attributes list.  While the
reference counting was itself threadsafe,
the implicit removal of each object from the global list was not.  Make this
operation atomic.
~~~~~~~~~~

The bug comes with a test case. The test case can be used with the included
version of LLVM that has the bug. I have not tested the test case. See
`multiple_EE_failure.tar.gz` for more information. It would require building
the version of LLVM included in `llvm.tar.gz`.

The source included in `llvm.tar.gz` is the LLVM source previous to r118461
which is r118458. This should be the code that contains the bug.

### Example Program
An example program was created. See `llvm_8441_data_race.c` for more
information.

### Building LLVM
The only tool other than standard build tools required is CMake.

See http://llvm.org/docs/CMake.html for information on options that can be
used with CMake.
