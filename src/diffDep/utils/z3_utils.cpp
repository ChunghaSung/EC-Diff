#include "z3_utils.h"


// function declaration of 1 variable rules
z3::func_decl z3_utils::getBV1FuncDecl(z3::context &ctx, const char *name
        , const unsigned bvSize) {
    z3::sort bvSort = ctx.bv_sort(bvSize);
    z3::sort boolSort = ctx.bool_sort();
    z3::sort domain[1] = {bvSort};
    z3::func_decl decl = ctx.function(ctx.str_symbol(name), 1, domain, boolSort);
    return decl;
}


// function declaration of 2 variables rules
z3::func_decl z3_utils::getBV2FuncDecl(z3::context &ctx, const char *name
        , const unsigned bvSize) {
    z3::sort bvSort = ctx.bv_sort(bvSize);
    z3::sort boolSort = ctx.bool_sort();
    z3::sort domain[2] = {bvSort, bvSort};
    z3::func_decl decl = ctx.function(ctx.str_symbol(name), 2, domain, boolSort);
    return decl;
}

// function declaration of 3 variables rules
z3::func_decl z3_utils::getBV3FuncDecl(z3::context &ctx, const char *name
        , const unsigned bvSize) {
    z3::sort bvSort = ctx.bv_sort(bvSize);
    z3::sort boolSort = ctx.bool_sort();
    z3::sort domain[3] = {bvSort, bvSort, bvSort};
    z3::func_decl decl = ctx.function(ctx.str_symbol(name), 3, domain, boolSort);
    return decl;
}

// function declaration of 4 variables rules
z3::func_decl z3_utils::getBV4FuncDecl(z3::context &ctx, const char *name
        , const unsigned bvSize) {
    z3::sort bvSort = ctx.bv_sort(bvSize);
    z3::sort boolSort = ctx.bool_sort();
    z3::sort domain[4] = {bvSort, bvSort, bvSort, bvSort};
    z3::func_decl decl = ctx.function(ctx.str_symbol(name), 4, domain, boolSort);
    return decl;
}

// function declaration of 5 variables rules
z3::func_decl z3_utils::getBV5FuncDecl(z3::context &ctx, const char *name
        , const unsigned bvSize) {
    z3::sort bvSort = ctx.bv_sort(bvSize);
    z3::sort boolSort = ctx.bool_sort();
    z3::sort domain[5] = {bvSort, bvSort, bvSort, bvSort, bvSort};
    z3::func_decl decl = ctx.function(ctx.str_symbol(name), 5, domain, boolSort);
    return decl;
}

// function declaration of 6 variables rules
z3::func_decl z3_utils::getBV6FuncDecl(z3::context &ctx, const char *name
        , const unsigned bvSize) {
    z3::sort bvSort = ctx.bv_sort(bvSize);
    z3::sort boolSort = ctx.bool_sort();
    z3::sort domain[6] = {bvSort, bvSort, bvSort, bvSort, bvSort, bvSort};
    z3::func_decl decl = ctx.function(ctx.str_symbol(name), 6, domain, boolSort);
    return decl;
}

// function declaration of 7 variables rules
z3::func_decl z3_utils::getBV7FuncDecl(z3::context &ctx, const char *name
        , const unsigned bvSize) {
    z3::sort bvSort = ctx.bv_sort(bvSize);
    z3::sort boolSort = ctx.bool_sort();
    z3::sort domain[7] = {bvSort, bvSort, bvSort, bvSort, bvSort, bvSort, bvSort};
    z3::func_decl decl = ctx.function(ctx.str_symbol(name), 7, domain, boolSort);
    return decl;
}


z3::expr z3_utils::getValueBVIDSz(z3::context &ctx, unsigned int id, unsigned bvSize) {
    assert(sizeof(unsigned) * 8 >= bvSize && "Bitvector size cannot fit in unsigned");

    if (std::ceil((std::log(id) / std::log(2))) > bvSize) {
        errs() << "[ERROR] Overflowing Bitvector size, increase it: "
            << "current size: " << bvSize << '\n';
        exit(EXIT_FAILURE);
    }
    z3::expr ret = ctx.bv_val(id, bvSize);
    return ret;
}


