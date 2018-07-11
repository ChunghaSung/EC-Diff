From ISSTA 2014

Source: http://gcc.gnu.org/bugzilla/show_bug.cgi?id=25330

### Description
Data race in gcc's java write_classfile.

The bug reporter notes that there are two problems:

> 1. All processes use the same temporary_file_name. If 2 processes try to
> write to the same class file, we are in trouble.
> 2. errno returned from rename is accessed after remove call which
> may change errno.

The bug is fixed in GCC trunk svn revision 108411. The following is the commit
message.

~~~~~~~~~~
Subject: Bug 25330

Author: hjl
Date: Mon Dec 12 15:27:43 2005
New Revision: 108411

URL: http://gcc.gnu.org/viewcvs?root=gcc&view=rev&rev=108411
Log:
2005-12-12  H.J. Lu  <hongjiu.lu@intel.com>

    PR java/25330
    * jcf-write.c (write_classfile): Use PID in temporary class
    file. Save/restore errno when reporting error.

Modified:
    trunk/gcc/java/ChangeLog
    trunk/gcc/java/jcf-write.c
~~~~~~~~~~

The revision previous (the one with the bug) is 102182).

The bug dealing with errno occurs in the following:

~~~~~~~~~~
if (rename (temporary_file_name, class_file_name) == -1)
{
    int errno_saved = errno;
    remove (temporary_file_name);
    errno = errno_saved;
    fatal_error ("can't create %s: %m", class_file_name);
}
~~~~~~~~~~
If `rename()` returns -1 then `errno` is set. However, if the subsequent call
to `remove()` fails then errno will be set and the original value returned by
`rename()` will be overwritten.

The program calls a function `fatal_error()` which I could not find a
definition of in the codebase. Based on the context, I assume that it access `errno`.


### Example Program
The example is much simplified and focuses on the two points made by the bug
reporter.

Two threads open a temporary file with the same name. They write to the file, attempt to rename it and then remove the temporary file.

The program creates a file called `delete_me` which is the result of the operations. 

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
