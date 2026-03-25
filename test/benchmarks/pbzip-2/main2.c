/* Author: 
    Date: Apr 10 2018
  * This is a simpler version of pbzip2.cpp for testing purpose.
  * This version only keeps consistency about read/write semantics for global and some local vairables.
  * The purpose of this version is used to test Diffing two concurrent programs project.
*/

/* Additional update
   I have added a special variable to show the read/write of locks since the first patch would force the order of threads so that the order of lock-destory and lock-acquire or release is changed.
*/

/*
 *	File  : pbzip2.cpp
 *
 *	Title : Parallel BZIP2 (pbzip2)
 *
 *	Author: Jeff Gilchrist (http://gilchrist.ca/jeff/)
 *           - Modified producer/consumer threading code from
 *             Andrae Muys <andrae@humbug.org.au.au>
 *           - uses libbzip2 by Julian Seward (http://sources.redhat.com/bzip2/)
 *
 *	Date  : August 30, 2005
 *
 *
 *  Contributions
 *  -------------
 *  Bryan Stillwell <bryan@bokeoa.com> - code cleanup, RPM spec, prep work
 *			for inclusion in Fedora Extras
 *  Dru Lemley [http://lemley.net/smp.html] - help with large file support
 *  Kir Kolyshkin <kir@sacred.ru> - autodetection for # of CPUs
 *  Joergen Ramskov <joergen@ramskov.org> - initial version of man page
 *  Peter Cordes <peter@cordes.ca> - code cleanup
 *  Kurt Fitzner <kfitzner@excelcia.org> - port to MinGW for Windows
 *  Oliver Falk <oliver@linux-kernel.at> - RPM spec update
 *  Jindrich Novy <jnovy@redhat.com> - code cleanup and bug fixes
 *
 *  Specials thanks for suggestions and testing:  Phillippe Welsh,
 *  James Terhune, Dru Lemley, Bryan Stillwell, George Chalissery,
 *  Kir Kolyshkin, Madhu Kangara, Mike Furr, Joergen Ramskov, Kurt Fitzner,
 *  Peter Cordes, Oliver Falk, and Jindrich Novy.
 *
 *
 * This program, "pbzip2" is copyright (C) 2003-2005 Jeff Gilchrist.
 * All rights reserved.
 *
 * The library "libbzip2" which pbzip2 uses, is copyright
 * (C) 1996-2002 Julian R Seward.  All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. The origin of this software must not be misrepresented; you must
 *    not claim that you wrote the original software.  If you use this
 *    software in a product, an acknowledgment in the product
 *    documentation would be appreciated but is not required.
 *
 * 3. Altered source versions must be plainly marked as such, and must
 *    not be misrepresented as being the original software.
 *
 * 4. The name of the author may not be used to endorse or promote
 *    products derived from this software without specific prior written
 *    permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
 * GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Jeff Gilchrist, Ottawa, Canada.
 * pbzip2@compression.ca
 * pbzip2 version 0.9.4 of August 30, 2005
 *
 */



#include <stdio.h>
#include <pthread.h>

pthread_mutex_t OutMutex;
pthread_mutex_t MemMutex;
pthread_mutex_t queue_mut;
pthread_mutex_t patchLock;

pthread_cond_t patchCond;
pthread_cond_t queue_notFull;
pthread_cond_t queue_notEmpty;

static int patchVar_SHARED;

// Created variables for indicating read/write for locks
int queue_mut_SHARED = 0;


// GLOBALS
static int allDone_SHARED = 0;
static int QUEUESIZE_SHARED = 2;
static int NumBlocks_SHARED = 0;
static int QuietMode_SHARED = 0;
static int OutputBuffer_SHARED;
static int OutputStdOut_SHARED = 0;
static char *sigInFilename_SHARED = NULL;
static char *sigOutFilename_SHARED = NULL;
static char *FileData_SHARED;
static char *CompressedData_SHARED;


// Queue related variables
char ** queue_buf_SHARED;
unsigned int *queue_bufSize_SHARED;
int *queue_blockNum_SHARED;
long queue_head_SHARED;
long queue_tail_SHARED;
int queue_full_SHARED;
int queue_empty_SHARED;