// add facts for 1 arguments
void z3_utils::addFact1Sz(z3::context &ctx
        , Z3_fixedpoint &zfp
        , z3::func_decl fd
        , unsigned v
        , unsigned bvSize) {
    z3::expr vID = getValueBVIDSz(ctx, v, bvSize);

    try {
        z3::expr args[1] = {vID};
        z3::expr app = fd(1, args);
        Z3_fixedpoint_add_rule(ctx, zfp, app, NULL);
    }
    catch (z3::exception e) {
        errs() << "[ERROR] Error adding fact: " << e.msg() << '\n';
        exit(EXIT_FAILURE);
    }
}


// add facts for 2 arguments
void z3_utils::addFact2Sz(z3::context &ctx
        , Z3_fixedpoint &zfp
        , z3::func_decl fd
        , unsigned int v1
        , unsigned int v2
        , unsigned bvSize) {
    z3::expr v1ID = getValueBVIDSz(ctx, v1, bvSize);
    z3::expr v2ID = getValueBVIDSz(ctx, v2, bvSize);

    try {
        z3::expr args[2] = {v1ID, v2ID};
        z3::expr app = fd(2, args);
        Z3_fixedpoint_add_rule(ctx, zfp, app, NULL);
    } catch (z3::exception e) {
        errs() << "[ERROR] Error adding fact: " << e.msg() << '\n';
        exit(EXIT_FAILURE);
    }
}

// add facts for 3 arguments
void z3_utils::addFact3Sz(z3::context &ctx
        , Z3_fixedpoint &zfp
        , z3::func_decl fd
        , unsigned int v1
        , unsigned int v2
        , unsigned int v3
        , unsigned bvSize) {
    z3::expr v1ID = getValueBVIDSz(ctx, v1, bvSize);
    z3::expr v2ID = getValueBVIDSz(ctx, v2, bvSize);
    z3::expr v3ID = getValueBVIDSz(ctx, v3, bvSize);

    try {
        z3::expr args[3] = {v1ID, v2ID, v3ID};
        z3::expr app = fd(3, args);
        Z3_fixedpoint_add_rule(ctx, zfp, app, NULL);
    } catch (z3::exception e) {
        errs() << "[ERROR] Error adding fact: " << e.msg() << '\n';
        exit(EXIT_FAILURE);
    }
}

// add facts for 4 arguments
void z3_utils::addFact4Sz(z3::context &ctx
        , Z3_fixedpoint &zfp
        , z3::func_decl fd
        , unsigned int v1
        , unsigned int v2
        , unsigned int v3
        , unsigned int v4
        , unsigned bvSize) {
    z3::expr v1ID = getValueBVIDSz(ctx, v1, bvSize);
    z3::expr v2ID = getValueBVIDSz(ctx, v2, bvSize);
    z3::expr v3ID = getValueBVIDSz(ctx, v3, bvSize);
    z3::expr v4ID = getValueBVIDSz(ctx, v4, bvSize);

    try {
        z3::expr args[4] = {v1ID, v2ID, v3ID, v4ID};
        z3::expr app = fd(4, args);
        Z3_fixedpoint_add_rule(ctx, zfp, app, NULL);
    } catch (z3::exception e) {
        errs() << "[ERROR] Error adding fact: " << e.msg() << '\n';
        exit(EXIT_FAILURE);
    }
}



