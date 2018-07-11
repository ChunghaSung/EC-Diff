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

if [ -z "${2:-}" ]
then
  die "Second argument must be rank number to test"
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

#OUTPUT1_BEFORE="check-rank${2}-before.smt2"
#OUTPUT2_BEFORE="p1-p2-rank${2}-before.smt2"
#OUTPUT3_BEFORE="p2-p1-rank${2}-before.smt2"
#OUTPUT4_BEFORE="p1MayHB-before.smt2"
#OUTPUT5_BEFORE="p2MayHB-before.smt2"

OUTPUT1_AFTER="check-rank${2}-after.smt2"
OUTPUT2_AFTER="p1-p2-rank${2}-after.smt2"
OUTPUT3_AFTER="p2-p1-rank${2}-after.smt2"
#OUTPUT4_AFTER="p1MayHB-after.smt2"
#OUTPUT5_AFTER="p1MayHB-after.smt2"

# make all.smt2 first
#cat ${TEST_PATH}/general_rules-before.smt2 > ${OUTPUT1_BEFORE}
#cat ${TEST_PATH}/general_rules-before.smt2 > ${OUTPUT2_BEFORE}
#cat ${TEST_PATH}/general_rules-before.smt2 > ${OUTPUT3_BEFORE}
#cat ${TEST_PATH}/general_rules-before.smt2 > ${OUTPUT4_BEFORE}
#cat ${TEST_PATH}/general_rules-before.smt2 > ${OUTPUT5_BEFORE}

cat ${TEST_PATH}/general_rules-after.smt2 > ${OUTPUT1_AFTER}
cat ${TEST_PATH}/general_rules-after.smt2 > ${OUTPUT2_AFTER}
cat ${TEST_PATH}/general_rules-after.smt2 > ${OUTPUT3_AFTER}
#cat ${TEST_PATH}/general_rules-after.smt2 > ${OUTPUT4_AFTER}
#cat ${TEST_PATH}/general_rules-after.smt2 > ${OUTPUT5_AFTER}



# add additional rules in terms of ranks
#cat ${TEST_PATH}/rank$2_rules.smt2 >> ${OUTPUT1_BEFORE}
#cat ${TEST_PATH}/rank$2_rules.smt2 >> ${OUTPUT2_BEFORE}
#cat ${TEST_PATH}/rank$2_rules.smt2 >> ${OUTPUT3_BEFORE}
cat ${TEST_PATH}/rank$2_rules.smt2 >> ${OUTPUT1_AFTER}
cat ${TEST_PATH}/rank$2_rules.smt2 >> ${OUTPUT2_AFTER}
cat ${TEST_PATH}/rank$2_rules.smt2 >> ${OUTPUT3_AFTER}

#cat main1.ll.facts.smt2 >> ${OUTPUT1_BEFORE}
#cat main1.ll.facts.smt2 >> ${OUTPUT2_BEFORE}
#cat main1.ll.facts.smt2 >> ${OUTPUT3_BEFORE}
#cat main1.ll.facts.smt2 >> ${OUTPUT4_BEFORE}
#cat main1.ll.facts.smt2 >> ${OUTPUT5_BEFORE}
cat main1.ll.facts.smt2 >> ${OUTPUT1_AFTER}
cat main1.ll.facts.smt2 >> ${OUTPUT2_AFTER}
cat main1.ll.facts.smt2 >> ${OUTPUT3_AFTER}
#cat main1.ll.facts.smt2 >> ${OUTPUT4_AFTER}
#cat main1.ll.facts.smt2 >> ${OUTPUT5_AFTER}

#cat main2.ll.facts.smt2 >> ${OUTPUT1_BEFORE}
#cat main2.ll.facts.smt2 >> ${OUTPUT2_BEFORE}
#cat main2.ll.facts.smt2 >> ${OUTPUT3_BEFORE}
#cat main2.ll.facts.smt2 >> ${OUTPUT4_BEFORE}
#cat main2.ll.facts.smt2 >> ${OUTPUT5_BEFORE}
cat main2.ll.facts.smt2 >> ${OUTPUT1_AFTER}
cat main2.ll.facts.smt2 >> ${OUTPUT2_AFTER}
cat main2.ll.facts.smt2 >> ${OUTPUT3_AFTER}
#cat main2.ll.facts.smt2 >> ${OUTPUT4_AFTER}
#cat main2.ll.facts.smt2 >> ${OUTPUT5_AFTER}

