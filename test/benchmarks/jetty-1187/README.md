from ISSTA 2014 paper

Source: http://www.ibm.com/developerworks/java/library/j-concurrencybugpatterns/

Bug Report: http://jira.codehaus.org/browse/JETTY-1187

### Description

An atomicity violation found in Jetty involving non atomic increments of a
shared variable.

Specifically, the variable is used as follows:

~~~~~~~~~~
private volatile int _set;
......
public void register(SocketChannel channel, Object att)
{
   int s=_set++;
   ......
}
......
public void addChange(Object point)
{
   synchronized (_changes)
   {
      ......
   }
}
~~~~~~~~~~

`_set` is declared as volatile mean it can be accessed by multiple threads. The
increment of _set is not guaranteed to be atomic on the Java Virtual Machine
(it is a read-modify-write operation).

The following is an example of a buggy interleaving in pseudo-assembly

~~~~~~~~~~
Thread 1				|Thread 2
----------------------------------------|--------------------------------------
load _set R1				|
addl 1 R1				|
					|load _set R1
					|addl 1 R1
					|mov R1 _set
mov R1 _set				|
~~~~~~~~~~

The above interleaving shows two threads concurrently incrementing `_set` by 1.
If set was zero to begin with, the above interleaving would result in `_set`
being 1 where it should be 2.

### Example Program
An example program was written in C using PThreads. See `jetty_atom_violation.c`

### Buggy Source
The bug is found in in the file
`./modules/jetty/src/main/java/org/mortbay/io/nio/SelectorManager.java`. I
downloaded `jetty-6.1.3` and it appears to have the bug.

The following are snippits from `SelectorManager.java` that outlines functions
where the bug can occur.

~~~~~~~~~~
public abstract class SelectorManager extends AbstractLifeCycle
{
    ...
    private volatile int _set;
    ...

    
    /* ------------------------------------------------------------ */
    /** Register a serverchannel
     * @param acceptChannel
     * @return
     * @throws IOException
     */
    public void register(ServerSocketChannel acceptChannel) throws IOException
    {
        int s=_set++; 
        s=s%_selectSets;
        SelectSet set=_selectSet[s];
        set.addChange(acceptChannel);
    }
    ...
}
~~~~~~~~~~

If two threads call `register()` then there is a potential for a data race on
the read-modify-write of `_set`.

The Jetty source with the bug is found in `jetty-6.1.3.zip`.

### Building Jetty
Jetty uses JDK6 to build and Maven for managing the build.