void z3_utils::addTransRuleBV2(z3::context &ctx, Z3_fixedpoint &zfp
        , z3::func_decl fd, unsigned bvSize) {
    z3::sort bvSort = ctx.bv_sort(bvSize);
    z3::expr a = z3::expr(ctx, Z3_mk_bound(ctx, 0, bvSort));
    z3::expr b = z3::expr(ctx, Z3_mk_bound(ctx, 1, bvSort));
    z3::expr c = z3::expr(ctx, Z3_mk_bound(ctx, 2, bvSort));

    // (fd a b)
    z3::expr args2[2] = {a, b};
    z3::expr aFdB = fd(2, args2);
    // (fd b c)
    args2[0] = b;
    args2[1] = c;
    z3::expr bFdC = fd(2, args2);
    // (fd a c)
    args2[0] = a;
    args2[1] = c;
    z3::expr aFdC = fd(2, args2);
    // (and (fd a b) (fd b c))
    //args2[0] = aFdB;
    //args2[1] = bFdC;
    z3::expr fdAbAndBc = aFdB && bFdC;
    // (=> (and (fd a b) (fd b c)) (fd a c))
    z3::expr fdTrans = z3::implies(fdAbAndBc, aFdC);
    Z3_fixedpoint_add_rule(ctx, zfp, fdTrans, NULL);
}

void z3_utils::addTransRuleBV3(z3::context &ctx, Z3_fixedpoint &zfp
        , z3::func_decl fd, unsigned bvSize) {
    z3::sort bvSort = ctx.bv_sort(bvSize);
    z3::expr a = z3::expr(ctx, Z3_mk_bound(ctx, 0, bvSort));
    z3::expr b = z3::expr(ctx, Z3_mk_bound(ctx, 1, bvSort));
    z3::expr c = z3::expr(ctx, Z3_mk_bound(ctx, 2, bvSort));
    z3::expr d = z3::expr(ctx, Z3_mk_bound(ctx, 3, bvSort));

    // (fd a b d)
    z3::expr args1[3] = {a, b, d};
    z3::expr first = fd(3, args1);
    // (fd b c d)
    z3::expr args2[3] = {b, c, d};
    z3::expr second = fd(3, args2);
    // (fd a c d)
    z3::expr args3[3] = {a, c, d};
    z3::expr third = fd(3, args3);
    // (and (fd a b d) (fd b c d))
    z3::expr left = first && second;
    // (=> (and (fd a b d) (fd b c d)) (fd a c d))
    z3::expr fdTrans = z3::implies(left, third);
    Z3_fixedpoint_add_rule(ctx, zfp, fdTrans, NULL);
}

void z3_utils::addStFacts(z3::context &ctx
        , Z3_fixedpoint &zfp
        , unsigned int id1
        , unsigned int id2
        , unsigned int id3
        , unsigned bvSize) {

    z3::func_decl decl = getBV3FuncDecl(ctx, "st", bvSize);
    addFact3Sz(ctx, zfp, decl, id1, id2, id3, bvSize);
}

void z3_utils::addImPoFacts(z3::context &ctx
        , Z3_fixedpoint &zfp
        , unsigned int id1
        , unsigned int id2
        , unsigned int id3
        , unsigned bvSize) {

    z3::func_decl decl = getBV3FuncDecl(ctx, "impo", bvSize);
    addFact3Sz(ctx, zfp, decl, id1, id2, id3, bvSize);
}

void z3_utils::addLockFacts(z3::context &ctx
        , Z3_fixedpoint &zfp
        , unsigned int id1
        , unsigned int id2
        , unsigned int id3
        , unsigned bvSize) {

    z3::func_decl decl = getBV3FuncDecl(ctx, "lockAcquire", bvSize);
    addFact3Sz(ctx, zfp, decl, id1, id2, id3, bvSize);
}

void z3_utils::addUnLockFacts(z3::context &ctx
        , Z3_fixedpoint &zfp
        , unsigned int id1
        , unsigned int id2
        , unsigned int id3
        , unsigned bvSize) {

    z3::func_decl decl = getBV3FuncDecl(ctx, "lockRelease", bvSize);
    addFact3Sz(ctx, zfp, decl, id1, id2, id3, bvSize);
}