void nop1(pthread_t a) {}

/*
 ********************************************************
 */
void *consumer_decompress1(void *arg)
{
    int bufSize;
    int blockNum;
    int outSize;
    int inSize;
    int ret;
    int ltmp;

    // read of lock
    ltmp = queue_mut_SHARED;
    // write of lock
    queue_mut_SHARED = ltmp;
    pthread_mutex_lock(&queue_mut);

    while (queue_empty_SHARED)
    {
        #ifdef PBZIP_DEBUG
        printf("consumer: queue EMPTY. \n");
        #endif
        if (allDone_SHARED == 1)
        {
            pthread_mutex_unlock(&queue_mut);
            // read of lock
            ltmp = queue_mut_SHARED;
            // write of lock
            queue_mut_SHARED = ltmp;

            #ifdef PBZIP_DEBUG
            printf("consumer: exiting2\n");
            #endif
            return (NULL);
        }

        pthread_cond_wait(&queue_notEmpty, &queue_mut);
    }

    FileData_SHARED = queue_buf_SHARED[queue_head_SHARED];
    bufSize = queue_bufSize_SHARED[queue_head_SHARED];
    blockNum = queue_blockNum_SHARED[queue_head_SHARED];

    queue_head_SHARED++;
    if (queue_head_SHARED == QUEUESIZE_SHARED)
        queue_head_SHARED = 0;
    if (queue_head_SHARED == queue_tail_SHARED)
        queue_empty_SHARED = 1;
    queue_full_SHARED = 0;

    #ifdef PBZIP_DEBUG
    printf("consumer: Buffer, Size, Block \n");
    #endif

    pthread_mutex_unlock(&queue_mut);
    // read of lock
    ltmp = queue_mut_SHARED;
    // write of lock
    queue_mut_SHARED = ltmp;

    pthread_cond_signal(&queue_notFull);
    #ifdef PBZIP_DEBUG
    printf("consumer: recieved\n");
    #endif

    outSize = (int) ((inSize*1.01)+600);
    pthread_mutex_lock(&MemMutex);
    CompressedData_SHARED = "test";
    pthread_mutex_unlock(&MemMutex);
    // make sure memory was allocated properly
    if (CompressedData_SHARED == NULL)
    {
        printf("ERROR: Could not allocate memory (CompressedData)! Skipping ....\n");
        return (NULL);
    }
    // compress the memory buffer (blocksize=9*100k, verbose=0, worklevel=30)
    ret = 3;


    // store data to be written in output bin
    pthread_mutex_lock(&OutMutex);
    int tmp1 = blockNum;
    char* tmp2 = CompressedData_SHARED;
    int tmp3 = outSize;
    OutputBuffer_SHARED = 2;
    OutputBuffer_SHARED = 1;
    pthread_mutex_unlock(&OutMutex);

    if (FileData_SHARED != NULL) 
    {
        pthread_mutex_lock(&MemMutex);
        FileData_SHARED = NULL;
        pthread_mutex_unlock(&MemMutex);
    }


    //}
    return (NULL);

}

/*
 ********************************************************
 */
