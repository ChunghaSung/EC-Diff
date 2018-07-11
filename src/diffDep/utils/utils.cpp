#include "utils.h"
#include <iomanip>
#include <sstream>
#include <fstream>


void Utils::saveStNumMap(string p2ID, string p1ID) {
    stNumMap[p2ID] = p1ID;
}

void Utils::dumpStNumMap() {
    for (auto it = stNumMap.begin(); it != stNumMap.end(); ++it) {
        // first statement # : second statement #
        errs() << it->second << ":" << it->first << "\n";
    }

}

void Utils::saveLockNumMap(string l2ID, string l1ID) {
    lockNumMap[l2ID] = l1ID;
}

void Utils::dumpLockNumMap() {
    for (auto it = lockNumMap.begin(); it != lockNumMap.end(); ++it) {
        // first statement # : second statement #
        errs() << it->second << ":" << it->first << "\n";
    }

}

void Utils::AssignPNumber(int inputPNumber) {
    if (inputPNumber == 1) {
        pNumber = "#b0";
        pNumberInt = 1;
    } else if (inputPNumber == 2) {
        pNumber = "#b1";
        pNumberInt = 2;
    } else {
        errs() << "PNumber is allowed as only 1 or 2\n";
        exit(EXIT_FAILURE);
    }
}

std::string Utils::GetHexVal(unsigned int id) {
    std::stringstream sstream;
    sstream << std::hex << id;
    std::string newID = sstream.str();

    int str_length = newID.length();
    std::string output = "#x";
    for (int i=str_length; i<4; i++) {
        output += "0";
    }
    output += newID;
    return output;
}

// I assume the total number of instructions is less than #xefff
// and the total number of lock instructions is less than #x0fff
// so starting with #xff will be used for lock instructions
std::string Utils::GetHexValRev(unsigned int id) {
    std::stringstream sstream;
    sstream << std::hex << id;
    std::string newID = sstream.str();

    int str_length = newID.length();
    std::string output = "#x";
    for (int i=0; i<1; i++) {
        output += "f";
    }
    for (int i=str_length+1; i<4; i++) {
        output += "0";
    }
    output += newID;
    return output;
}

void Utils::dumpLockMap(std::string fileName) {
    // open file with the file name
    std::error_code ec;
    StringRef fileName2 = StringRef(fileName.c_str());
    raw_fd_ostream *file = new raw_fd_ostream(fileName2, ec, sys::fs::OpenFlags::F_Text);
    if (ec) {
        errs() << "[ERROR] Unable to open file " << fileName << ": " 
            << '\n';
        exit(EXIT_FAILURE);
    }
    std::string ret = "";
    std::string temp;
    for (auto it = LockMap.begin(); it != LockMap.end(); ++it) {
        ret += (it->first)->getName();
        ret += ":";
        ret += it->second;
        ret += "\n";
    }
    (*file) << ret;
    file->close();
    delete file;
}

void Utils::dumpThreadMap(std::string fileName) {
    // open file with the file name
    std::error_code ec;
    StringRef fileName2 = StringRef(fileName.c_str());
    raw_fd_ostream *file = new raw_fd_ostream(fileName2, ec, sys::fs::OpenFlags::F_Text);
    if (ec) {
        errs() << "[ERROR] Unable to open file " << fileName << ": " 
            << '\n';
        exit(EXIT_FAILURE);
    }
    std::string ret = "";
    std::string temp;
    for (auto it = ThMap.begin(); it != ThMap.end(); ++it) {
        ret += it->first;
        ret += ":";
        ret += it->second;
        ret += "\n";
    }
    (*file) << ret;
    file->close();
    delete file;
}

