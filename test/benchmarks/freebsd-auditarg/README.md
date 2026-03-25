From ISSTA 2015 paper

\file freeBSD_audit1.c

Example program of a data race found in FreeBSD file audit_arg.c

Source: Z. Yin, D. Yuan, Y. Zhou, et al. How Do Fixes Become Bugs? A
Comprehensive Study on Incorrect Fixes in Commercial and Open Source
Operating Systems. September 2011.

This program demonstrates the original bug in audit_arg.c. There is a data
race on the variable unprotected in the function doWork(). 

The code was greatly simplified, but the bug is hopefully still reflective. 