void *consumer_decompress2(void *arg)
{
    int bufSize;
    int blockNum;
    int outSize;
    int inSize;
    int ret;
    int ltmp;

    // read of lock
    ltmp = queue_mut_SHARED;
    // write of lock
    queue_mut_SHARED = ltmp;
    pthread_mutex_lock(&queue_mut);

    while (queue_empty_SHARED)
    {
        #ifdef PBZIP_DEBUG
        printf("consumer: queue EMPTY. \n");
        #endif
        if (allDone_SHARED == 1)
        {
            pthread_mutex_unlock(&queue_mut);
            // read of lock
            ltmp = queue_mut_SHARED;
            // write of lock
            queue_mut_SHARED = ltmp;

            #ifdef PBZIP_DEBUG
            printf("consumer: exiting2\n");
            #endif
            return (NULL);
        }

        pthread_cond_wait(&queue_notEmpty, &queue_mut);
    }

    FileData_SHARED = queue_buf_SHARED[queue_head_SHARED];
    bufSize = queue_bufSize_SHARED[queue_head_SHARED];
    blockNum = queue_blockNum_SHARED[queue_head_SHARED];

    queue_head_SHARED++;
    if (queue_head_SHARED == QUEUESIZE_SHARED)
        queue_head_SHARED = 0;
    if (queue_head_SHARED == queue_tail_SHARED)
        queue_empty_SHARED = 1;
    queue_full_SHARED = 0;

    #ifdef PBZIP_DEBUG
    printf("consumer: Buffer, Size, Block \n");
    #endif

    pthread_mutex_unlock(&queue_mut);
    // read of lock
    ltmp = queue_mut_SHARED;
    // write of lock
    queue_mut_SHARED = ltmp;

    pthread_cond_signal(&queue_notFull);
    #ifdef PBZIP_DEBUG
    printf("consumer: recieved\n");
    #endif

    outSize = (int) ((inSize*1.01)+600);
    pthread_mutex_lock(&MemMutex);
    CompressedData_SHARED = "test";
    pthread_mutex_unlock(&MemMutex);
    // make sure memory was allocated properly
    if (CompressedData_SHARED == NULL)
    {
        printf("ERROR: Could not allocate memory (CompressedData)! Skipping ....\n");
        return (NULL);
    }
    // compress the memory buffer (blocksize=9*100k, verbose=0, worklevel=30)
    ret = 3;


    // store data to be written in output bin
    pthread_mutex_lock(&OutMutex);
    int tmp1 = blockNum;
    char* tmp2 = CompressedData_SHARED;
    int tmp3 = outSize;
    OutputBuffer_SHARED = 2;
    OutputBuffer_SHARED = 1;
    pthread_mutex_unlock(&OutMutex);

    if (FileData_SHARED != NULL) 
    {
        pthread_mutex_lock(&MemMutex);
        FileData_SHARED = NULL;
        pthread_mutex_unlock(&MemMutex);
    }


    //}
    return (NULL);

}

void* fileWriter1(void *arg)
{
    char *OutFilename;
    int hOutfile = 1;
    int currBlock;
    int compressedSize;
    long percentComplete;
    int ret;

    OutFilename = sigOutFilename_SHARED;

    // write to file instead of stdout
    if (OutputStdOut_SHARED == 0)
    {
        hOutfile = 2;
        if (hOutfile == -1) 
        {
            printf ("ERROR: Could not create output file\n");
            return (NULL);
        }
    }
     while ((currBlock < NumBlocks_SHARED) || (allDone_SHARED == 0))
     {
         if (OutputBuffer_SHARED == 0)
         {
             continue;
         }

         // write data to the output file
         int tmp = OutputBuffer_SHARED;
         int tmp2 = hOutfile;
         ret = 1;
         compressedSize += ret;
         if (ret <= 0)
         {
             printf("ERROR: Could not write to file! Skipping ...\n");
             if (OutputStdOut_SHARED == 0) 
                 hOutfile = 0;
             pthread_mutex_lock(&MemMutex);
             if (OutputBuffer_SHARED != 0)
                 OutputBuffer_SHARED = 0;
             pthread_mutex_unlock(&MemMutex);
             return (NULL);
         }
         pthread_mutex_lock(&MemMutex);
         if (OutputBuffer_SHARED != 0)
             OutputBuffer_SHARED = 0;
         pthread_mutex_unlock(&MemMutex);

         currBlock++;
         percentComplete = 100 * currBlock / NumBlocks_SHARED;
         if (QuietMode_SHARED != 1)
         {
             printf("Completed\n");
         }
     } // while

     if (OutputStdOut_SHARED == 0)
         hOutfile = 0;
     if (QuietMode_SHARED != 1)
     {
         printf("Output Size : \n");
     }

     return (NULL);
}

