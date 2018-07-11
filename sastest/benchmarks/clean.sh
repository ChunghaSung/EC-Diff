#!/bin/bash

set -u

source ../testDir-mid.sh


for d in ${TESTDIRS}
do
    rm -f $d/*.bc
    rm -f $d/*.instMap.txt
    rm -f $d/*.threadMap.txt
    rm -f $d/*.lockMap.txt
    rm -f $d/*.ll
    rm -f $d/*.out
    rm -f $d/*.time
    rm -f $d/*.smt2
done
