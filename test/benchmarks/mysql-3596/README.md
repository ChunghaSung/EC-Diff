## Readme

### Source
Source: S. Lu, S. Park, E. Seo, Y. Zhou. Learning Mistakes - A Comprehensive
Study on Real World Concurrency Bug Characteristics

More Info: http://web.eecs.umich.edu/~jieyu/bugs/mysql-3596.html

MySQL Source:
http://web.eecs.umich.edu/~jieyu/bugs/mysql-3596/mysql-4.0.19.tar.gz

The source is also hosted on the git repo.

Bug report: http://bugs.mysql.com/bug.php?id=3596

### Description
Program that demonstrates an atomicity violation and data race found in MySQL
4.0.19. The bug can be found in the files ha_innodb.cc and sql_parse.cc

The function checks that a value is non NULL and then uses the value. However,
another thread could have altered the value to be NULL after the check and
before the value was used.

### Buggy Interleaving
~~~~~
Thread 1				|Thread 2
----------------------------------------|-------------------------------------
if (thd->proc_info) {			|...
					|thd->proc_info = NULL
    fputs(thd->proc_info, ...);		|...
}					|
(in ha_innodb.cc)			|(in sql_parse.cc)
~~~~~


### Implementation
Two functions were written: use() and delete(). They both use or delete the
same shared data respectively. Depending on the scheduling order, use() may use
data that has been deleted.

The two functions are spawned in threads from the main thread. It is intended
that the data is used and then freed. However, since there are no locks on the
data it can be set to NULL before it is used which results in a segmentation
fault.

### Building MySQL 
Acording to `INSTALL-SOURCE` which is included in the root of the included
MySQL source tarball the following are required to build MySQL:

* gunzip
* tar
* ANSI C++ Compiler
* make

The Linux version also requires `LinuxThreads` which is, I believe, no longer
found in glibc.
