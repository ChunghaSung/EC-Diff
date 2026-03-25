# Summary
- This is ASE submission artifact for "Datalog-based Scalable Semantic Diffing of Concurrent Programs".
- The purpose of this is to show the validity of this work, and show the results shown in the paper.
- If you have any question, please contact to the authors.
- To check the results only, you do not have to build and run since all results are already ready (In that case, please just run the script to print tables).

# Citing EC-Diff
```
@inproceedings{DBLP:conf/kbse/SungLEW18,
  author    = {Chungha Sung and
               Shuvendu K. Lahiri and
               Constantin Enea and
               Chao Wang},
  title     = {Datalog-based scalable semantic diffing of concurrent programs},
  booktitle = {Proceedings of the 33rd {ACM/IEEE} International Conference on Automated
               Software Engineering, {ASE} 2018, Montpellier, France, September 3-7,
               2018},
  pages     = {656--666},
  year      = {2018},
  crossref  = {DBLP:conf/kbse/2018},
  url       = {https://doi.org/10.1145/3238147.3238211},
  doi       = {10.1145/3238147.3238211},
  timestamp = {Wed, 21 Nov 2018 12:44:20 +0100},
  biburl    = {https://dblp.org/rec/bib/conf/kbse/SungLEW18},
  bibsource = {dblp computer science bibliography, https://dblp.org}
}
```

# Python-based approach (replaces LLVM 3.8 pass)

The original tool required LLVM 3.8.0 to build the `DiffDep` LLVM pass (`src/`).
Since LLVM 3.8 is difficult to build on modern systems, `extract_facts.py` was
created by **Claude Code** as a drop-in Python replacement. It parses LLVM IR
(`.ll` files produced by any modern `clang`) and generates the same `.facts.smt2`
Datalog ground facts that the original C++ LLVM pass produced.

The declarative SMT rules (`general_rules-after.smt2`, `rank*_rules.smt2`, and
the query files under `test/queries/`) are unchanged — only the fact extraction
step was rewritten.

## Dependencies
- **clang** (any version; tested with Apple clang 17)
- **Python 3** (no external packages needed)
- **Z3** (tested with Z3 4.5.0 and 4.8.17)

## Quick start

```bash
# 1. Extract benchmarks (if not already done)
cd test && tar xzf benchmarks.tar.gz && cd ..

# 2. Generate all .ll and .facts.smt2 files + assembled SMT2 queries
./generate_all.sh

# 3. Run Z3 on a specific query (example: case1, check, rank 1)
z3 test/benchmarks/case1/check-rank1-after.smt2
```

## How it works

The pipeline for each benchmark:

1. `clang -emit-llvm -S -c main1.c -O0` → `main1.ll` (LLVM IR)
2. `python3 extract_facts.py main1.ll 1` → `main1.ll.facts.smt2` (Datalog facts)
3. Same for `main2.c` with program number 2
4. Concatenate: rules + rank rules + P1 facts + P2 facts + query → full `.smt2`
5. `z3 <query>.smt2` → result (sat/unsat + witness tuples)

## Running a single benchmark

```bash
cd test/benchmarks/case1
clang -emit-llvm -S -c main1.c -O0
clang -emit-llvm -S -c main2.c -O0
python3 ../../../extract_facts.py main1.ll 1
python3 ../../../extract_facts.py main2.ll 2
# For P2 with statement matching:
# python3 ../../../extract_facts.py main2.ll 2 statementMatch.txt lockMatch.txt

# Assemble and solve
cat ../../general_rules-after.smt2 ../../rank1_rules.smt2 \
    main1.ll.facts.smt2 main2.ll.facts.smt2 \
    ../../queries/check.smt2 > check-rank1-after.smt2
z3 check-rank1-after.smt2
```

## Running all benchmarks

```bash
# Generate everything (from repo root):
./generate_all.sh

# Test all small benchmarks against expected results (rank 1):
cd test && ./run_all_py.sh 1
```

## Using the SMT queries (rules + facts)

Each assembled query file is a self-contained SMT2 file that can be fed directly
to Z3. It is built by concatenating four parts in order:

```
┌─────────────────────────────────────┐
│  general_rules-after.smt2           │  ← Datalog rules (po, mustHb, mayHb,
│                                     │     mayRf, mayDep, lock regions, etc.)
├─────────────────────────────────────┤
│  rank{1,2,3}_rules.smt2            │  ← Rank-specific comparison rules
├─────────────────────────────────────┤
│  main1.ll.facts.smt2               │  ← Ground facts for program 1
│  main2.ll.facts.smt2               │  ← Ground facts for program 2
├─────────────────────────────────────┤
│  queries/{check,p1-p2,p2-p1}.smt2  │  ← Query
└─────────────────────────────────────┘
```

