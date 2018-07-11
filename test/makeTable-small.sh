#!/bin/bash

set -u

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
  die "First argument must be rank number to make a table"
fi

RANK=${1}


TMPPATH=/tmp/table.out

echo "Name & LOC & \\# of th. & Type & Rank & \$P_1^{+} \\setminus P_2^{+}\$ & Fea. & Infea. & \$P_2^{+} \\setminus P_1^{+}\$ & Fea. & Infea. & \\# of mayHB in \$P_1^{+}\$ & \\# of mayHB in \$P_2^{+}\$ & Times (s) \\\\" > ${TMPPATH}

echo "\\midrule" >> $TMPPATH


for name in ${TESTDIRS}
do
    cd benchmarks/$name
    # name of directory
    echo "$name" > /tmp/name.out
    # lines of code
    wc -l < main1.c > /tmp/line.out

    # number of threads
    THREAD_NUM=`cat threads.num`
    THREAD_NUM=`expr $THREAD_NUM + 1`
    echo $THREAD_NUM > /tmp/threads.out

    # type of file
    cat type.txt > /tmp/type.out

    # rank
    echo "$1" > /tmp/rank.out

    # p1-p2 part
    # number of changes based on rank
    TMP=`wc -l < results/p1-p2-rank${RANK}-after-solve.out`
    N1=`expr $TMP - 1`
    # number of changes for feasible based on rank
    TMP=`wc -l < expected/p1-p2-rank${RANK}-solve.expected`
    N2=`expr $TMP - 1`
    if [ ${RANK} -eq 2 ]
    then
        N1=`python -c "print $N1 / 4"`
        N2=`python -c "print $N2 / 4"`
    fi
    echo $N1 > /tmp/p1-p2-test.out
    echo $N2 > /tmp/p1-p2-fea.out
    # infeasible numbers
    python -c "print $N1 - $N2" > /tmp/p1-p2-infea.out

    # p2-p1 part
    # number of changes based on rank
    TMP=`wc -l < results/p2-p1-rank${RANK}-after-solve.out`
    N1=`expr $TMP - 1`
    # number of changes of ground truth based on rank
    TMP=`wc -l < expected/p2-p1-rank${RANK}-solve.expected`
    N2=`expr $TMP - 1`
    if [ ${RANK} -eq 2 ]
    then
        N1=`python -c "print $N1 / 4"`
        N2=`python -c "print $N2 / 4"`
    fi
    echo $N1 > /tmp/p2-p1-test.out
    echo $N2 > /tmp/p2-p1-fea.out
    # infeasible numbers
    python -c "print $N1 - $N2" > /tmp/p2-p1-infea.out


    # mayHB numbers
    MAY_TMP=`wc -l < results/p1MayHB-before-solve.out`
    MAY_P1=`expr $MAY_TMP - 1`
    echo $MAY_P1 > /tmp/p1May.out
    MAY_TMP=`wc -l < results/p2MayHB-before-solve.out`
    MAY_P2=`expr $MAY_TMP - 1`
    echo $MAY_P2 > /tmp/p2May.out

    # time
    Time1=`cat results/build.time`
#Time2_BEFORE=`cat results/check-rank${1}-before-solve.time`
    Time2_AFTER=`cat results/check-rank${1}-after-solve.time`
#python -c "print $Time1 + $Time2_BEFORE" > /tmp/time-before.out
    python -c "print $Time1 + $Time2_AFTER" > /tmp/time-after.out

    paste -d, /tmp/name.out /tmp/line.out /tmp/threads.out /tmp/type.out /tmp/rank.out /tmp/p1-p2-test.out /tmp/p1-p2-fea.out /tmp/p1-p2-infea.out /tmp/p2-p1-test.out /tmp/p2-p1-fea.out /tmp/p1-p2-infea.out /tmp/p1May.out /tmp/p2May.out /tmp/time-after.out | sed 's/,/\&/g' | tr '\n' '@' | sed 's/@/ \\\\\n/g' >>$TMPPATH

    cd ../..
done

LOC=`awk -F\& '{sum += $2} END {print sum}' $TMPPATH`
TEST1=`awk -F\& '{sum += $6} END {print sum}' $TMPPATH`
FEA1=`awk -F\& '{sum += $7} END {print sum}' $TMPPATH`
INFEA1=`awk -F\& '{sum += $8} END {print sum}' $TMPPATH`

TEST2=`awk -F\& '{sum += $9} END {print sum}' $TMPPATH`
FEA2=`awk -F\& '{sum += $10} END {print sum}' $TMPPATH`
INFEA2=`awk -F\& '{sum += $11} END {print sum}' $TMPPATH`
#TOTALTIME_BEFORE=`awk -F\& '{sum += $11} END {print sum}' $TMPPATH`
TOTALTIME_AFTER=`awk -F\& '{sum += $14} END {print sum}' $TMPPATH`


P1MAY_TOTAL=`awk -F\& '{sum += $12} END {print sum}' $TMPPATH`
P2MAY_TOTAL=`awk -F\& '{sum += $13} END {print sum}' $TMPPATH`


NUM_LINES=`wc -l < $TMPPATH`
NUM_LINES=$(($NUM_LINES - 2))

#P1MAY_AVG=`bc <<< "scale=2; $P1MAY_TOTAL/$NUM_LINES"`
#P2MAY_AVG=`bc <<< "scale=2; $P2MAY_TOTAL/$NUM_LINES"`


#echo "\\midrule" >> $TMPPATH
#echo "\\textbf{Average} & & & & & & & & $P1MAY_AVG & $P2MAY_AVG & \\\\" >>$TMPPATH
echo "\\midrule" >> $TMPPATH
echo "\\textbf{Total} & $LOC & & & & $TEST1 & $FEA1 & $INFEA1 & $TEST2 & $FEA2 & $INFEA2 & $P1MAY_TOTAL & $P2MAY_TOTAL & $TOTALTIME_AFTER \\\\" >>$TMPPATH


cat ${TMPPATH}