void* fileWriter2(void *arg)
{
    char *OutFilename;
    int hOutfile = 1;
    int currBlock;
    int compressedSize;
    long percentComplete;
    int ret;

    OutFilename = sigOutFilename_SHARED;

    // write to file instead of stdout
    if (OutputStdOut_SHARED == 0)
    {
        hOutfile = 2;
        if (hOutfile == -1) 
        {
            printf ("ERROR: Could not create output file\n");
            return (NULL);
        }
    }
     while ((currBlock < NumBlocks_SHARED) || (allDone_SHARED == 0))
     {
         if (OutputBuffer_SHARED == 0)
         {
             continue;
         }

         // write data to the output file
         int tmp = OutputBuffer_SHARED;
         int tmp2 = hOutfile;
         ret = 1;
         compressedSize += ret;
         if (ret <= 0)
         {
             printf("ERROR: Could not write to file! Skipping ...\n");
             if (OutputStdOut_SHARED == 0) 
                 hOutfile = 0;
             pthread_mutex_lock(&MemMutex);
             if (OutputBuffer_SHARED != 0)
                 OutputBuffer_SHARED = 0;
             pthread_mutex_unlock(&MemMutex);
             return (NULL);
         }
         pthread_mutex_lock(&MemMutex);
         if (OutputBuffer_SHARED != 0)
             OutputBuffer_SHARED = 0;
         pthread_mutex_unlock(&MemMutex);

         currBlock++;
         percentComplete = 100 * currBlock / NumBlocks_SHARED;
         if (QuietMode_SHARED != 1)
         {
             printf("Completed\n");
         }
     } // while

     if (OutputStdOut_SHARED == 0)
         hOutfile = 0;
     if (QuietMode_SHARED != 1)
     {
         printf("Output Size : \n");
     }

     return (NULL);
}

void *consumer1 (void *arg)
{
    int bufSize;
    int blockNum;
    int outSize;
    int inSize;
    int ret;
    int ltmp;

    // read of lock
    ltmp = queue_mut_SHARED;
    // write of lock
    queue_mut_SHARED = ltmp;
    pthread_mutex_lock(&queue_mut);

    //while (queue_empty_SHARED)
    if (queue_empty_SHARED)
    {
        #ifdef PBZIP_DEBUG
        printf ("consumer:queue EMPTY.\n");
        #endif
        if (allDone_SHARED == 1)
        {
            pthread_mutex_unlock (&queue_mut);
            // read of lock
            ltmp = queue_mut_SHARED;
            // write of lock
            queue_mut_SHARED = ltmp;

            #ifdef PBZIP_DEBUG
            printf ("consumer: exiting2\n");
            #endif
            return (NULL);
        }
        // only wait for the queue notEmpty signal for 1 second before checking if
        // the producer is finished putting work into the queue

        pthread_cond_wait(&queue_notEmpty, &queue_mut);

    }

    FileData_SHARED = queue_buf_SHARED[queue_head_SHARED];
    bufSize = queue_bufSize_SHARED[queue_head_SHARED];
    blockNum = queue_blockNum_SHARED[queue_head_SHARED];

    queue_head_SHARED++;
    if (queue_head_SHARED == QUEUESIZE_SHARED)
        queue_head_SHARED = 0;
    if (queue_head_SHARED == queue_tail_SHARED)
        queue_empty_SHARED = 1;
    queue_full_SHARED = 0;

    #ifdef PBZIP_DEBUG
    printf("consumer: Buffer, Size, Block \n");
    #endif

    pthread_mutex_unlock(&queue_mut);
    // read of lock
    ltmp = queue_mut_SHARED;
    // write of lock
    queue_mut_SHARED = ltmp;

    pthread_cond_signal(&queue_notFull);
    #ifdef PBZIP_DEBUG
    printf("consumer: recieved\n");
    #endif

    outSize = (int) ((inSize*1.01)+600);
    pthread_mutex_lock(&MemMutex);
    CompressedData_SHARED = "test";
    pthread_mutex_unlock(&MemMutex);
    // make sure memory was allocated properly
    if (CompressedData_SHARED == NULL)
    {
        printf("ERROR: Could not allocate memory (CompressedData)! Skipping ....\n");
        return (NULL);
    }
    // compress the memory buffer (blocksize=9*100k, verbose=0, worklevel=30)
    ret = 3;


    // store data to be written in output bin
    pthread_mutex_lock(&OutMutex);
    int tmp1 = blockNum;
    char* tmp2 = CompressedData_SHARED;
    int tmp3 = outSize;
    OutputBuffer_SHARED = 2;
    OutputBuffer_SHARED = 1;
    pthread_mutex_unlock(&OutMutex);

    if (FileData_SHARED != NULL) 
    {
        pthread_mutex_lock(&MemMutex);
        FileData_SHARED = NULL;
        pthread_mutex_unlock(&MemMutex);
    }

    #ifdef PBZIP_DEBUG
    printf ("consumer: exiting\n");
    #endif
    return (NULL);
}