void Utils::dumpInstMap(std::string fileName) {
    // open file with the file name
    std::error_code ec;
    StringRef fileName2 = StringRef(fileName.c_str());
    raw_fd_ostream *file = new raw_fd_ostream(fileName2, ec, sys::fs::OpenFlags::F_Text);
    if (ec) {
        errs() << "[ERROR] Unable to open file " << fileName << ": " 
            << '\n';
        exit(EXIT_FAILURE);
    }
    std::string ret = "";

    for (auto it = InstMapRev.begin(); it != InstMapRev.end(); ++it) {

        Instruction &I = *(it->second);
        string tmp;
        llvm::raw_string_ostream rso(tmp);
        I.print(rso);
        ret += it->first;
        ret += ":";
        ret += tmp;
        ret += "\n";
    }

    for (auto it = LockInstMapRev.begin(); it != LockInstMapRev.end(); ++it) {

        Instruction &I = *(it->second);
        string tmp;
        llvm::raw_string_ostream rso(tmp);
        I.print(rso);
        ret += it->first;
        ret += ":";
        ret += tmp;
        ret += "\n";
    }

    (*file) << ret;
    file->close();
    delete file;
}

bool Utils::isThread(Function *f) {
    std::string funcName = f->getName();
    auto i = ThMap.find(funcName);
    if (i == ThMap.end()) {
        return false;
    } else {
        return true;
    }
}

bool Utils::isThread(std::string funcName) {
    auto i = ThMap.find(funcName);
    if (i == ThMap.end()) {
        return false;
    } else {
        return true;
    }
}

// check whether the threadName is saved or not
bool Utils::CheckThreadName(std::string threadName) {
    auto i = ThMap.find(threadName);
    if (i == ThMap.end()) {
        return false;
    } else {
        return true;
    }
}

std::string Utils::ThreadSaveAndGetID(Function *f) {
    std::string threadName = f->getName();
    auto i = ThMap.find(threadName);
    if (i == ThMap.end()) {
        // new function name
        unsigned int newUniqueID = ThMap.size();
        std::string newUniqueID_str = GetHexVal(newUniqueID);
        ThMap[threadName] = newUniqueID_str;
        ThMapRev[newUniqueID_str] = threadName;
        return newUniqueID_str;
    } else {
        // visited function
        return i->second;
    }
} 

std::string Utils::ThreadSaveAndGetID(std::string threadName) {
    auto i = ThMap.find(threadName);
    if (i == ThMap.end()) {
        // new function name
        unsigned int newUniqueID = ThMap.size();
        std::string newUniqueID_str = GetHexVal(newUniqueID);
        ThMap[threadName] = newUniqueID_str;
        ThMapRev[newUniqueID_str] = threadName;
        return newUniqueID_str;
    } else {
        // visited function
        return i->second;
    }
}

void Utils::ThreadTidSaveID(std::string tidName, std::string threadName) {
    auto i = ThTidMap.find(tidName);
    if (i == ThTidMap.end()) {
        // new thread name
        ThTidMap[tidName] = threadName;
    } else {
        errs() << "There is an overlapped tid!\n";
        errs() << tidName << "\n";
        exit(EXIT_FAILURE);
    }
}

std::string Utils::ThreadTidGetID(std::string tidName) {
    auto i = ThTidMap.find(tidName);
    if (i == ThTidMap.end()) {
        errs() << "Tid was not saved before\n";
        errs() << tidName << "\n";
        exit(EXIT_FAILURE);
    } else {
        return i->second;
    }
}

void Utils::LockInstSaveID(Instruction *inst) {
    auto i = InstMap.find(inst);
    if (i == InstMap.end()) {
        // new instruction
        unsigned int newUniqueID = LockInstMap.size();
        std::string newUniqueID_str = GetHexValRev(newUniqueID);
        if (pNumberInt == 2) {
            if (stNumMap.find(newUniqueID_str) != stNumMap.end()) {
                errs() << "Found changed inst match\n";
                errs() << "p1: " << stNumMap[newUniqueID_str] << ", p2: " << newUniqueID_str << "\n";
                LockInstMap[inst] = stNumMap[newUniqueID_str];
                LockInstMapRev[stNumMap[newUniqueID_str]] = inst;
            } else {
                LockInstMap[inst] = newUniqueID_str;
                LockInstMapRev[newUniqueID_str] = inst;
            }
        } else {
            LockInstMap[inst] = newUniqueID_str;
            LockInstMapRev[newUniqueID_str] = inst;
        }
    } else {
        errs() << "Same lock insts should not exist together\n";
        errs() << *inst << "\n";
        exit(EXIT_FAILURE);
    }
}

