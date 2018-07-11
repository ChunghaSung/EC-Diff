#!/bin/bash

set -u

source ./exports.sh


die () {
  if [ ! -z "${@:-}" ]
  then
    echo ${@}
  fi
  exit 1
}


if [ -z "${1:-}" ]
then
  die "First argument must be the directory to test"
fi


if [ ! -d "${1:-}" ] 
then
  echo "Test directory not found: $1"
  exit 1
fi


echo "Entering $1 directory.."
cd $1

#build_single_pp
build_single

echo "Making z3 files..."

OUTPUT4_BEFORE="p1MayHB-before.smt2"
OUTPUT5_BEFORE="p2MayHB-before.smt2"


# make all.smt2 first
cat ${TEST_PATH}/general_rules-before.smt2 > ${OUTPUT4_BEFORE}
cat ${TEST_PATH}/general_rules-before.smt2 > ${OUTPUT5_BEFORE}



cat main1.ll.facts.smt2 >> ${OUTPUT4_BEFORE}
cat main1.ll.facts.smt2 >> ${OUTPUT5_BEFORE}

cat main2.ll.facts.smt2 >> ${OUTPUT4_BEFORE}
cat main2.ll.facts.smt2 >> ${OUTPUT5_BEFORE}

cat ${TEST_PATH}/queries/mayHbP1.smt2 >> ${OUTPUT4_BEFORE}
echo "${OUTPUT4_BEFORE} is created. It can be tested with Z3"
cat ${TEST_PATH}/queries/mayHbP2.smt2 >> ${OUTPUT5_BEFORE}
echo "${OUTPUT5_BEFORE} is created. It can be tested with Z3"


# Run z3
echo "Run z3 with ${OUTPUT4_BEFORE} ... "
$TIME -o results/p1MayHB-before-solve.time z3 ${OUTPUT4_BEFORE} > results/p1MayHB-before-solve.out
echo "Run z3 with ${OUTPUT5_BEFORE} ... "
$TIME -o results/p2MayHB-before-solve.time z3 ${OUTPUT5_BEFORE} > results/p2MayHB-before-solve.out


cd ../..