void *consumer2 (void *arg)
{
    int bufSize;
    int blockNum;
    int outSize;
    int inSize;
    int ret;
    int ltmp;

    // read of lock
    ltmp = queue_mut_SHARED;
    // write of lock
    queue_mut_SHARED = ltmp;
    pthread_mutex_lock(&queue_mut);

    while (queue_empty_SHARED)
    {
        #ifdef PBZIP_DEBUG
        printf ("consumer:queue EMPTY.\n");
        #endif
        if (allDone_SHARED == 1)
        {
            pthread_mutex_unlock (&queue_mut);
            // read of lock
            ltmp = queue_mut_SHARED;
            // write of lock
            queue_mut_SHARED = ltmp;

            #ifdef PBZIP_DEBUG
            printf ("consumer: exiting2\n");
            #endif
            return (NULL);
        }
        // only wait for the queue notEmpty signal for 1 second before checking if
        // the producer is finished putting work into the queue

        pthread_cond_wait(&queue_notEmpty, &queue_mut);

    }

    FileData_SHARED = queue_buf_SHARED[queue_head_SHARED];
    bufSize = queue_bufSize_SHARED[queue_head_SHARED];
    blockNum = queue_blockNum_SHARED[queue_head_SHARED];

    queue_head_SHARED++;
    if (queue_head_SHARED == QUEUESIZE_SHARED)
        queue_head_SHARED = 0;
    if (queue_head_SHARED == queue_tail_SHARED)
        queue_empty_SHARED = 1;
    queue_full_SHARED = 0;

    #ifdef PBZIP_DEBUG
    printf("consumer: Buffer, Size, Block \n");
    #endif

    pthread_mutex_unlock(&queue_mut);
    // read of lock
    ltmp = queue_mut_SHARED;
    // write of lock
    queue_mut_SHARED = ltmp;

    pthread_cond_signal(&queue_notFull);
    #ifdef PBZIP_DEBUG
    printf("consumer: recieved\n");
    #endif

    outSize = (int) ((inSize*1.01)+600);
    pthread_mutex_lock(&MemMutex);
    CompressedData_SHARED = "test";
    pthread_mutex_unlock(&MemMutex);
    // make sure memory was allocated properly
    if (CompressedData_SHARED == NULL)
    {
        printf("ERROR: Could not allocate memory (CompressedData)! Skipping ....\n");
        return (NULL);
    }
    // compress the memory buffer (blocksize=9*100k, verbose=0, worklevel=30)
    ret = 3;


    // store data to be written in output bin
    pthread_mutex_lock(&OutMutex);
    int tmp1 = blockNum;
    char* tmp2 = CompressedData_SHARED;
    int tmp3 = outSize;
    OutputBuffer_SHARED = 2;
    OutputBuffer_SHARED = 1;
    pthread_mutex_unlock(&OutMutex);

    if (FileData_SHARED != NULL) 
    {
        pthread_mutex_lock(&MemMutex);
        FileData_SHARED = NULL;
        pthread_mutex_unlock(&MemMutex);
    }

    #ifdef PBZIP_DEBUG
    printf ("consumer: exiting\n");
    #endif
    return (NULL);
}

