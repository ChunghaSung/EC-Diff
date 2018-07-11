#include "llvm/IR/Instruction.h"
#include "llvm/Support/raw_ostream.h"
#include <z3.h>
#include <z3++.h>
#include <z3_api.h>
#include <z3_fixedpoint.h>
#include <map>

using namespace llvm;

namespace z3_utils {

    z3::func_decl getBV1FuncDecl(z3::context &ctx, const char *name
            , const unsigned bvSize);

    // function declaration of 2 variables rules
    z3::func_decl getBV2FuncDecl(z3::context &ctx, const char *name
            , const unsigned bvSize);

    // function declaration of 3 variables rules
    z3::func_decl getBV3FuncDecl(z3::context &ctx, const char *name
            , const unsigned bvSize);

    // function declaration of 4 variables rules
    z3::func_decl getBV4FuncDecl(z3::context &ctx, const char *name
            , const unsigned bvSize);

    // function declaration of 5 variables rules
    z3::func_decl getBV5FuncDecl(z3::context &ctx, const char *name
            , const unsigned bvSize);

    // function declaration of 6 variables rules
    z3::func_decl getBV6FuncDecl(z3::context &ctx, const char *name
            , const unsigned bvSize);

    // function declaration of 7 variables rules
    z3::func_decl getBV7FuncDecl(z3::context &ctx, const char *name
            , const unsigned bvSize);


    z3::expr getValueBVIDSz(z3::context &ctx, unsigned int id
            , unsigned bvsize);


    void addFact1Sz(z3::context &ctx
            , Z3_fixedpoint &zfp
            , z3::func_decl fd
            , unsigned v
            , unsigned bvSize);


    void addFact2Sz(z3::context &ctx
            , Z3_fixedpoint &zfp
            , z3::func_decl fd
            , unsigned int v1
            , unsigned int v2
            , unsigned bvSize);

    void addFact3Sz(z3::context &ctx
            , Z3_fixedpoint &zfp
            , z3::func_decl fd
            , unsigned int v1
            , unsigned int v2
            , unsigned int v3
            , unsigned bvSize);


    void addFact4Sz(z3::context &ctx
            , Z3_fixedpoint &zfp
            , z3::func_decl fd
            , unsigned int v1
            , unsigned int v2
            , unsigned int v3
            , unsigned int v4
            , unsigned bvSize);


    void addTransRuleBV2(z3::context &ctx, Z3_fixedpoint &zfp
            , z3::func_decl fd, unsigned bvSize);

    void addTransRuleBV3(z3::context &ctx, Z3_fixedpoint &zfp
            , z3::func_decl fd, unsigned bvSize);


    void addStFacts(z3::context &ctx
            , Z3_fixedpoint &zfp
            , unsigned int id1
            , unsigned int id2
            , unsigned int id3
            , unsigned bvSize);


    void addImPoFacts(z3::context &ctx
            , Z3_fixedpoint &zfp
            , unsigned int id1
            , unsigned int id2
            , unsigned int id3
            , unsigned bvSize);

    void addLockFacts(z3::context &ctx
            , Z3_fixedpoint &zfp
            , unsigned int id1
            , unsigned int id2
            , unsigned int id3
            , unsigned bvSize);


    void addUnLockFacts(z3::context &ctx
            , Z3_fixedpoint &zfp
            , unsigned int id1
            , unsigned int id2
            , unsigned int id3
            , unsigned bvSize);

    void addNoLockFacts(z3::context &ctx
            , Z3_fixedpoint &zfp
            , unsigned int id1
            , unsigned int id2
            , unsigned bvSize);


    void addReadFacts(z3::context &ctx
            , Z3_fixedpoint &zfp
            , unsigned int id1
            , unsigned int id2
            , unsigned int id3
            , unsigned bvSize);


    void addWriteFacts(z3::context &ctx
            , Z3_fixedpoint &zfp
            , unsigned int id1
            , unsigned int id2
            , unsigned int id3
            , unsigned bvSize);

    void addDomFacts(z3::context &ctx
            , Z3_fixedpoint &zfp
            , unsigned int id1
            , unsigned int id2
            , unsigned int id3
            , unsigned bvSize);

    void addPostDomFacts(z3::context &ctx
            , Z3_fixedpoint &zfp
            , unsigned int id1
            , unsigned int id2
            , unsigned int id3
            , unsigned bvSize);

    void addThreadCreateFacts(z3::context &ctx
            , Z3_fixedpoint &zfp
            , unsigned int id1
            , unsigned int id2
            , unsigned int id3
            , unsigned int id4
            , unsigned bvSize);

    void addThreadJoinFacts(z3::context &ctx
            , Z3_fixedpoint &zfp
            , unsigned int id1
            , unsigned int id2
            , unsigned int id3
            , unsigned int id4
            , unsigned bvSize);


    // Add the "st" relation.
    void addStRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "impo" relation.
    void addImpoRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "po" relation and its transitive property
    void addPoRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "dom" relation and its transitive property
    void addDomRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "postDom" relation and its transitive property
    void addPostDomRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "cannotPresent" relation.
    void addCannotPresentRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "threadCreate" relation.
    void addThreadCreateRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "threadJoin" relation.
    void addThreadJoinRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "lockAcquire" relation.
    void addLockAcquireRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "lockRelease" relation.
    void addLockReleaseRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "nonLock" relation.
    void addNonLockRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "sameAtSec" relation.
    void addSameAtSecRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "inAtSec" relation.
    void addInAtSecRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "diffAtSec" relation.
    void addDiffAtSecRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "mustHb" relation.
    void addMustHbRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "mayHb" relation.
    void addMayHbRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "mustNotOccurSeq" relation.
    void addMustNotOccurSeqRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "mustNotOccur2" relation.
    void addMustNotOccur2Rel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "mustNotOccur3" relation.
    void addMustNotOccur3Rel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "mayOccur2" relation.
    void addMayOccur2Rel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "mayOccur3" relation.
    void addMayOccur3Rel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "read" relation.
    void addReadRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "write" relation.
    void addWriteRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "rf" relation.
    void addRfRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "coveredRead" relation.
    void addCoveredReadRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "noRf" relation.
    void addNoRfRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "so" relation.
    void addSoRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "coveredWrite" relation.
    void addCoveredWriteRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "noSo" relation.
    void addNoSoRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "dep" relation.
    void addDepRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "p1Notp2Rank1" relation.
    void addP1Notp2Rank1Rel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "p2Notp1Rank1" relation.
    void addP2Notp1Rank1Rel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "p1Notp2Rank2" relation.
    void addP1Notp2Rank2Rel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "p2Notp1Rank2" relation.
    void addP2Notp1Rank2Rel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "p1Notp2Rank3" relation.
    void addP1Notp2Rank3Rel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "p2Notp1Rank3" relation.
    void addP2Notp1Rank3Rel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);
    // Add the "p1p2Equal" relation.
    void addP1p2EqualRel(z3::context &ctx, Z3_fixedpoint &zfp, unsigned);

}
