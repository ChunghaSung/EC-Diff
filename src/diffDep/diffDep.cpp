/**
 * Author: 
 *
 * LLVM pass to generate dependency facts for diffing project
 *
 */
#include "llvm/Pass.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/CallSite.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/FileSystem.h"
#include "llvm/Analysis/PostDominators.h"
#include "llvm/Analysis/DominanceFrontier.h"

#include "utils/utils.h"


#include <string>
#include <iostream>
#include <sstream>
#include <fstream>
#include <set>

using namespace llvm;
using namespace std;



// flags for program number. Only 1 and 2 are allowed
cl::opt<int> 
pNumber("pNumber"
        , cl::desc("Run pass for p1")
        , cl::init(0));



struct DiffDep : public ModulePass {
    static char ID;
    Utils Util;

    DiffDep() : ModulePass(ID) { }

    void findThreads(Module &M) {
        for (auto mi=M.begin(); mi != M.end(); mi++) {
            for (auto fi=mi->begin(); fi != mi->end(); fi++) {
                for (auto bi=fi->begin(); bi != fi->end(); bi++) {
                    Instruction *I = &*bi;
                    if (CallInst* ci = dyn_cast<CallInst>(I)) {
                        Function *called = ci->getCalledFunction();
                        if (called->getName() == "pthread_create") {
                            // Found pthread_create.
                            // The 2nd argument (zero indexed) is the
                            // function being called
                            Value *v = ci->getArgOperand(2);
                            if (Function *tFunc = dyn_cast<Function>(v)) {
                                // save thread id
                                Util.ThreadSaveAndGetID(tFunc->getName());
                                Value *v0 = ci->getArgOperand(0);
                                // save thread tid (used for join);
                                //errs() << "v0->getName(): " << v0->getName() << "\n";
                                Util.ThreadTidSaveID(v0->getName(), tFunc->getName());
                            } else {
                                errs() << "[ERROR] pthread_create with non function 2nd arg\n";
                                errs() << *v << '\n';
                                exit(EXIT_FAILURE);
                            }
                        }
                    } 
                }
            }
        }
    }

    void findLocks(Module &M) {
        for (auto mi=M.begin(); mi != M.end(); mi++) {
            for (auto fi=mi->begin(); fi != mi->end(); fi++) {
                for (auto bi=fi->begin(); bi != fi->end(); bi++) {
                    Instruction *I = &*bi;
                    if (CallInst* ci = dyn_cast<CallInst>(I)) {
                        Function *called = ci->getCalledFunction();
                        if (called->getName() == "pthread_mutex_lock" || called->getName() == "pthread_mutex_unlock"){
                            // save lock instruction
                            Util.LockInstSaveID(I);
                            //errs() << Util.InstSaveAndGetID(I) << "\n";
                            //errs() << *I << "\n";
                            // save lock value
                            Value *v = ci->getArgOperand(0);
                            Util.LockSaveID(v);
                        } else if (called->getName() == "pthread_join") {
                            Util.LockInstSaveID(I);
                        } else if (called->getName() == "pthread_cond_wait") {
                            Util.LockInstSaveID(I);
                        } else if (called->getName() == "pthread_cond_signal") {
                            Util.LockInstSaveID(I);
                        } else if (called->getName() == "nop1") {
                            Util.LockInstSaveID(I);
                        }
                    } 
                }
            }
        }
    }

