#!/bin/bash

source ../testDir-small.sh

for name in ${TESTDIRS}
do
cd $name
echo "===================$name ==============="
cat results/main1_time.time
cat results/main2_time.time



#mkdir expected
#cp results/check-rank2-after-solve.out expected/check-rank2-solve.expected
#cp results/p1-p2-rank2-after-solve.out expected/p1-p2-rank2-solve.expected
#cp results/p2-p1-rank2-after-solve.out expected/p2-p1-rank2-solve.expected
#cp p1-p2-rank1-solve.out expected/p1-p2-rank1-solve.expected
#cp p2-p1-rank1-solve.out expected/p2-p1-rank1-solve.expected
#echo "Sync." > type.txt
#git add type.txt

cd ..

done
