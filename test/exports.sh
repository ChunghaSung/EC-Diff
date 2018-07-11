#!/bin/bash

# LLVM opt path
LLVM_PREFIX=/home/chungha/base_llvm/llvm/build
#OPT=${LLVM_PREFIX}/bin/opt
OPT=`which opt`
#CLANG=${LLVM_PREFIX}/bin/clang
CLANG=`which clang`
CLANG_PP=`which clang++`
LLVM=`which llvm-dis`

# Pass path
#DIFF_SO=/home/chungha/work/check/diffproject/src/build/diffDep/libdiffDep.so
DIFF_SO=`pwd`/../src/build/diffDep/libdiffDep.so

# Test Path
#TEST_PATH=/home/chungha/work/diffproject/test
TEST_PATH=`pwd`

# Z3 path
Z3_BIN=/usr/bin/z3

TIME="`which time` -f %e"

build_single() {
    echo "Build first version.."
    echo "$CLANG -emit-llvm -S -c main1.c -O0"
    $TIME -o build1.time $CLANG -emit-llvm -S -c main1.c -O0 || die "error: clang"

    echo "$OPT -load ${DIFF_SO} -DiffDep -pNumber 1 main1.ll > main1.bc"
    $TIME -o build2.time $OPT -load ${DIFF_SO} -DiffDep -pNumber 1 main1.ll > main1.bc || die "error: opt"
    echo "main1.ll.facts.smt2 file is generated"

    echo "Build second version.."
    echo "$CLANG -emit-llvm -S -c main2.c"
    $TIME -o build3.time $CLANG -emit-llvm -S -c main2.c -O0 || die "error: clang"

    echo "$OPT -load ${DIFF_SO} -DiffDep -pNumber 2 main2.ll > main2.bc"
    $TIME -o build4.time $OPT -load ${DIFF_SO} -DiffDep -pNumber 2 main2.ll > main2.bc || die "error: opt"
    echo "main2.ll.facts.smt2 file is generated"

    BT1=`cat build1.time`
    BT2=`cat build2.time`
    BT3=`cat build3.time`
    BT4=`cat build4.time`
    BT=`python -c "print $BT1 + $BT2 + $BT3 + $BT4"`

    echo $BT > results/build.time
    rm build1.time
    rm build2.time
    rm build3.time
    rm build4.time
}

build_single_pp() {
    echo "Build first version.."
    echo "$CLANG_PP -emit-llvm -S -c main1.cpp -O0"
    $TIME -o build1.time $CLANG_PP -emit-llvm -S -c main1.cpp -O0 || die "error: clang"

    echo "$OPT -load ${DIFF_SO} -DiffDep -pNumber 1 main1.ll > main1.bc"
    $TIME -o build2.time $OPT -load ${DIFF_SO} -DiffDep -pNumber 1 main1.ll > main1.bc || die "error: opt"
    echo "main1.ll.facts.smt2 file is generated"

    echo "Build second version.."
    echo "$CLANG_PP -emit-llvm -S -c main2.cpp -O0"
    $TIME -o build3.time $CLANG_PP -emit-llvm -S -c main2.cpp -O0 || die "error: clang"

    echo "$OPT -load ${DIFF_SO} -DiffDep -pNumber 2 main2.ll > main2.bc"
    $TIME -o build4.time $OPT -load ${DIFF_SO} -DiffDep -pNumber 2 main2.ll > main2.bc || die "error: opt"
    echo "main2.ll.facts.smt2 file is generated"

    BT1=`cat build1.time`
    BT2=`cat build2.time`
    BT3=`cat build3.time`
    BT4=`cat build4.time`
    BT=`python -c "print $BT1 + $BT2 + $BT3 + $BT4"`

    echo $BT > build.time
    rm build1.time
    rm build2.time
    rm build3.time
    rm build4.time
}
