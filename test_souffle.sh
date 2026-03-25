#!/bin/bash
# Test all benchmarks with Souffle and compare against Z3 results.
#
# Usage: ./test_souffle.sh [rank]
# Default rank is 1.

set -u

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SMT2_TO_SOUFFLE="${SCRIPT_DIR}/smt2_to_souffle.py"
TEST_PATH="${SCRIPT_DIR}/test"
SOUFFLE="${SOUFFLE:-$(which souffle)}"
Z3="${Z3:-$(which z3)}"
RANK="${1:-1}"

source "${TEST_PATH}/testDir-small.sh"

PASS=0
FAIL=0
SKIP=0
ERRORS=""

for d in ${TESTDIRS}; do
    DIR="${TEST_PATH}/benchmarks/${d}"
    if [ ! -d "$DIR" ]; then
        SKIP=$((SKIP + 1))
        continue
    fi

    cd "$DIR"

    for q in check p1-p2 p2-p1; do
        SMT_FILE="${q}-rank${RANK}-after.smt2"
        if [ ! -f "$SMT_FILE" ]; then
            continue
        fi

        # Convert to Souffle
        DL_FILE="${q}-rank${RANK}.dl"
        python3 "$SMT2_TO_SOUFFLE" "$SMT_FILE" "$DL_FILE" 2>/dev/null

        # Run Souffle
        SOUFFLE_OUT=$($SOUFFLE -D- "$DL_FILE" 2>/dev/null)

        # Run Z3
        Z3_OUT=$($Z3 "$SMT_FILE" 2>/dev/null | grep -v "^(error")
        Z3_FIRST=$(echo "$Z3_OUT" | head -1)

        # Compare: check if Souffle output is empty (unsat) or has tuples (sat)
        # Souffle prints header + separator + data lines
        SOUFFLE_DATA=$(echo "$SOUFFLE_OUT" | grep -v "^-" | grep -v "^=" | grep -v "^v[0-9]" | grep -v "^$" | grep -v "^p1p2Equal\|^p1Notp2\|^p2Notp1")

        if [ "$Z3_FIRST" = "unsat" ]; then
            # Z3 says unsat -> Souffle should produce no data rows
            if [ -z "$SOUFFLE_DATA" ]; then
                PASS=$((PASS + 1))
            else
                echo "FAIL: $d / $q rank${RANK} (Z3=unsat, Souffle has output)"
                FAIL=$((FAIL + 1))
                ERRORS="${ERRORS}\n  $d/$q-rank${RANK}"
            fi
        elif [ "$Z3_FIRST" = "sat" ]; then
            # Z3 says sat -> Souffle should produce some data rows
            if [ -n "$SOUFFLE_DATA" ]; then
                PASS=$((PASS + 1))
            else
                echo "FAIL: $d / $q rank${RANK} (Z3=sat, Souffle empty)"
                FAIL=$((FAIL + 1))
                ERRORS="${ERRORS}\n  $d/$q-rank${RANK}"
            fi
        else
            echo "SKIP: $d / $q rank${RANK} (Z3 result unclear: $Z3_FIRST)"
            SKIP=$((SKIP + 1))
        fi
    done

    cd "$SCRIPT_DIR"
done

echo ""
echo "================================"
echo "Souffle vs Z3: PASS=$PASS  FAIL=$FAIL  SKIP=$SKIP"
if [ -n "$ERRORS" ]; then
    echo -e "Failed tests:${ERRORS}"
fi
echo "================================"
