#!/bin/bash

set -u

source ./testDir-small.sh

TIME="`which time` -f %e"


for d in ${TESTDIRS}
do
    echo "==================== Testing $d ===================="
    timeout 3600s  $TIME -o benchmarks/$d/results/main1_time.time ./cbmc benchmarks/$d/main1.c --unwind 2 > benchmarks/$d/results/main1_result.out
    ret=$?
    if [ "$ret" -eq "124" ]
    then
        echo "TIMEOUT"
    fi

    timeout 3600s $TIME -o benchmarks/$d/results/main2_time.time ./cbmc benchmarks/$d/main2.c --unwind 2 > benchmarks/$d/results/main2_result.out
    ret=$?
    if [ "$ret" -eq "124" ]
    then
        echo "TIMEOUT"
    fi
    echo "======================= Done ======================="
done