## copy query to all.smt2
#cat ${TEST_PATH}/queries/check.smt2 >> ${OUTPUT1_BEFORE}
#echo "${OUTPUT1_BEFORE} is created. It can be tested with Z3"
#cat ${TEST_PATH}/queries/p1-p2-rank${2}.smt2 >> ${OUTPUT2_BEFORE}
#echo "${OUTPUT2_BEFORE} is created. It can be tested with Z3"
#cat ${TEST_PATH}/queries/p2-p1-rank${2}.smt2 >> ${OUTPUT3_BEFORE}
#echo "${OUTPUT3_BEFORE} is created. It can be tested with Z3"
#cat ${TEST_PATH}/queries/mayHbP1.smt2 >> ${OUTPUT4_BEFORE}
#echo "${OUTPUT4_BEFORE} is created. It can be tested with Z3"
#cat ${TEST_PATH}/queries/mayHbP2.smt2 >> ${OUTPUT5_BEFORE}
#echo "${OUTPUT5_BEFORE} is created. It can be tested with Z3"

cat ${TEST_PATH}/queries/check.smt2 >> ${OUTPUT1_AFTER}
echo "${OUTPUT1_AFTER} is created. It can be tested with Z3"
cat ${TEST_PATH}/queries/p1-p2-rank${2}.smt2 >> ${OUTPUT2_AFTER}
echo "${OUTPUT2_AFTER} is created. It can be tested with Z3"
cat ${TEST_PATH}/queries/p2-p1-rank${2}.smt2 >> ${OUTPUT3_AFTER}
echo "${OUTPUT3_AFTER} is created. It can be tested with Z3"
#cat ${TEST_PATH}/queries/mayHbP1.smt2 >> ${OUTPUT4_AFTER}
#echo "${OUTPUT4_AFTER} is created. It can be tested with Z3"
#cat ${TEST_PATH}/queries/mayHbP2.smt2 >> ${OUTPUT5_AFTER}
#echo "${OUTPUT5_AFTER} is created. It can be tested with Z3"


# Run z3
#echo "Run z3 with ${OUTPUT1_BEFORE} ... "
#$TIME -o results/check-rank${2}-before-solve.time z3 ${OUTPUT1_BEFORE} > results/check-rank${2}-before-solve.out
#echo "Run z3 with ${OUTPUT2_BEFORE} ... "
#$TIME -o results/p1-p2-rank${2}-before-solve.time z3 ${OUTPUT2_BEFORE} > results/p1-p2-rank${2}-before-solve.out
#echo "Run z3 with ${OUTPUT3_BEFORE} ... "
#$TIME -o results/p2-p1-rank${2}-before-solve.time z3 ${OUTPUT3_BEFORE} > results/p2-p1-rank${2}-before-solve.out
#echo "Run z3 with ${OUTPUT4_BEFORE} ... "
#$TIME -o results/p1MayHB-before-solve.time z3 ${OUTPUT4_BEFORE} > results/p1MayHB-before-solve.out
#echo "Run z3 with ${OUTPUT5_BEFORE} ... "
#$TIME -o results/p2MayHB-before-solve.time z3 ${OUTPUT5_BEFORE} > results/p2MayHB-before-solve.out

echo "Run z3 with ${OUTPUT1_AFTER} ... "
$TIME -o results/check-rank${2}-after-solve.time z3 ${OUTPUT1_AFTER} > results/check-rank${2}-after-solve.out
echo "Run z3 with ${OUTPUT2_AFTER} ... "
$TIME -o results/p1-p2-rank${2}-after-solve.time z3 ${OUTPUT2_AFTER} > results/p1-p2-rank${2}-after-solve.out
echo "Run z3 with ${OUTPUT3_AFTER} ... "
$TIME -o results/p2-p1-rank${2}-after-solve.time z3 ${OUTPUT3_AFTER} > results/p2-p1-rank${2}-after-solve.out
#echo "Run z3 with ${OUTPUT4_AFTER} ... "
#$TIME -o results/p1MayHB-after-solve.time z3 ${OUTPUT4_AFTER} > p1MayHB-after-solve.out
#echo "Run z3 with ${OUTPUT5_AFTER} ... "
#$TIME -o results/p2MayHB-after-solve.time z3 ${OUTPUT5_AFTER} > p2MayHB-after-solve.out

cd ../..