void z3_utils::addNoLockFacts(z3::context &ctx
        , Z3_fixedpoint &zfp
        , unsigned int id1
        , unsigned int id2
        , unsigned bvSize) {

    z3::func_decl decl = getBV2FuncDecl(ctx, "nonLock", bvSize);
    addFact2Sz(ctx, zfp, decl, id1, id2, bvSize);
}

void z3_utils::addReadFacts(z3::context &ctx
        , Z3_fixedpoint &zfp
        , unsigned int id1
        , unsigned int id2
        , unsigned int id3
        , unsigned bvSize) {

    z3::func_decl decl = getBV3FuncDecl(ctx, "read", bvSize);
    addFact3Sz(ctx, zfp, decl, id1, id2, id3, bvSize);
}

void z3_utils::addWriteFacts(z3::context &ctx
        , Z3_fixedpoint &zfp
        , unsigned int id1
        , unsigned int id2
        , unsigned int id3
        , unsigned bvSize) {

    z3::func_decl decl = getBV3FuncDecl(ctx, "read", bvSize);
    addFact3Sz(ctx, zfp, decl, id1, id2, id3, bvSize);
}

void z3_utils::addDomFacts(z3::context &ctx
        , Z3_fixedpoint &zfp
        , unsigned int id1
        , unsigned int id2
        , unsigned int id3
        , unsigned bvSize) {

    z3::func_decl decl = getBV3FuncDecl(ctx, "dom", bvSize);
    addFact3Sz(ctx, zfp, decl, id1, id2, id3, bvSize);
}

void z3_utils::addPostDomFacts(z3::context &ctx
        , Z3_fixedpoint &zfp
        , unsigned int id1
        , unsigned int id2
        , unsigned int id3
        , unsigned bvSize) {

    z3::func_decl decl = getBV3FuncDecl(ctx, "postDom", bvSize);
    addFact3Sz(ctx, zfp, decl, id1, id2, id3, bvSize);
}

void z3_utils::addThreadCreateFacts(z3::context &ctx
        , Z3_fixedpoint &zfp
        , unsigned int id1
        , unsigned int id2
        , unsigned int id3
        , unsigned int id4
        , unsigned bvSize) {

    z3::func_decl decl = getBV4FuncDecl(ctx, "threadCreate", bvSize);
    addFact4Sz(ctx, zfp, decl, id1, id2, id3, id4, bvSize);
}

void z3_utils::addThreadJoinFacts(z3::context &ctx
        , Z3_fixedpoint &zfp
        , unsigned int id1
        , unsigned int id2
        , unsigned int id3
        , unsigned int id4
        , unsigned bvSize) {

    z3::func_decl decl = getBV4FuncDecl(ctx, "threadJoin", bvSize);
    addFact4Sz(ctx, zfp, decl, id1, id2, id3, id4, bvSize);
}


