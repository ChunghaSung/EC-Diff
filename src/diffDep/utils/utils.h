#include "llvm/Pass.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/CallSite.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Value.h"
#include "llvm/IR/Constant.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/FileSystem.h"

#include <string>
#include <list>
#include <cstdbool>

using namespace llvm;
using namespace std;

class Utils {
    public:
    string impoFacts;
    string stFacts;
    string nonLockFacts;
    string threadCreateFacts;
    string threadJoinFacts;
    string threadCondWaitFacts;
    string threadCondSignalFacts;
    string lockFacts;
    string readFacts;
    string writeFacts;
    string domFacts;
    string postDomFacts;

    // program number used for constraints
    string pNumber;
    int pNumberInt;


    Utils() {
        impoFacts = "";
        stFacts = "";
        nonLockFacts = "";
        threadCreateFacts = "";
        threadJoinFacts = "";
        threadCondWaitFacts = "";
        threadCondSignalFacts = "";
        lockFacts = "";
        readFacts = "";
        writeFacts = "";
        domFacts = "";
        postDomFacts = "";
        pNumber = "";
    };

    // related functions
    void saveStNumMap(string, string);
    void dumpStNumMap(void);
    void saveLockNumMap(string, string);
    void dumpLockNumMap(void);

    void AssignPNumber(int);
    string GetHexVal(unsigned int);
    string GetHexValRev(unsigned int);
    bool isThread(llvm::Function *);
    bool isThread(std::string);
    bool CheckThreadName(std::string);
    string ThreadSaveAndGetID(llvm::Function *);
    string ThreadSaveAndGetID(std::string);
    void ThreadTidSaveID(std::string, std::string);
    string ThreadTidGetID(std::string);
    void LockInstSaveID(llvm::Instruction *);
    string InstSaveAndGetID(llvm::Instruction *);
    string LockSaveID(Value *);
    string LockGetID(Value *);
    string SharedSaveAndGetID(Value *);

    // fact save functions
    void SaveThreadCreateFacts(string, string, string);
    void SaveThreadJoinFacts(string, string, string);
    void SaveThreadCondWaitFacts(string, string, string);
    void SaveThreadCondSignalFacts(string, string);
    void SaveStFacts(string, string);
    void SavePoFacts(string, string);
    void SaveLockFacts(string, string);
    void SaveUnLockFacts(string, string);
    void SaveNoLockFacts(string);
    void SaveReadFacts(string, string);
    void SaveWriteFacts(string, string);
    void SaveBusyReadFacts(string, string);
    void SaveBusyWriteFacts(string, string);
    void SaveDomFacts(string, string);
    void SavePostDomFacts(string, string);

    // fact print functions
    string PrintThreadCreateFacts(void);
    string PrintThreadJoinFacts(void);
    string PrintThreadCondWaitFacts(void);
    string PrintThreadCondSignalFacts(void);
    string PrintPoFacts(void);
    string PrintStFacts(void);
    string PrintReadFacts(void);
    string PrintWriteFacts(void);
    string PrintDomFacts(void);
    string PrintPostDomFacts(void);
    string PrintLockFacts(void);
    string PrintUnLockFacts(void);
    string PrintNoLockFacts(void);
    string PrintSharedFacts(void);

    string getStrFromAt(string);
    void CallInstCategory(string, string, CallInst*);

    // dump functions
    std::string dumpLockTable();
    void dumpThreadMap(std::string);
    void dumpInstMap(std::string);
    void dumpLockMap(std::string);

    // map for statements between two programs 
        map<string, string> stNumMap; // instNumber in P2 -> instNumber in P1
    // map for lock numbers between two programs
        map<string, string> lockNumMap; // lockNumber in P2 -> lockNumber in P1

    // map for instruction
        map<llvm::Instruction*, string> InstMap; // instruction -> ID
        map<string, llvm::Instruction*> InstMapRev;  // ID -> instruction
    // map for lock instruction
        map<llvm::Instruction*, string> LockInstMap; // lock instruction -> ID
        map<string, llvm::Instruction*> LockInstMapRev;  // ID -> lock instruction
    // map for thread
        std::map<std::string, std::string> ThMap; // functionName -> ID
        std::map<std::string, std::string> ThMapRev; // ID -> functionName
    // map for thread tid
        std::map<std::string, std::string> ThTidMap; // Tid -> functionName
    // map for lock
        std::map<Value*, std::string> LockMap; // lockName -> ID
        std::map<std::string, Value*> LockMapRev; // ID -> lockName
    // map for shared variables
        std::map<Value*, std::string> SharedMap; // sharedVar -> ID
        std::map<std::string, Value*> SharedMapRev; // ID -> sharedVar
};