std::string Utils::InstSaveAndGetID(Instruction *inst) {

    auto i1 = InstMap.find(inst);
    auto i2 = LockInstMap.find(inst);
    //std::string inst = std::to_string((long)I);
    //auto i1 = InstMap.find(inst);
    //auto i2 = LockInstMap.find(inst);
    if (i1 == InstMap.end() && i2 == LockInstMap.end()) {
        // new instruction
        unsigned int newUniqueID = InstMap.size();
        std::string newUniqueID_str = GetHexVal(newUniqueID);
        //errs() << pNumberInt << "\n";
        if (pNumberInt == 2) {
            if (stNumMap.find(newUniqueID_str) != stNumMap.end()) {
                errs() << "Found changed inst match\n";
                errs() << "p1: " << stNumMap[newUniqueID_str] << ", p2: " << newUniqueID_str << "\n";
                InstMap[inst] = stNumMap[newUniqueID_str];
                InstMapRev[stNumMap[newUniqueID_str]] = inst;
                return stNumMap[newUniqueID_str];
            } else {
                InstMap[inst] = newUniqueID_str;
                InstMapRev[newUniqueID_str] = inst;
                return newUniqueID_str;
            }
        } else {
            InstMap[inst] = newUniqueID_str;
            InstMapRev[newUniqueID_str] = inst;
            return newUniqueID_str;
        }
    } else if (i1 == InstMap.end() && i2 != LockInstMap.end()){
        // visited instruction
        return i2->second;
    } else if (i1 != InstMap.end() && i2 == LockInstMap.end()){
        return i1->second;
    } else {
        errs() << "It is not possible for inst to be both LockInst and Inst\n";
        errs() << *inst << "\n";
        exit(EXIT_FAILURE);
    }
}



std::string Utils::LockSaveID(Value *lock_value)
{
    auto i = LockMap.find(lock_value);
    if (i == LockMap.end()) {
        unsigned int newUniqueID = LockMap.size();
        std::string newUniqueID_str = GetHexVal(newUniqueID);
        if (pNumberInt == 2) {
            if (lockNumMap.find(newUniqueID_str) != lockNumMap.end()) {
                errs() << "Found changed lock match\n";
                errs() << "l1: " << lockNumMap[newUniqueID_str] << ", l2: " << newUniqueID_str << "\n";
                LockMap[lock_value] = lockNumMap[newUniqueID_str];
                LockMapRev[lockNumMap[newUniqueID_str]] = lock_value;
            } else {
                LockMap[lock_value] = newUniqueID_str;
                LockMapRev[newUniqueID_str] = lock_value;
            }
        } else {
            LockMap[lock_value] = newUniqueID_str;
            LockMapRev[newUniqueID_str] = lock_value;
        }
        return newUniqueID_str;
    } else {
        return i->second;
    }
}

std::string Utils::LockGetID(Value *lock_value) {
    auto i = LockMap.find(lock_value);
    if (i == LockMap.end()) {
        errs() << "[ERROR] lock was not registered at the beginnig\n";
        exit(EXIT_FAILURE);
    } else {
        return i->second;
    }
}

std::string Utils::SharedSaveAndGetID(Value *shared_var)
{
    auto i = SharedMap.find(shared_var);
    if (i == SharedMap.end()) {
        unsigned int newUniqueID = SharedMap.size();
        std::string newUniqueID_str = GetHexVal(newUniqueID);
        SharedMap[shared_var] = newUniqueID_str;
        SharedMapRev[newUniqueID_str] = shared_var;
        return newUniqueID_str;
    } else {
        return i->second;
    }
}

