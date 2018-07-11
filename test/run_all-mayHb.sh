#!/bin/bash

set -u

source ./exports.sh
source ./testDir-small.sh


die () {
  if [ ! -z "${@:-}" ]
  then
    echo ${@}
  fi
  exit 1
}



for d in ${TESTDIRS}
do
    echo "==================== Testing $d ===================="
    ./mayhb_single.sh benchmarks/$d
    echo "======================= Done ======================="
done

source ./testDir-large.sh

for d in ${TESTDIRS}
do
    echo "==================== Testing $d ===================="
    ./mayhb_single.sh benchmarks/$d
    echo "======================= Done ======================="
done