### Pre-assembled queries (ready to run)

After running `./generate_all.sh`, each benchmark directory has pre-assembled
files that can be run directly:

```bash
# Equivalence check at rank 1:
z3 test/benchmarks/case1/check-rank1-after.smt2

# Dependencies in P1 but not P2 at rank 1:
z3 test/benchmarks/case1/p1-p2-rank1-after.smt2

# Dependencies in P2 but not P1 at rank 1:
z3 test/benchmarks/case1/p2-p1-rank1-after.smt2
```

### File locations

**Rules** (shared across all benchmarks, under `test/`):

| File | Description |
|---|---|
| `general_rules-after.smt2` | Core Datalog rules (type defs, relation decls, po, mustHb, mayHb, mayRf, mayDep, lock regions, dom/postDom, etc.) |
| `rank1_rules.smt2` | Rank-1 rules: compare single dependency edges between P1 and P2 |
| `rank2_rules.smt2` | Rank-2 rules: compare pairs of dependency edges |
| `rank3_rules.smt2` | Rank-3 rules: compare triples of dependency edges |
| `queries/check.smt2` | Query for `p1p2Equal` (are the programs equivalent?) |
| `queries/p1-p2-rank{1,2,3}.smt2` | Query for dependencies in P1 but not P2 |
| `queries/p2-p1-rank{1,2,3}.smt2` | Query for dependencies in P2 but not P1 |
| `queries/mayHbP1.smt2` | Query for may-happen-before in P1 |
| `queries/mayHbP2.smt2` | Query for may-happen-before in P2 |

**Facts** (per benchmark, under `test/benchmarks/<name>/`):

| File | Description |
|---|---|
| `main1.ll.facts.smt2` | Ground facts for program 1: `st`, `impo`, `read`, `write`, `lockAcquire`, `lockRelease`, `nonLock`, `dom`, `postDom`, `threadCreate`, `threadJoin`, etc. |
| `main2.ll.facts.smt2` | Ground facts for program 2 (same format) |
| `main1.c` / `main2.c` | Original C source programs |
| `main1.ll` / `main2.ll` | LLVM IR (intermediate representation) |

### Assembling a query manually

To build a query from individual parts:

```bash
cat test/general_rules-after.smt2 \
    test/rank1_rules.smt2 \
    test/benchmarks/case1/main1.ll.facts.smt2 \
    test/benchmarks/case1/main2.ll.facts.smt2 \
    test/queries/check.smt2 \
  | z3 -in
```

Or to swap rank or query type:

```bash
# Rank 2, dependencies in P2 but not P1, for the cherokee benchmark:
cat test/general_rules-after.smt2 \
    test/rank2_rules.smt2 \
    test/benchmarks/cherokee/main1.ll.facts.smt2 \
    test/benchmarks/cherokee/main2.ll.facts.smt2 \
    test/queries/p2-p1-rank2.smt2 \
  | z3 -in
```

### Interpreting results

- `unsat` on `check`: Programs are **equivalent** at this rank (no dependency difference found).
- `sat` on `check` with `(= (:var 0) false)`: Programs are **different**.
- `sat` on `p1-p2` / `p2-p1`: Returns the specific dependency tuples that exist in one program but not the other. Each tuple is a pair (rank 1), quadruple (rank 2), or sextuple (rank 3) of instruction IDs.

## Compatibility notes

Results match the original LLVM 3.8 artifact for 120/120 queries (100%).
The `statementMatch.txt` for `rtl8169-2` was updated to reflect modern
clang's instruction layout. One benchmark (`mysql5`) is skipped due to
a missing `nop1` forward declaration that modern clang treats as an error.

# Directory
  1. `extract_facts.py`: Python fact extractor (replaces `src/` LLVM pass)
  2. `generate_all.sh`: Script to generate all .ll, .facts.smt2, and query files
  3. `src/`: Original LLVM 3.8 pass (kept for reference, requires LLVM 3.8 to build)
  4. `test/`: Test programs, scripts, benchmark programs, SMT rules and queries
  5. `test/benchmarks/`: Benchmark programs with expected results
  6. `sastest/`: Instrumented test programs of the prior work (unchanged)

# Original LLVM 3.8 build instructions (for reference)

  1. Under `src`, type `mkdir build`.
  2. `cd build`
  3. `cmake ../ && make`

Requires LLVM 3.8.0 and Z3 4.5.0.

# Etc.
 - We don't have all results of rank 3 since it is meaningless. Some programs do not print result for rank 2 since it does not have more than 2 read from edges.
 - Also, we do not have result table for large size with rank 2, 3 since it is meaningless.

# To run test under `sastest`
  1. `./run_all.sh` : run all programs used with the prior work. The result will be saved under `result` directory under each benchmark directory.