void Utils::SaveThreadCreateFacts(string threadID1, string instID, string threadID2) {
    threadCreateFacts += "(rule (threadCreate " + threadID1 + " " + instID + " " + threadID2 + " " + pNumber + "))\n";
}

void Utils::SaveThreadJoinFacts(string threadID1, string instID, string threadID2) {
    threadJoinFacts += "(rule (threadJoin " + threadID1 + " " + instID + " " + threadID2 + " " + pNumber + "))\n";
}

void Utils::SaveThreadCondWaitFacts(string sharedID, string lockID, string instID) {
    threadCondWaitFacts += "(rule (threadCondWait " + sharedID + " " + lockID + " " + instID + " " + pNumber + "))\n";
}

void Utils::SaveThreadCondSignalFacts(string sharedID, string instID) {
    threadCondWaitFacts += "(rule (threadCondSignal " + sharedID + " " + instID + " " + pNumber + "))\n";
}

void Utils::SaveStFacts(string instID, string threadID) {
    stFacts += "(rule (st " + instID + " " + threadID + " " + pNumber + "))\n";
}

void Utils::SavePoFacts(std::string frontID, std::string backID) {
    impoFacts += "(rule (impo " + frontID + " " + backID + " " + pNumber + "))\n";
}

void Utils::SaveLockFacts(std::string instID, std::string lockID) {
    lockFacts += "(rule (lockAcquire " + instID + " " + lockID + " " + pNumber + "))\n";
}

void Utils::SaveUnLockFacts(string instID, string lockID) {
    lockFacts += "(rule (lockRelease " + instID + " " + lockID + " " + pNumber + "))\n";
}

void Utils::SaveNoLockFacts(string instID) {
    nonLockFacts += "(rule (nonLock " + instID + " " + pNumber + "))\n";
}

void Utils::SaveReadFacts(std::string instID, std::string sharedID) {
    readFacts += "(rule (read " + instID + " " + sharedID + " " + pNumber + "))\n";
}

void Utils::SaveBusyReadFacts(std::string instID, std::string sharedID) {
    readFacts += "(rule (busyRead " + instID + " " + sharedID + " " + pNumber + "))\n";
}

void Utils::SaveWriteFacts(string instID, string sharedID) {
    writeFacts += "(rule (write " + instID + " " + sharedID + " " + pNumber + "))\n";
}

void Utils::SaveBusyWriteFacts(std::string instID, std::string sharedID) {
    readFacts += "(rule (busyWrite " + instID + " " + sharedID + " " + pNumber + "))\n";
}

void Utils::SaveDomFacts(string instID1, string instID2) {
    domFacts += "(rule (dom " + instID1 + " " + instID2 + " " + pNumber + "))\n";
}

void Utils::SavePostDomFacts(string instID1, string instID2) {
    postDomFacts += "(rule (postDom " + instID1 + " " + instID2 + " " + pNumber + "))\n";
}

string Utils::PrintThreadCreateFacts(void) {
    return threadCreateFacts;
}
string Utils::PrintThreadJoinFacts(void) {
    return threadJoinFacts;
}
string Utils::PrintThreadCondWaitFacts(void) {
    return threadCondWaitFacts;
}
string Utils::PrintThreadCondSignalFacts(void) {
    return threadCondSignalFacts;
}
string Utils::PrintStFacts(void) {
    return stFacts;
}
string Utils::PrintPoFacts(void) {
    return impoFacts;
}
string Utils::PrintLockFacts(void) {
    return lockFacts;
}
string Utils::PrintNoLockFacts(void) {
    return nonLockFacts;
}
string Utils::PrintReadFacts(void) {
    return readFacts;
}
string Utils::PrintWriteFacts(void) {
    return writeFacts;
}
string Utils::PrintDomFacts(void) {
    return domFacts;
}
string Utils::PrintPostDomFacts(void) {
    return postDomFacts;
}



