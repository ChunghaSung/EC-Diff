From ISSTA 2014

//NEWBUG01. race-condition found in iio-subsystem of linux-kernel. (http://wiki.analog.com/software/linux/docs/iio/iio)
//problem: use_count not locked from concurrent access. leads to miss-behaving notification-behaviour
//url: https://github.com/torvalds/linux/commit/a1a8e1dc111d6f05e7164e851e58219d428359e1#diff-d8af920ff77345cde4bbaabaca3cb13cR175