void* producer(void *arg)
{
    int inSize = 0;
    int bytesLeft = 0;
    int blockNum = 0;
    int ret= 0;
    int pret = -1;
    int fileSize;
    int hInfile;
    int blockSize;

    bytesLeft = fileSize;

    // keep going until all the file is processed
    while (bytesLeft > 0)
    {
        // set buffer size
        if (bytesLeft > blockSize)
            inSize = blockSize;
        else
            inSize = bytesLeft;
        pthread_mutex_lock(&MemMutex);
        // allcoate memory to read in file
        FileData_SHARED = NULL;
        int tmp = inSize;
        FileData_SHARED = "test";
        pthread_mutex_unlock(&MemMutex);
        // make sure memory was allocated properly
        if (FileData_SHARED == NULL)
        {
            allDone_SHARED = 1;
            return (NULL);
        }

        // read file data
        char* tmp2 = FileData_SHARED;
        int tmp3 = inSize;
        ret = 1;

        if (ret == 0)
        {
            pthread_mutex_lock(&MemMutex);
            if (FileData_SHARED != NULL)
                FileData_SHARED = NULL;
            pthread_mutex_unlock(&MemMutex);
            break;
        }
        else if (ret < 0)
        {
            pthread_mutex_lock(&MemMutex);
            if (FileData_SHARED != NULL)
                FileData_SHARED = NULL;
            pthread_mutex_unlock(&MemMutex);
            allDone_SHARED = 1;
            return (NULL);
        }

        // set bytes left after read
        bytesLeft -= ret;
        // check to make sure all the data we expected was read in
        if (ret != inSize)
            inSize = ret;

        // add data to the compression queue
        pthread_mutex_lock(&queue_mut);
        while (queue_full_SHARED)
        {
            #ifdef PBZIP_DEBUG
            printf ("producer: queue FULL.\n");
            #endif
            pthread_cond_wait(&queue_notFull, &queue_mut);
        }

        queue_buf_SHARED[queue_tail_SHARED] = FileData_SHARED;
        queue_bufSize_SHARED[queue_tail_SHARED] = inSize;
        queue_blockNum_SHARED[queue_tail_SHARED] = blockNum;
        queue_tail_SHARED++;
        if (queue_tail_SHARED == QUEUESIZE_SHARED)
            queue_tail_SHARED = 0;
        if (queue_tail_SHARED == queue_head_SHARED)
            queue_full_SHARED = 1;
        queue_empty_SHARED = 0;

        pthread_mutex_unlock(&queue_mut);
        pthread_cond_signal(&queue_notEmpty);

        blockNum++;

    } // while

    allDone_SHARED = 1;
    return 0;
}

