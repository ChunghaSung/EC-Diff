From ISSTA 2015
## Readme

### Source
Source: http://web.eecs.umich.edu/~jieyu/bugs/transmission-142.html

Transmission Source:
http://web.eecs.umich.edu/~jieyu/bugs/transmission-1.42/transmission-1.42.tar.bz2

The transmission source is also in the git repo

### Description
Example program documenting a data race/atomicity violation in Transmission-1.42.
There is assumed atomicity between two threads: the first initializes and the
second allocates. No synchronization is done between the two threads. In
Transmission-1.42, the allocation was to wait 500 milliseconds before starting,
so the programmer assumed that at this point the data was initialized.

See Source for a trace of the bug.

### Buggy Interleaving
~~~~~
Initially, bandwidth == NULL
Thread 1				|Thread 2
----------------------------------------|-------------------------------------
init(...) {				|allocate(...) {
					|
					|assert(bandwidth != NULL);
    bandwidth = malloc(sizeof(char));	|
~~~~~

There is no atomicity between spawning a thread to  init() and then spawning a
thread to  allocate() 

### Building Transmission
I could not find any information in the included tarball
(transmission-1.42.tar.bz) as to what dependencies were required to build
transmission.

Acording to http://cblfs.cross-lfs.org/index.php/Transmission (Linux from
Scratch) only the following are required:

*   OpenSSL
*   Curl

The following are reccomended:

*   Gtk2
*   D-BUS Glib
*   libnotify 

I'm not sure which of the above are required to hit the buggy interleaving. Jie
Yu (Source) documents what is required to hit the interleaving.
