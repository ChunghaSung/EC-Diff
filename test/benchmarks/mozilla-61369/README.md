From ISSTA 2015

## Readme

## Source
Source: Learning from Mistakes - A comprehensive study on Real World
Concurrency Bug Characteristics. Shan Lu, Soyeon Park, Eunsoo Seo and Yuanyuan
Zhou.

Bug Report: https://bugzil.la/61369

## Description
Example program of a data race and atomicity violation found in Mozilla.  One
thread is set to initialize an object and another thread could end up using the
object before it is initialized.

## Buggy Interleaving
~~~~~
Thread 1			    |Thread 2
------------------------------------|-----------------------------------------
int main() {			    |void *threadInit(...) 
    ...				    |
    getState = *mthread.state;	    |
				    |mthread.state = malloc(sizeof(...));
~~~~~
				
This interleaving results in a seg fault

From the paper, the following was the given code snippet.

~~~~~
Thread1				    |Thread 2
------------------------------------|-----------------------------------------
void init(...) {		    |void Main(...) {
				    | mtState = mThread->state
    mThread=PR_CREATE_THREAD(...)   | 
}				    |}
~~~~~

It is hoped that the example program created shows the same type of bug, but
the mozilla source code with the bug was never retrieved and analyzed