// Add the "st" relation.
void z3_utils::addStRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV3FuncDecl(ctx, "st", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "impo" relation.
void z3_utils::addImpoRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV3FuncDecl(ctx, "impo", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "po" relation and its transitive property
void z3_utils::addPoRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV3FuncDecl(ctx, "po", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
    addTransRuleBV3(ctx, zfp, decl, bvSize);
}
// Add the "dom" relation and its transitive property
void z3_utils::addDomRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV3FuncDecl(ctx, "dom", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
    addTransRuleBV3(ctx, zfp, decl, bvSize);
}
// Add the "postDom" relation and its transitive property
void z3_utils::addPostDomRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV3FuncDecl(ctx, "postDom", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
    addTransRuleBV3(ctx, zfp, decl, bvSize);
}
// Add the "cannotPresent" relation.
void z3_utils::addCannotPresentRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV3FuncDecl(ctx, "cannotPresent", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "threadCreate" relation.
void z3_utils::addThreadCreateRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV4FuncDecl(ctx, "threadCreate", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "threadJoin" relation.
void z3_utils::addThreadJoinRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV4FuncDecl(ctx, "threadJoin", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "lockAcquire" relation.
void z3_utils::addLockAcquireRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV3FuncDecl(ctx, "lockAcquire", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "lockRelease" relation.
void z3_utils::addLockReleaseRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV3FuncDecl(ctx, "lockRelease", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "nonLock" relation.
void z3_utils::addNonLockRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV2FuncDecl(ctx, "nonLock", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "sameAtSec" relation.
void z3_utils::addSameAtSecRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV4FuncDecl(ctx, "sameAtSec", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "inAtSec" relation.
void z3_utils::addInAtSecRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV3FuncDecl(ctx, "inAtSec", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "diffAtSec" relation.
void z3_utils::addDiffAtSecRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV4FuncDecl(ctx, "diffAtSec", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "mustHb" relation.
void z3_utils::addMustHbRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV3FuncDecl(ctx, "mustHb", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "mayHb" relation.
void z3_utils::addMayHbRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV3FuncDecl(ctx, "mayHb", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "mustNotOccurSeq" relation.
void z3_utils::addMustNotOccurSeqRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV5FuncDecl(ctx, "mustNotOccurSeq", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "mustNotOccur2" relation.
void z3_utils::addMustNotOccur2Rel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV5FuncDecl(ctx, "mustNotOccur2", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "mustNotOccur3" relation.
void z3_utils::addMustNotOccur3Rel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV7FuncDecl(ctx, "mustNotOccur3", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "mayOccur2" relation.
void z3_utils::addMayOccur2Rel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV5FuncDecl(ctx, "mayOccur2", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "mayOccur3" relation.
void z3_utils::addMayOccur3Rel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV7FuncDecl(ctx, "mayOccur3", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "read" relation.
void z3_utils::addReadRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV3FuncDecl(ctx, "read", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "write" relation.
void z3_utils::addWriteRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV3FuncDecl(ctx, "write", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "rf" relation.
void z3_utils::addRfRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV4FuncDecl(ctx, "rf", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "coveredRead" relation.
void z3_utils::addCoveredReadRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV4FuncDecl(ctx, "coveredRead", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "noRf" relation.
void z3_utils::addNoRfRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV4FuncDecl(ctx, "noRf", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "so" relation.
void z3_utils::addSoRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV4FuncDecl(ctx, "so", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "coveredWrite" relation.
void z3_utils::addCoveredWriteRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV4FuncDecl(ctx, "coveredWrite", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "noSo" relation.
void z3_utils::addNoSoRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV4FuncDecl(ctx, "noSo", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "dep" relation.
void z3_utils::addDepRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV3FuncDecl(ctx, "dep", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "p1Notp2Rank1" relation.
void z3_utils::addP1Notp2Rank1Rel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV2FuncDecl(ctx, "p1Notp2Rank1", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "p2Notp1Rank1" relation.
void z3_utils::addP2Notp1Rank1Rel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV2FuncDecl(ctx, "p2Notp1Rank1", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "p1Notp2Rank2" relation.
void z3_utils::addP1Notp2Rank2Rel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV4FuncDecl(ctx, "p1Notp2Rank2", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "p2Notp1Rank2" relation.
void z3_utils::addP2Notp1Rank2Rel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV4FuncDecl(ctx, "p2Notp1Rank2", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "p1Notp2Rank3" relation.
void z3_utils::addP1Notp2Rank3Rel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV6FuncDecl(ctx, "p1Notp2Rank3", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "p2Notp1Rank3" relation.
void z3_utils::addP2Notp1Rank3Rel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV6FuncDecl(ctx, "p2Notp1Rank3", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
// Add the "p1p2Equal" relation.
void z3_utils::addP1p2EqualRel(z3::context &ctx, Z3_fixedpoint &zfp
        , unsigned bvSize) {
    z3::func_decl decl = getBV1FuncDecl(ctx, "p1p2Equal", bvSize);
    Z3_fixedpoint_register_relation(ctx, zfp, decl);
}