// get function name from argument
//    for pthread_create, the function will be the argument 
//    I am extracting the name of function from the argument.
//    Now, I am assuming that the function is not alias and 
//    there is no same name functions 
//    TODO: Is the best way to get function by finding "@"?
//    If I use this way, I cannot deal with function name alias.
std::string Utils::getStrFromAt(std::string input) {
    std::string ret = input.substr(input.find("@")+1, input.find(" ")-1);
    return ret;
}

void Utils::CallInstCategory(string instID, string threadID, CallInst* ci) {
    //string lock_call ("pthread_mutex_lock");
    //string unlock_call ("pthread_mutex_unlock");
    //string thread_create ("pthread_create");
    //string thread_join ("pthread_join");
    string thread_cond_wait ("pthread_cond_wait");
    string thread_cond_signal ("pthread_cond_signal");
    string thread_exit ("pthread_exit");


    //Instruction *csInst = I.getInstruction();
    //std::string instID = InstSaveAndGetID(csInst);
    Function *called_func = ci->getCalledFunction();
    //Function *call_func = I.getCalledFunction();
    if (called_func) {
        std::string called_name = called_func->getName();
        if (called_name.compare("pthread_mutex_lock") == 0) {
            Value *val = ci->getArgOperand(0);
            string lockID = LockGetID(val);
            SaveLockFacts(instID, lockID);
        } else if (called_name.compare("pthread_mutex_unlock") == 0) {
            Value *val = ci->getArgOperand(0);
            string lockID = LockGetID(val);
            SaveUnLockFacts(instID, lockID);
        } else if (called_name.compare("pthread_create") == 0) {
            Value *v = ci->getArgOperand(2);
            if (Function *tFunc = dyn_cast<Function>(v)) {
                SaveThreadCreateFacts(ThreadSaveAndGetID(tFunc->getName()), instID, threadID);
            } else {
                errs() << "[ERROR] pthread_create with non function 2nd arg\n";
                errs() << *v << '\n';
                exit(EXIT_FAILURE);
            }
            SaveNoLockFacts(instID);

        } else if (called_name.compare("pthread_join") == 0) {
            // if it is thread join
            if (isa<LoadInst>(ci->getOperand(0))) {
                LoadInst* l = cast<LoadInst>(ci->getOperand(0));
                Value *v = l->getPointerOperand();
                string funcName = ThreadTidGetID(v->getName());
                SaveThreadJoinFacts(ThreadSaveAndGetID(funcName), instID, threadID);
                SaveNoLockFacts(instID);
            } else {
                errs() << "[ERROR] wrong pthread_join function\n";
                exit(EXIT_FAILURE);
            }
        } else if (called_name.compare("pthread_cond_wait") == 0) {
            Value *cond = ci->getArgOperand(0);
            Value *lock = ci->getArgOperand(1);
            string lockID = LockGetID(lock);
            string sharedID = SharedSaveAndGetID(cond);
            //errs() << "cond: " << cond->getName() << "\n";
            //errs() << "lock: " << lock->getName() << "\n";
            SaveThreadCondWaitFacts(sharedID, lockID, instID);
            SaveNoLockFacts(instID);
        } else if (called_name.compare("pthread_cond_signal") == 0) {
            Value *cond = ci->getArgOperand(0);
            string sharedID = SharedSaveAndGetID(cond);
            //errs() << "cond: " << cond->getName() << "\n";
            SaveThreadCondSignalFacts(sharedID, instID);
            SaveNoLockFacts(instID);
        } else {
            // nolock statement
            SaveNoLockFacts(instID);
        }
    } else {
        //ret += PrintNoLockFacts(instID);
        SaveNoLockFacts(instID);
    }
}





std::string Utils::dumpLockTable() {
    std::string ret = "";
    std::string temp;
    for (auto it = LockMapRev.begin(); it != LockMapRev.end(); ++it) {
        ret += it->first;
        ret += ":";
        ret += it->second->getName();
        ret += "\n";
    }
    return ret;
}