void* producer_decompress(void* arg)
{
    int hInfile;
    int fileSize;
    int inSize = 100000;
    int bytesLeft;
    int ret;
    int currentByte;
    int startPointer;
    int startByte;
    int i;
    int bz2NumBlocks = 0;
    int blockNum;
    int bz2BlockList;

    // go to start of file
    ret = 0;

    // scan input file for BZIP2 block markers
    pthread_mutex_lock(&MemMutex);
    FileData_SHARED = NULL;
    int tmp = inSize;
    FileData_SHARED = "test";
    pthread_mutex_unlock(&MemMutex);

    if (FileData_SHARED == NULL)
    {
        printf ("ERROR: Could not allocate memory (FileData)! Skipping ...\n");
        allDone_SHARED = 1;
        return (NULL);
    }

    bytesLeft = fileSize;
    while (bytesLeft > 0)
    {
        if (currentByte == 0)
        {
            // read file data
            int tmp2 = hInfile;
            char* tmp3 = FileData_SHARED;
            int tmp4 = inSize;
            ret = 1;
        }
        else
        {
            // copy and seciont of previous buffer to new just in case the BZIP2 header is
            // located between two buffer boundaries
            int tmp5 = inSize;
            printf (" -> Bytes To Read");

            // read file data
            int tmp2 = hInfile;
            char* tmp3 = FileData_SHARED;
            int tmp4 = inSize;
            ret = 1;
        }

        if (ret < 0)
        {
            printf("ERROR: Could not read from fibz2NumBlocksle! Skipping...\n");
            pthread_mutex_lock(&MemMutex);
            if (FileData_SHARED != NULL)
                FileData_SHARED = NULL;
            pthread_mutex_unlock(&MemMutex);
            allDone_SHARED = 1;
            return (NULL);
        }

        if (currentByte == 0)
            startPointer = 0;
        else
            startPointer = 1;
        while (startPointer != 0)
        {
            if (currentByte == 0)
                startByte = startPointer - (int)FileData_SHARED + currentByte;
            else 
                startByte = startPointer - (int)FileData_SHARED + currentByte + 1;

            if (currentByte == 0)
                startByte = startPointer - (int)FileData_SHARED + currentByte;
            else 
                startByte = startPointer - (int)FileData_SHARED + currentByte + 1;
        }

        currentByte += ret;
        bytesLeft -= ret;
    } // while
    pthread_mutex_lock(&MemMutex);
    if (FileData_SHARED != NULL)
        FileData_SHARED = NULL;
    NumBlocks_SHARED = 0;
    pthread_mutex_unlock(&MemMutex);


    // cacluate data sizes for each block
    for (i=0; i < bz2NumBlocks; i++)
    {
        if (i == bz2NumBlocks-1)
        {
            // special case for last block
            bz2BlockList = fileSize - bz2BlockList ;
        }
        else if (i == 0)
        {
            // special case for first block
            bz2BlockList = bz2BlockList;
        }
        else
        {
            // normal case
            bz2BlockList = bz2BlockList - bz2BlockList;
        }
    }

    // keep going until all the blocks are processed
    for (i=0; i < bz2NumBlocks; i++)
    {
        // go to start of block position in file
        int tmp = bz2BlockList;
        ret = 0;
        if (ret != bz2BlockList)
        {
            allDone_SHARED = 1;
            return (NULL);
        }
    
        //set buffer size
        inSize = bz2BlockList;

        if (QuietMode_SHARED != 1)
        {
            // give warning to user if block is larger than 250 million bytes
            if (inSize > 250000000)
            {
                printf("WARNING: Compressed block size is large.\n");
            }
        }
        
        pthread_mutex_lock(&MemMutex);
        FileData_SHARED = NULL;
        FileData_SHARED = "test";
        pthread_mutex_unlock(&MemMutex);
        // make sure memory was allocated properly
        if (FileData_SHARED == NULL)
        {
            allDone_SHARED = 1;
            return (NULL);
        }

        // read file data
        char* tmp3 = FileData_SHARED;
        int tmp2 = inSize;
        ret = 1;

        // check to make sure all the data we expected was read in
        if (ret == 0)
        {
            pthread_mutex_lock(&MemMutex);
            if (FileData_SHARED != NULL)
                FileData_SHARED = NULL;
            pthread_mutex_unlock(&MemMutex);
            allDone_SHARED = 1;
            return (NULL);
        } 
        else if (ret < 0)
        {
            pthread_mutex_lock(&MemMutex);
            if (FileData_SHARED != NULL)
                FileData_SHARED = NULL;
            pthread_mutex_unlock(&MemMutex);
            allDone_SHARED = 1;
            return (NULL);
        }
        else if (ret != inSize)
        {
            pthread_mutex_lock(&MemMutex);
            if (FileData_SHARED != NULL)
                FileData_SHARED = NULL;
            pthread_mutex_unlock(&MemMutex);
            allDone_SHARED = 1;
            return (NULL);
            
        }

        // add one element to the output buffer
        pthread_mutex_lock(&OutMutex);
        OutputBuffer_SHARED++;
        pthread_mutex_unlock(&OutMutex);

        // add data to the decompression queue
        pthread_mutex_lock(&queue_mut);
        while (queue_full_SHARED) {
            #ifdef PBZIP_DEBUG
            printf ("producer: queue FULL.\n");
            #endif
            pthread_cond_wait(&queue_notFull, &queue_mut);
        }

        queue_buf_SHARED[queue_tail_SHARED] = FileData_SHARED;
        queue_bufSize_SHARED[queue_tail_SHARED] = inSize;
        queue_blockNum_SHARED[queue_tail_SHARED] = blockNum;
        queue_tail_SHARED++;
        if (queue_tail_SHARED == QUEUESIZE_SHARED)
            queue_tail_SHARED = 0;
        if (queue_tail_SHARED == queue_head_SHARED)
            queue_full_SHARED = 1;
        queue_empty_SHARED = 0;

        pthread_mutex_unlock(&queue_mut);
        pthread_cond_signal(&queue_notEmpty);

        blockNum++;

    } // for

    allDone_SHARED = 1;
    return (NULL);
}