    virtual bool runOnModule(Module &M) {

        errs() << "pNumber: " << pNumber << "\n";
        // program number has to be inserted as 1 or 2
        if (!(pNumber == 1 || pNumber == 2)) {
            errs() << "program number has to be 1 or 2\n";
            errs() << "assign 1 or 2 for the flag pNumber\n";
            exit(EXIT_FAILURE);
        }

        // initialize Utils and assigns program number
        Util = Utils();
        Util.AssignPNumber(pNumber);

        // Use the name of the module as the filename
        std::string modName = M.getModuleIdentifier();

        // read p1's feasible deps file

        // read statement match file
        // format of statmentMatch.txt
        // ex) #x0001:#x0002
        // it means p1's #x0001 is used as #x0002 in p2
        if (pNumber == 2) {
            ifstream infile1("statementMatch.txt");
            while (infile1) {
                string s;
                if (!getline(infile1, s)) break;
                string p1ID = s.substr(0, s.find(':'));
                string p2ID = s.substr(s.find(':')+1, string::npos);
                Util.saveStNumMap(p2ID, p1ID);
            }
            // print for debug
            Util.dumpStNumMap();
            
            // read lock match file. Format is same as statementMatch.txt
            ifstream infile2("lockMatch.txt");
            while (infile2) {
                string s;
                if (!getline(infile2, s)) break;
                string l1ID = s.substr(0, s.find(':'));
                string l2ID = s.substr(s.find(':')+1, string::npos);
                Util.saveLockNumMap(l2ID, l1ID);
            }
            // print for debug
            Util.dumpLockNumMap();
        }

        assert(modName.size() && "Module ID has size zero");
        std::string path = modName + ".facts.smt2";
        assert(path.size() && "empty output file path");
        std::string threadMapPath = modName + ".threadMap.txt";
        std::string instMapPath = modName + ".instMap.txt";
        std::string lockMapPath = modName + ".lockMap.txt";



        // Attempt to open a stream to the passed path, crash on failure.
        std::error_code ec;
        // Open file in text mode
        StringRef path2 = StringRef(path.c_str());
        cout << "PATH: " << path << "\n";
        raw_fd_ostream *outFile = new raw_fd_ostream(path2, ec, sys::fs::OpenFlags::F_Text);
        if (ec) {
            errs() << "[ERROR] Unable to open file " << path << ": " 
                << '\n';
            exit(EXIT_FAILURE);
        }

        // find & save thread name
        Util.ThreadSaveAndGetID("main");
        findThreads(M);

        // find & save lock instructions first
        findLocks(M);


        // Module
        for (auto mi=M.begin(), me=M.end(); mi != me; ++mi) {
            // Beginning of each module
            // make new thread. One thread represents one function.
            Function &f = *mi;
            //errs() << "function name: " << f.getName() << "\n";

            std::string threadID = "#x0000";
            if (Util.isThread(&f)) {
                threadID = Util.ThreadSaveAndGetID(&f);
            }

            if (f.getName() == "nop1") {
                continue;
            }

            // for each function (thread)
            for (auto fi=f.begin(), fe=f.end(); fi != fe; ++fi) {
                // get basic block
                BasicBlock &bb = *fi;
                //errs() << "Basicblock (name=" << bb.getName() << ") has "
                //<< bb.size() << " instructions.\n";
                // print flow rule inside of basic block
                for (BasicBlock::iterator bi = bb.begin(), be = bb.end(); bi != be; ++bi) {
                    // print flow fact
                    // get Inst structs
                    Instruction &I1 = *bi;
                    std::string i1ID = Util.InstSaveAndGetID(&I1);
                    /*
                       Value *tmp = &I1;
                       std::string str;
                       llvm::raw_string_ostream rso(str);
                       I1.print(rso);
                       errs() << *tmp << "\n";
                       errs() << &I1 << "\n";
                       errs() << str << "\n";
                     */
                    // print st facts
                    Util.SaveStFacts(i1ID, threadID);
                    //errs() << I1 << "\n";
                    // connect program order unless bi is the last instruction of basicblock
                    BasicBlock::iterator temp = bi;
                    temp++;
                    if (temp != be) {
                        Instruction &I2 = *temp;
                        std::string i2ID = Util.InstSaveAndGetID(&I2);
                        //errs() <<"; po (" << (I1) << " => " << I2 << ")\n";
                        //facts += Util.PrintPoFacts(i1ID, i2ID);
                        Util.SavePoFacts(i1ID, i2ID);
                        // within basic block, there is no branch.
                        // Therefore, just connect as program order
                        //facts += Util.PrintDomFacts(i1ID, i2ID);
                        Util.SaveDomFacts(i1ID, i2ID);
                        //facts += Util.PrintPostDomFacts(i2ID, i1ID);
                        Util.SavePostDomFacts(i2ID, i1ID);
                    }


                    // check the call function
                    if (CallInst *i = dyn_cast<CallInst>(&I1)) {
                        // check the call related instruction
                        //facts += Util.CallInstCategory(i1ID, threadID, i);
                        Util.CallInstCategory(i1ID, threadID, i);
                    } else if (StoreInst *i = dyn_cast<StoreInst>(&I1)) {
                        // shared access check
                        std::string name = i->getPointerOperand()->getName();
                        std::size_t found = name.find("SHARED");
                        if (found != std::string::npos) {
                            std::string sharedID = Util.SharedSaveAndGetID(i->getPointerOperand());
                            Util.SaveWriteFacts(i1ID, sharedID);
                        }
                        std::size_t found2 = name.find("BUSY");
                        if (Util.CheckThreadName(f.getName()) && found2 != std::string::npos) {
                            std::string sharedID = Util.SharedSaveAndGetID(i->getPointerOperand());
                            //facts += Util.PrintReadFacts(i1ID, sharedID);
                            Util.SaveBusyWriteFacts(i1ID, sharedID);
                        }
                        Util.SaveNoLockFacts(i1ID);
                    } else if (LoadInst *i = dyn_cast<LoadInst>(&I1)) {
                        // shared access check
                        std::string name = i->getPointerOperand()->getName();
                        std::size_t found = name.find("SHARED");
                        if (found != std::string::npos) {
                            std::string sharedID = Util.SharedSaveAndGetID(i->getPointerOperand());
                            //facts += Util.PrintReadFacts(i1ID, sharedID);
                            Util.SaveReadFacts(i1ID, sharedID);
                        }
                        std::size_t found2 = name.find("BUSY");
                        if (Util.CheckThreadName(f.getName()) && found2 != std::string::npos) {
                            std::string sharedID = Util.SharedSaveAndGetID(i->getPointerOperand());
                            //facts += Util.PrintReadFacts(i1ID, sharedID);
                            Util.SaveBusyReadFacts(i1ID, sharedID);
                        }
                        //facts += Util.PrintNoLockFacts(i1ID);
                        Util.SaveNoLockFacts(i1ID);
                    } else {
                        //facts += Util.PrintNoLockFacts(i1ID);
                        Util.SaveNoLockFacts(i1ID);
                    }
                }

                // print program order between basic blocks 
                // (Connection between basicblocks)
                Instruction *b1_end = bb.getTerminator();
                std::string b1_endID = Util.InstSaveAndGetID(b1_end);
                unsigned cnt = bb.getTerminator()->getNumSuccessors();
                for (unsigned i=0; i<cnt; i++) {
                    BasicBlock *b2 = bb.getTerminator()->getSuccessor(i);
                    BasicBlock::iterator b2_front = b2->begin();
                    Instruction &b2_front_i = *b2_front;
                    std::string b2_frontID = Util.InstSaveAndGetID(&b2_front_i);
                    //facts += Util.PrintPoFacts(b1_endID, b2_frontID);
                    Util.SavePoFacts(b1_endID, b2_frontID);
                }

                // print dominate & post dominate rules between basic blocks
                DominatorTree dt = DominatorTree(f);
                PostDominatorTree pdt;
                pdt.runOnFunction(f);

                for (BasicBlock &b : f) {
                    // for dominator tree
                    DomTreeNodeBase<BasicBlock> *bbNode = dt.getNode(&b);
                    if (bbNode != NULL) {
                        // For the dom children of `b`, 
                        // connect the terminator of `b` to the
                        // first instruction in the child
                        Instruction *from = b.getTerminator();
                        string instID1 = Util.InstSaveAndGetID(from);
                        const vector<DomTreeNodeBase<BasicBlock> *> &children = bbNode->getChildren();
                        for (size_t i = 0; i < children.size(); ++i) {
                            BasicBlock *c = children[i]->getBlock();
                            Instruction &to = *(c->begin());
                            string instID2 = Util.InstSaveAndGetID(&to);
                            //facts += Util.PrintDomFacts(instID1, instID2);
                            Util.SaveDomFacts(instID1, instID2);
                        }
                    }
                    // for post dominator tree
                    DomTreeNodeBase<BasicBlock> *btNode = pdt.getNode(&b);
                    if (btNode != NULL) {
                        // For the post dom children of `b`
                        // connect the first instruction of `b` to the 
                        // last instruction in the child
                        Instruction &from = *(b.begin());
                        string instID1 = Util.InstSaveAndGetID(&from);
                        const std::vector<DomTreeNodeBase<BasicBlock> *> &children 
                            = btNode->getChildren();
                        for (size_t i = 0; i < children.size(); ++i) {
                            BasicBlock *c = children[i]->getBlock();
                            Instruction *to = c->getTerminator();
                            string instID2 = Util.InstSaveAndGetID(to);
                            //facts += Util.PrintPostDomFacts(instID1, instID2);
                            Util.SavePostDomFacts(instID1, instID2);
                        }
                    }
                }
            }
        }

        // print all facts
        (*outFile) << Util.PrintThreadCreateFacts();
        (*outFile) << Util.PrintThreadJoinFacts();
        (*outFile) << Util.PrintThreadCondWaitFacts();
        (*outFile) << Util.PrintThreadCondSignalFacts();
        (*outFile) << Util.PrintStFacts();
        (*outFile) << Util.PrintPoFacts();
        (*outFile) << Util.PrintLockFacts();
        (*outFile) << Util.PrintNoLockFacts();
        (*outFile) << Util.PrintReadFacts();
        (*outFile) << Util.PrintWriteFacts();
        (*outFile) << Util.PrintDomFacts();
        (*outFile) << Util.PrintPostDomFacts();

        //(*outFile) << Util.addQueries();
        outFile->close();
        delete outFile;


        // DEBUG: Dump threadMap and statement information 
        Util.dumpThreadMap(threadMapPath);
        // DEBUG: Dump instMap and statement information 
        Util.dumpInstMap(instMapPath);
        // DEBUG: Dump lockMap
        Util.dumpLockMap(lockMapPath);


        // IR was not modified
        return false;
    }
};


char DiffDep::ID = 0;
static RegisterPass<DiffDep> X("DiffDep",
        "LLVM frontend pass to print dependency Datalog facts for diffing project.",
        false,  // unmodified CFG
        true); // analysis pass
