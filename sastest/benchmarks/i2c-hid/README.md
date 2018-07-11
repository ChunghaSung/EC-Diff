// Modified by Chungha Sung
// This code is a modified version for standard C style
// from Abstract (Semantic) Diffing of Evolving Concurrent Programs [Bouajjani et al.] in SAS 2017.
// And, there is no any semantic difference from the original code.
// The original code is i2c-hid-buggy.c 

/* Example based on a bug in the i2c-hid driver.
 * This example illustrates the LOCK pattern.
 *
 * commit# 7a7d6d9c5fcd4b674da38e814cfc0724c67731b2
 */

/* Error scenario:
 *
 * open_thread                    close_thread
 * -----------                    ------------
 * (open == 0) --> yes
 * power_on=1
 * open++ // open=1
 *                                open-- // open=0
 *                                (open==0) --> yes
 * (open == 0) --> yes
 * power_on=1
 * open++ // open=1
 *                                power_on=0
 * assert (power_on) // ERROR
 */

/* One possible fix is to put locks around the body of i2c_hid_open() or i2c_hid_close().
 */


//(b) to (d)          (d) to (c)              (b) to (e)

/* A client wants to start using the device.
 * Powers up the device if it is currently closed. */
/*
void i2c_hid_open() {

//    lock();

    if (open_SHARED == 0) {
        power_on_SHARED = 1; // (b)
    }
    open_SHARED++;

    assert (power_on_SHARED != 0); // (c)

//    unlock();
}
*/

/* A client has stopped using the device.
 * Power down the device if this is the last client.
 */
/*
void i2c_hid_close ()
{

//    lock();

    open_SHARED--;

    if (open_SHARED == 0) {
        power_on_SHARED = 0;  // (d)
    }

    assert (power_on_SHARED == 0); // (e)

//    unlock();
}
*/