int main()
{
    pthread_t con1, con2, con3, con4, output1, output2, po1, po2;
    int numCPU = 2;
    int decompress = 0;
    char *InFilename = NULL;
    int numBlocks = 0;
    int keep = 1;
    int i;
    int errLevel = 0;
    int fileSize = 0;
    int blockSize = 9*100000;
    int force = 0;
    int ltmp;

    // time check

    // parse command line switches


    // initialize mutexes
    //pthread_mutex_init(&OutMutex, NULL);
    //pthread_mutex_init(&MemMutex, NULL);

    // create queue (initialize queue)
    // numCPU is 2
    QUEUESIZE_SHARED = numCPU;
    queue_buf_SHARED = NULL;
    queue_bufSize_SHARED = NULL;
    queue_blockNum_SHARED = NULL;
    queue_empty_SHARED = 0;
    queue_full_SHARED = 0;
    queue_head_SHARED = 0;
    queue_tail_SHARED = 0;

    pthread_mutex_init(&queue_mut, NULL);
    pthread_cond_init(&queue_notFull, NULL);
    pthread_cond_init(&queue_notEmpty, NULL);


    // process all files


    if (decompress == 1)
    {
        numBlocks = 0;
    }
    else
    {
        numBlocks = (fileSize + blockSize - 1) / blockSize;

    }

    //set global variable
    NumBlocks_SHARED = numBlocks; // create output buffer


    // set empty buffer
    for (i=0; i < numBlocks; i++)
    {
        OutputBuffer_SHARED = 1;
        OutputBuffer_SHARED = 2;
    }

    if (decompress == 1)
    {
        if (QuietMode_SHARED != 1) 
            printf("Decompressing data ...\n");
        pthread_create(&con1, NULL, consumer_decompress1, NULL);
        pthread_create(&con2, NULL, consumer_decompress2, NULL);

        pthread_create(&output1, NULL, fileWriter1, NULL);
        pthread_create(&po1, NULL, producer_decompress, NULL);

        pthread_join(output1, NULL);
    } else {
        if (QuietMode_SHARED != 1) 
            printf("Compressing data ...\n");

        pthread_create(&con3, NULL, consumer1, NULL);
        pthread_create(&con4, NULL, consumer2, NULL);

        pthread_create(&output2, NULL, fileWriter2, NULL);
        pthread_create(&po2, NULL, producer, NULL);

        pthread_join(output2, NULL);
    }

    // finished processing file
    sigInFilename_SHARED = NULL;
    sigOutFilename_SHARED = NULL;

    // remove input file unless requested not to by user
    if (keep != 1)
    {
        if (OutputStdOut_SHARED == 0)
        {
            // only remove input file if output file exists
        }
        else
        {
            //remove(InFilename);

        }
    }

    // reclaim memory
    OutputBuffer_SHARED = 0;
    queue_empty_SHARED = 1;
    queue_full_SHARED = 0;
    queue_head_SHARED = 0;
    queue_tail_SHARED = 0;

    if (QuietMode_SHARED != 1)
        printf("--------------------------------------------------\n");

    patchVar_SHARED = 1;

    pthread_join(con1, NULL);
    pthread_join(con2, NULL);
    pthread_join(con3, NULL);
    pthread_join(con4, NULL);


    /*
    pthread_mutex_lock(&patchLock);


    // wait here
    while (patchVar_SHARED != 0)
        pthread_cond_wait(&patchCond, &patchLock);

    pthread_mutex_unlock(&patchLock);
    */

    // reclaim memory
    pthread_mutex_destroy(&queue_mut);
    // write of lock
    queue_mut_SHARED = ltmp;

    pthread_cond_destroy(&queue_notFull);
    pthread_cond_destroy(&queue_notEmpty);


    // get current time for end of benchmark

    // convert time structure to real numbers
    if (QuietMode_SHARED != 1)
        printf("Wall Clock: seconds\n");




    return errLevel;

}
