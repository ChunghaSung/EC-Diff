From ISSTA 2015
//NEWBUG02. race-condition in broadcom tigon3 ethernet driver.
//problem: stats variable is not locked against concurrent access. could lead to inconsistent state.
//url: https://github.com/torvalds/linux/commit/0f566b208b41918053b2e67399673aaec02dde5d#diff-ee9b0abeec638cc316efd5b30e0e01e8R12576
//
// Markus: Modified to have one thread free and one thread modify
//
// `stats` is the "structure" modified if it is non-zero

