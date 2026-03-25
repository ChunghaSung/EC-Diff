#!/bin/bash
# Run all benchmarks using the Python-based fact extractor.
# Usage: ./run_all_py.sh [rank]
# Default rank is 1. Generates .ll, .facts.smt2, and assembled query files,
# then runs Z3 and compares against expected results.

set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
EXTRACT_FACTS="${SCRIPT_DIR}/../extract_facts.py"
TEST_PATH="${SCRIPT_DIR}"
CLANG="${CLANG:-$(which clang)}"
Z3="${Z3:-$(which z3)}"
RANK="${1:-1}"

source "${SCRIPT_DIR}/testDir-small.sh"

PASS=0
FAIL=0
SKIP=0
ERRORS=""

for d in ${TESTDIRS}; do
    DIR="${SCRIPT_DIR}/benchmarks/${d}"
    if [ ! -d "$DIR" ]; then
        echo "SKIP: $d (directory not found)"
        SKIP=$((SKIP + 1))
        continue
    fi

    cd "$DIR"

    # Compile to LLVM IR
    $CLANG -emit-llvm -S -c main1.c -O0 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "SKIP: $d (clang failed on main1.c)"
        SKIP=$((SKIP + 1))
        continue
    fi
    $CLANG -emit-llvm -S -c main2.c -O0 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "SKIP: $d (clang failed on main2.c)"
        SKIP=$((SKIP + 1))
        continue
    fi

    # Extract facts
    python3 "$EXTRACT_FACTS" main1.ll 1 2>/dev/null
    MATCH_ARGS=""
    [ -f statementMatch.txt ] && MATCH_ARGS="statementMatch.txt"
    [ -f lockMatch.txt ] && MATCH_ARGS="$MATCH_ARGS lockMatch.txt"
    python3 "$EXTRACT_FACTS" main2.ll 2 $MATCH_ARGS 2>/dev/null

    # Assemble and run queries
    for q in check p1-p2 p2-p1; do
        QFILE="${TEST_PATH}/queries/${q}.smt2"
        [ -f "${TEST_PATH}/queries/${q}-rank${RANK}.smt2" ] && QFILE="${TEST_PATH}/queries/${q}-rank${RANK}.smt2"

        EXPECTED_FILE="results/${q}-rank${RANK}-after-solve.out"
        if [ ! -f "$EXPECTED_FILE" ]; then
            continue
        fi

        SMT_FILE="${q}-rank${RANK}-after.smt2"
        cat "${TEST_PATH}/general_rules-after.smt2" \
            "${TEST_PATH}/rank${RANK}_rules.smt2" \
            main1.ll.facts.smt2 \
            main2.ll.facts.smt2 \
            "$QFILE" > "$SMT_FILE"

        RESULT=$($Z3 "$SMT_FILE" 2>/dev/null | grep -v "^(error")
        EXPECTED=$(cat "$EXPECTED_FILE")

        # Compare first line (sat/unsat)
        GOT_FIRST=$(echo "$RESULT" | head -1)
        EXP_FIRST=$(echo "$EXPECTED" | head -1)

        if [ "$GOT_FIRST" != "$EXP_FIRST" ]; then
            echo "FAIL: $d / $q rank${RANK} (expected $EXP_FIRST, got $GOT_FIRST)"
            FAIL=$((FAIL + 1))
            ERRORS="${ERRORS}\n  $d/$q-rank${RANK}"
            continue
        fi

        # For sat results, compare tuple sets
        if [ "$GOT_FIRST" = "sat" ]; then
            GOT_TUPLES=$(echo "$RESULT" | tr -d ' \n' | grep -oE 'and[^)]*' | sort)
            EXP_TUPLES=$(echo "$EXPECTED" | tr -d ' \n' | grep -oE 'and[^)]*' | sort)
            if [ "$GOT_TUPLES" = "$EXP_TUPLES" ]; then
                PASS=$((PASS + 1))
            else
                echo "FAIL: $d / $q rank${RANK} (tuples differ)"
                FAIL=$((FAIL + 1))
                ERRORS="${ERRORS}\n  $d/$q-rank${RANK}"
            fi
        else
            PASS=$((PASS + 1))
        fi
    done

    cd "$SCRIPT_DIR"
done

echo ""
echo "================================"
echo "Results: PASS=$PASS  FAIL=$FAIL  SKIP=$SKIP"
if [ -n "$ERRORS" ]; then
    echo -e "Failed tests:${ERRORS}"
fi
echo "================================"
