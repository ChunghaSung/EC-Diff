# Summary
- This is ASE submission artifact for "Datalog-based Scalable Semantic Diffing of Concurrent Programs".
- The purpose of this is to show the validity of this work, and show the results shown in the paper.
- If you have any question, please contact to the authors.
- To check the results only, you do not have to build and run since all results are already ready (In that case, please just run the script to print tables).

# Authors
- Chungha Sung
- Shuvendu Lahiri
- Constantin Enea
- Chao Wang

# To build (tested with LLVM 3.8.0) our program.

  1. Under ``src``, type ``mkdir build``.
  2. ``cd build``
  3. cmake ../ && make

# Dependencies 
- Z3 is needed (tested with Z3 4.5.0)
- Python and other scripts may need to be installed.

# Directory 
  1. src: LLVM pass of our approach
  2. test: test programs and scripts with benchmark programs we have used for experimental table.
  3. sastest: instrumented test programs of the prior work used for experimental table.

# Before running
- Please extract ``benchmarks.tar.gz`` into ``benchmarks`` as the size of results is big.

# To run test under ``test``
  1. ``./run_all-small.sh 1`` : run all small sized benchmarks with our approach with rank 1.
  2. ``./run_all-small.sh 2`` : run all small sized benchmarks with our approach with rank 2.
  3. ``./run_all-large.sh 1`` : run all large sized benchmarks with our approach with rank 1.
  5. ``./run_all-mayHb.sh``   : run all (small and large) benchmarks to compute mayhb relations.

# Print table under ``test``
  1. ``./makeTable-small.sh 1`` : print a result table for small sized benchmarks with rank 1.
  2. ``./makeTable-small.sh 2`` : print a result table for small sized benchmarks with rank 2.
  3. ``./makeTable-large 1`` : print a result table for large sized benchmarks with rank 1.

# We don't have all results of rank 3 since it is meaningless. Some programs do not print result for rank 2 since it does not have more than 2 read from edges.

# Also, we do not have result table for large size with rank 2, 3 since it is meangless.

# To run test under ``sastest``
  1. ``./run_all.sh`` : run all programs used with the prior work. The result will be saved under ``result`` directory under each benchmark directory.

