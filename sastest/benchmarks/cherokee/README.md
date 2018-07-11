 From ISSTA 2014 paper

 Source: http://web.eecs.umich.edu/~jieyu/bugs/cherokee-bug1.html
 Source code with bug:
 http://web.eecs.umich.edu/~jieyu/bugs/cherokee-bug1/cherokee-0.9.2.tar.gz

 Atomicity violation and data race found in cherokee-0.9.2. 

 The function bufferUpdate() contains assumed atomicity between calls to
 memcpy() and updates of the bytes used in a buffer 
