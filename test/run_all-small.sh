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


if [ -z "${1:-}" ]
then
  die "First argument must be rank number to test"
fi

for d in ${TESTDIRS}
do
    echo "==================== Testing $d ===================="
    ./run_single.sh benchmarks/$d $1
    echo "======================= Done ======================="
done
