// Author: 
// Date: Apr 12 2018
/*
 * The patch has been done by adding lock regions with conditional statements.
 * Two versions are test with locks & conds and without locks & conds.
 * I kept the semantics of read/write operations in this program.
 * This is not original code since it has been updated for testing purpose.
 * Original code is from inspect paper (http://www.cs.utah.edu/~yuyang/inspect/)
*/
// the testing has been done by having different number of threads.
// Also, I am using a special variable to check the specific order.

/*
 *  compile:  gcc -g -o pfscan -pthread  pfscan.comb.c 
 *    
 *  execute:  ./pfscan  -n 4  "test"  /home/yuyang/
 *
 */


/*
 ** pfscan.c - Parallell File Scanner
 **
 ** Copyright (c) 2002 Peter Eriksson <pen@lysator.liu.se>
 **
 ** This program is free software; you can redistribute it and/or
 ** modify it as you wish - as long as you don't claim that you wrote
 ** it.
 **
 ** This program is distributed in the hope that it will be useful,
 ** but WITHOUT ANY WARRANTY; without even the implied warranty of
 ** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 */

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <ctype.h>
#include <string.h>
#include <signal.h>
#include <fcntl.h>
#include <ftw.h>
#include <locale.h>

#include <sys/types.h>
#include <sys/mman.h>
#include <sys/stat.h>

#include <sys/time.h>
#include <sys/resource.h>
#include <unistd.h>

#include <pthread.h>

/*********  the beginning of pfscan.c */

// special variable to check the order
int happen_SHARED;


char *argv0_SHARED = "pfscan";


int max_depth_SHARED = 64;

unsigned char *rstr_SHARED = NULL;
int rlen_SHARED = 0;

int debug_SHARED = 0;
int verbose_SHARED = 0;

int nworkers_SHARED = 0;

int aworkers_SHARED = 0;
pthread_mutex_t aworker_lock;
pthread_cond_t  aworker_cv;

int line_f_SHARED  = 0;
int maxlen_SHARED  = 64;
int ignore_case_SHARED = 0;

int n_matches_SHARED = 0;
int n_files_SHARED = 0;
size_t n_bytes_SHARED = 0;

pthread_mutex_t matches_lock;

//PQUEUE pqb;

pthread_mutex_t print_lock;


// structure BM
#define BM_ASIZE 256 /* Allowed character code values */

//BM bmb;
int *bmb_bmGs_SHARED;
int bmb_bmBc_SHARED[BM_ASIZE];
unsigned char *bmb_saved_x_SHARED;
int bmb_saved_m_SHARED;
int bmb_icase_SHARED;

char version_SHARED[] = "1.0";




// struct PQUEUE
void **q_buf_SHARED;
int q_qsize_SHARED;
int q_occupied_SHARED;
int q_nextin_SHARED;
int q_nextout_SHARED;
int q_closed_SHARED;

pthread_mutex_t q_mtx;
pthread_cond_t q_more;
pthread_cond_t q_less;

void nop1() {}

#if 0
int bm_search(BM *bmp,
        unsigned char *y,
        size_t n,
        int (*mfun)(unsigned char *buf, size_t n, size_t pos, void *misc),
        void *misc)
{
    ssize_t i, j;
    int  c;
    int nm = 0;

    return 0;

    /* Searching */
    j = 0;
    while (j <= n - bmp->saved_m) {
        for (i = bmp->saved_m - 1;
                i >= 0 && bmp->saved_x[i] == (bmp->icase ? tolower(y[i + j]) : y[i + j]);
                --i)
            ;

        if (i < 0){
            if (mfun){
                ++nm;	
                c = mfun(y, n, j, misc);
                if (c) 
                    return (c < 0 ? c : nm);		
                j += bmp->bmGs[0];
            }
            else
                return j;
        }
        else{
            unsigned char c = (bmp->icase ? tolower(y[i + j]) : y[i + j]);      
            j += MAX(bmp->bmGs[i], bmp->bmBc[c] - bmp->saved_m + 1 + i);
        }
    }

    return mfun == NULL ? -1 : nm;
}
#endif

void *worker1(void *arg)
{
    char *path;
    int got = 0;

    pthread_mutex_lock(&q_mtx);

    if (q_occupied_SHARED <= 0 && !q_closed_SHARED)
        pthread_cond_wait(&q_more, &q_mtx);

    if (q_occupied_SHARED > 0){
        path = q_buf_SHARED[q_nextout_SHARED++];
        q_nextout_SHARED %= q_qsize_SHARED;
        q_occupied_SHARED--;
        got = 1;

        pthread_mutex_unlock(&q_mtx);
        pthread_cond_signal(&q_less);
    }
    else 
    {
        pthread_mutex_unlock(&q_mtx);
    }

    if (got == 1)
    {
        //scan_file(path);
        char* pathname = path;
        int fd;
        size_t len;
        unsigned char *buf;
        struct stat sb;


        fd = open(pathname, O_RDONLY);
        if (fd < 0)
        {
            if (verbose_SHARED)
            {
                pthread_mutex_lock(&print_lock);

                fprintf(stderr, "%s : ERR : open() failed: %s\n", pathname, strerror(errno));

                pthread_mutex_unlock(&print_lock);
            }
        } else {

            if (fstat(fd, &sb) < 0)
            {
                if (verbose_SHARED)
                {
                    pthread_mutex_lock(&print_lock);

                    fprintf(stderr, "%s : ERR : fstat() failed: %s\n", pathname, strerror(errno));

                    pthread_mutex_unlock(&print_lock);
                }

                close(fd);
            } else {
                len = sb.st_size;

                if (debug_SHARED > 1)
                    fprintf(stderr, "*** Scanning file %s (%u Mbytes)\n",
                            pathname, (unsigned int) (len / 1000000));

                buf = (unsigned char *) mmap(NULL, len, PROT_READ, MAP_PRIVATE|MAP_NORESERVE, fd, 0);
                if (buf == MAP_FAILED)
                {
                    if (verbose_SHARED)
                    {
                        pthread_mutex_lock(&print_lock);

                        fprintf(stderr, "%s : ERR : mmap() failed: %s\n", pathname, strerror(errno));

                        pthread_mutex_unlock(&print_lock);
                    }

                    close(fd);
                } else {
                    if (rstr_SHARED)
                    {
                        int code;
                        //code = bm_search(&bmb, buf, len, matchfun, pathname);
                        code = 0;
                    }
                    else
                    {
                        pthread_mutex_lock(&print_lock);

                        printf("%s : 0 : ", pathname);
                        //print_output(buf, len);
                        unsigned char *str = buf;
                        size_t slen = len;
                        size_t len_tmp = 0;

                        if (str == NULL)
                        {
                            printf("NULL");

                        } else {
                            int ret_is_text;
                            unsigned char *cp = str;
                            while (slen > 0 && (isprint(*cp) || *cp == '\0' || *cp == '\t' || *cp == '\n' || *cp == '\r')) {
                                --slen;
                                ++cp;
                            }

                            ret_is_text =  (slen == 0);

                            if (ret_is_text)
                            {
                                printf("TXT : ");

                                while (len < slen && len < maxlen_SHARED)
                                {
                                    if (isprint(* (unsigned char *) str))
                                        putchar(*str);
                                    else
                                        switch (*str)
                                        {
                                            case '\0':
                                                printf("\\0");
                                                break;

                                            case '\n':
                                                if (!line_f_SHARED) {
                                                    printf("\\n");
                                                    break;
                                                }
                                            case '\r':
                                                if (!line_f_SHARED) {
                                                    printf("\\r");
                                                    break;
                                                }
                                            case '\t':
                                                printf("\\t");
                                                break;

                                            default:
                                                printf("\\x%02x", * (unsigned char *) str);
                                        }

                                    ++len;
                                    ++str;
                                }
                            }
                            else
                            {
                                printf("HEX :");
                                while (len < slen && len < maxlen_SHARED)
                                {
                                    printf(" %02x", * (unsigned char *) str);
                                    ++len;
                                    ++str;
                                }
                            }
                        }
                        putchar('\n');
                        pthread_mutex_unlock(&print_lock);
                    }
                    munmap((char *) buf, len);
                    close(fd);
                }
            }

        }

        free(path);
    }

    fflush(stdout);

    // special var to happen first
    happen_SHARED = 1;

    // patches
    pthread_mutex_lock(&aworker_lock);
    --aworkers_SHARED;
    pthread_cond_signal(&aworker_cv);
    pthread_mutex_unlock(&aworker_lock);

    return NULL;
}


void *worker2(void *arg)
{
    char *path;
    int got = 0;

    pthread_mutex_lock(&q_mtx);

    if (q_occupied_SHARED <= 0 && !q_closed_SHARED)
        pthread_cond_wait(&q_more, &q_mtx);

    if (q_occupied_SHARED > 0){
        path = q_buf_SHARED[q_nextout_SHARED++];
        q_nextout_SHARED %= q_qsize_SHARED;
        q_occupied_SHARED--;
        got = 1;

        pthread_mutex_unlock(&q_mtx);
        pthread_cond_signal(&q_less);
    }
    else 
    {
        pthread_mutex_unlock(&q_mtx);
    }

    if (got == 1)
    {
        //scan_file(path);
        char* pathname = path;
        int fd;
        size_t len;
        unsigned char *buf;
        struct stat sb;


        fd = open(pathname, O_RDONLY);
        if (fd < 0)
        {
            if (verbose_SHARED)
            {
                pthread_mutex_lock(&print_lock);

                fprintf(stderr, "%s : ERR : open() failed: %s\n", pathname, strerror(errno));

                pthread_mutex_unlock(&print_lock);
            }
        } else {

            if (fstat(fd, &sb) < 0)
            {
                if (verbose_SHARED)
                {
                    pthread_mutex_lock(&print_lock);

                    fprintf(stderr, "%s : ERR : fstat() failed: %s\n", pathname, strerror(errno));

                    pthread_mutex_unlock(&print_lock);
                }

                close(fd);
            } else {
                len = sb.st_size;

                if (debug_SHARED > 1)
                    fprintf(stderr, "*** Scanning file %s (%u Mbytes)\n",
                            pathname, (unsigned int) (len / 1000000));

                buf = (unsigned char *) mmap(NULL, len, PROT_READ, MAP_PRIVATE|MAP_NORESERVE, fd, 0);
                if (buf == MAP_FAILED)
                {
                    if (verbose_SHARED)
                    {
                        pthread_mutex_lock(&print_lock);

                        fprintf(stderr, "%s : ERR : mmap() failed: %s\n", pathname, strerror(errno));

                        pthread_mutex_unlock(&print_lock);
                    }

                    close(fd);
                } else {
                    if (rstr_SHARED)
                    {
                        int code;
                        //code = bm_search(&bmb, buf, len, matchfun, pathname);
                        code = 0;
                    }
                    else
                    {
                        pthread_mutex_lock(&print_lock);

                        printf("%s : 0 : ", pathname);
                        //print_output(buf, len);
                        unsigned char *str = buf;
                        size_t slen = len;
                        size_t len_tmp = 0;

                        if (str == NULL)
                        {
                            printf("NULL");

                        } else {
                            int ret_is_text;
                            unsigned char *cp = str;
                            while (slen > 0 && (isprint(*cp) || *cp == '\0' || *cp == '\t' || *cp == '\n' || *cp == '\r')) {
                                --slen;
                                ++cp;
                            }

                            ret_is_text =  (slen == 0);

                            if (ret_is_text)
                            {
                                printf("TXT : ");

                                while (len < slen && len < maxlen_SHARED)
                                {
                                    if (isprint(* (unsigned char *) str))
                                        putchar(*str);
                                    else
                                        switch (*str)
                                        {
                                            case '\0':
                                                printf("\\0");
                                                break;

                                            case '\n':
                                                if (!line_f_SHARED) {
                                                    printf("\\n");
                                                    break;
                                                }
                                            case '\r':
                                                if (!line_f_SHARED) {
                                                    printf("\\r");
                                                    break;
                                                }
                                            case '\t':
                                                printf("\\t");
                                                break;

                                            default:
                                                printf("\\x%02x", * (unsigned char *) str);
                                        }

                                    ++len;
                                    ++str;
                                }
                            }
                            else
                            {
                                printf("HEX :");
                                while (len < slen && len < maxlen_SHARED)
                                {
                                    printf(" %02x", * (unsigned char *) str);
                                    ++len;
                                    ++str;
                                }
                            }
                        }
                        putchar('\n');
                        pthread_mutex_unlock(&print_lock);
                    }
                    munmap((char *) buf, len);
                    close(fd);
                }
            }

        }

        free(path);
    }

    fflush(stdout);

    // special var to happen first
    happen_SHARED = 1;

    // patches
    pthread_mutex_lock(&aworker_lock);
    --aworkers_SHARED;
    pthread_cond_signal(&aworker_cv);
    pthread_mutex_unlock(&aworker_lock);

    return NULL;
}

#if 0
void *worker3(void *arg)
{
    char *path;
    int got = 0;

    pthread_mutex_lock(&q_mtx);

    if (q_occupied_SHARED <= 0 && !q_closed_SHARED)
        pthread_cond_wait(&q_more, &q_mtx);

    if (q_occupied_SHARED > 0){
        path = q_buf_SHARED[q_nextout_SHARED++];
        q_nextout_SHARED %= q_qsize_SHARED;
        q_occupied_SHARED--;
        got = 1;

        pthread_mutex_unlock(&q_mtx);
        pthread_cond_signal(&q_less);
    }
    else 
    {
        pthread_mutex_unlock(&q_mtx);
    }

    if (got == 1)
    {
        //scan_file(path);
        char* pathname = path;
        int fd;
        size_t len;
        unsigned char *buf;
        struct stat sb;


        fd = open(pathname, O_RDONLY);
        if (fd < 0)
        {
            if (verbose_SHARED)
            {
                pthread_mutex_lock(&print_lock);

                fprintf(stderr, "%s : ERR : open() failed: %s\n", pathname, strerror(errno));

                pthread_mutex_unlock(&print_lock);
            }
        } else {

            if (fstat(fd, &sb) < 0)
            {
                if (verbose_SHARED)
                {
                    pthread_mutex_lock(&print_lock);

                    fprintf(stderr, "%s : ERR : fstat() failed: %s\n", pathname, strerror(errno));

                    pthread_mutex_unlock(&print_lock);
                }

                close(fd);
            } else {
                len = sb.st_size;

                if (debug_SHARED > 1)
                    fprintf(stderr, "*** Scanning file %s (%u Mbytes)\n",
                            pathname, (unsigned int) (len / 1000000));

                buf = (unsigned char *) mmap(NULL, len, PROT_READ, MAP_PRIVATE|MAP_NORESERVE, fd, 0);
                if (buf == MAP_FAILED)
                {
                    if (verbose_SHARED)
                    {
                        pthread_mutex_lock(&print_lock);

                        fprintf(stderr, "%s : ERR : mmap() failed: %s\n", pathname, strerror(errno));

                        pthread_mutex_unlock(&print_lock);
                    }

                    close(fd);
                } else {
                    if (rstr_SHARED)
                    {
                        int code;
                        //code = bm_search(&bmb, buf, len, matchfun, pathname);
                        code = 0;
                    }
                    else
                    {
                        pthread_mutex_lock(&print_lock);

                        printf("%s : 0 : ", pathname);
                        //print_output(buf, len);
                        unsigned char *str = buf;
                        size_t slen = len;
                        size_t len_tmp = 0;

                        if (str == NULL)
                        {
                            printf("NULL");

                        } else {
                            int ret_is_text;
                            unsigned char *cp = str;
                            while (slen > 0 && (isprint(*cp) || *cp == '\0' || *cp == '\t' || *cp == '\n' || *cp == '\r')) {
                                --slen;
                                ++cp;
                            }

                            ret_is_text =  (slen == 0);

                            if (ret_is_text)
                            {
                                printf("TXT : ");

                                while (len < slen && len < maxlen_SHARED)
                                {
                                    if (isprint(* (unsigned char *) str))
                                        putchar(*str);
                                    else
                                        switch (*str)
                                        {
                                            case '\0':
                                                printf("\\0");
                                                break;

                                            case '\n':
                                                if (!line_f_SHARED) {
                                                    printf("\\n");
                                                    break;
                                                }
                                            case '\r':
                                                if (!line_f_SHARED) {
                                                    printf("\\r");
                                                    break;
                                                }
                                            case '\t':
                                                printf("\\t");
                                                break;

                                            default:
                                                printf("\\x%02x", * (unsigned char *) str);
                                        }

                                    ++len;
                                    ++str;
                                }
                            }
                            else
                            {
                                printf("HEX :");
                                while (len < slen && len < maxlen_SHARED)
                                {
                                    printf(" %02x", * (unsigned char *) str);
                                    ++len;
                                    ++str;
                                }
                            }
                        }
                        putchar('\n');
                        pthread_mutex_unlock(&print_lock);
                    }
                    munmap((char *) buf, len);
                    close(fd);
                }
            }

        }

        free(path);
    }

    fflush(stdout);

    // special var to happen first
    happen_SHARED = 1;

    // patches
    pthread_mutex_lock(&aworker_lock);
    --aworkers_SHARED;
    pthread_cond_signal(&aworker_cv);
    pthread_mutex_unlock(&aworker_lock);

    return NULL;
}

void *worker4(void *arg)
{
    char *path;
    int got = 0;

    pthread_mutex_lock(&q_mtx);

    if (q_occupied_SHARED <= 0 && !q_closed_SHARED)
        pthread_cond_wait(&q_more, &q_mtx);

    if (q_occupied_SHARED > 0){
        path = q_buf_SHARED[q_nextout_SHARED++];
        q_nextout_SHARED %= q_qsize_SHARED;
        q_occupied_SHARED--;
        got = 1;

        pthread_mutex_unlock(&q_mtx);
        pthread_cond_signal(&q_less);
    }
    else 
    {
        pthread_mutex_unlock(&q_mtx);
    }

    if (got == 1)
    {
        //scan_file(path);
        char* pathname = path;
        int fd;
        size_t len;
        unsigned char *buf;
        struct stat sb;


        fd = open(pathname, O_RDONLY);
        if (fd < 0)
        {
            if (verbose_SHARED)
            {
                pthread_mutex_lock(&print_lock);

                fprintf(stderr, "%s : ERR : open() failed: %s\n", pathname, strerror(errno));

                pthread_mutex_unlock(&print_lock);
            }
        } else {

            if (fstat(fd, &sb) < 0)
            {
                if (verbose_SHARED)
                {
                    pthread_mutex_lock(&print_lock);

                    fprintf(stderr, "%s : ERR : fstat() failed: %s\n", pathname, strerror(errno));

                    pthread_mutex_unlock(&print_lock);
                }

                close(fd);
            } else {
                len = sb.st_size;

                if (debug_SHARED > 1)
                    fprintf(stderr, "*** Scanning file %s (%u Mbytes)\n",
                            pathname, (unsigned int) (len / 1000000));

                buf = (unsigned char *) mmap(NULL, len, PROT_READ, MAP_PRIVATE|MAP_NORESERVE, fd, 0);
                if (buf == MAP_FAILED)
                {
                    if (verbose_SHARED)
                    {
                        pthread_mutex_lock(&print_lock);

                        fprintf(stderr, "%s : ERR : mmap() failed: %s\n", pathname, strerror(errno));

                        pthread_mutex_unlock(&print_lock);
                    }

                    close(fd);
                } else {
                    if (rstr_SHARED)
                    {
                        int code;
                        //code = bm_search(&bmb, buf, len, matchfun, pathname);
                        code = 0;
                    }
                    else
                    {
                        pthread_mutex_lock(&print_lock);

                        printf("%s : 0 : ", pathname);
                        //print_output(buf, len);
                        unsigned char *str = buf;
                        size_t slen = len;
                        size_t len_tmp = 0;

                        if (str == NULL)
                        {
                            printf("NULL");

                        } else {
                            int ret_is_text;
                            unsigned char *cp = str;
                            while (slen > 0 && (isprint(*cp) || *cp == '\0' || *cp == '\t' || *cp == '\n' || *cp == '\r')) {
                                --slen;
                                ++cp;
                            }

                            ret_is_text =  (slen == 0);

                            if (ret_is_text)
                            {
                                printf("TXT : ");

                                while (len < slen && len < maxlen_SHARED)
                                {
                                    if (isprint(* (unsigned char *) str))
                                        putchar(*str);
                                    else
                                        switch (*str)
                                        {
                                            case '\0':
                                                printf("\\0");
                                                break;

                                            case '\n':
                                                if (!line_f_SHARED) {
                                                    printf("\\n");
                                                    break;
                                                }
                                            case '\r':
                                                if (!line_f_SHARED) {
                                                    printf("\\r");
                                                    break;
                                                }
                                            case '\t':
                                                printf("\\t");
                                                break;

                                            default:
                                                printf("\\x%02x", * (unsigned char *) str);
                                        }

                                    ++len;
                                    ++str;
                                }
                            }
                            else
                            {
                                printf("HEX :");
                                while (len < slen && len < maxlen_SHARED)
                                {
                                    printf(" %02x", * (unsigned char *) str);
                                    ++len;
                                    ++str;
                                }
                            }
                        }
                        putchar('\n');
                        pthread_mutex_unlock(&print_lock);
                    }
                    munmap((char *) buf, len);
                    close(fd);
                }
            }

        }

        free(path);
    }

    fflush(stdout);

    // special var to happen first
    happen_SHARED = 1;

    // patches
    pthread_mutex_lock(&aworker_lock);
    --aworkers_SHARED;
    pthread_cond_signal(&aworker_cv);
    pthread_mutex_unlock(&aworker_lock);

    return NULL;
}
#endif


int main(int argc, char *argv[])
{
    int i, j;
    struct rlimit rlb;
    char *arg;
    pthread_t tid;
    //pthread_attr_t pab;
    pthread_t t1, t2, t3, t4;

    int yu_tmp_len;

    argv0_SHARED = argv[0];

    setlocale(LC_CTYPE, "");

    getrlimit(RLIMIT_NOFILE, &rlb);
    rlb.rlim_cur = rlb.rlim_max;
    setrlimit(RLIMIT_NOFILE, &rlb);

    signal(SIGPIPE, SIG_IGN);

    nworkers_SHARED = 2;

    pthread_mutex_init(&print_lock, NULL);
    pthread_mutex_init(&aworker_lock, NULL);
    pthread_mutex_init(&matches_lock, NULL);

    pthread_cond_init(&aworker_cv, NULL);

    for (i = 1; i < argc && argv[i][0] == '-'; i++)
        for (j = 1; j > 0 && argv[i][j]; ++j)
            switch (argv[i][j])
            {
                case '-':  ++i; goto EndOptions;

                case 'V': 
                           //print_version(stdout);	
                           fprintf(stdout, "[PFScan, version %s - %s %s]\n",
                                   version_SHARED,
                                   __DATE__, __TIME__);

                           break;
                case 'd':		++debug_SHARED;		break;
                case 'i':		ignore_case_SHARED = 1;		break;

                case 'v':
                                ++verbose_SHARED;
                                break;

                case 'h':
                                //usage(stdout);

                                fprintf(stdout, "Usage: %s [<options>] <search-string> <pathname> [... <pathname-N>]\n", argv0_SHARED);

                                fputs("\n\
                                        This program implements a multithreaded file scanner.\n\
                                        More information may be found at:\n\
                                        \thttp://www.lysator.liu.se/~pen/pfscan\n\
                                        \n\
                                        Command line options:\n", stdout);

                                fprintf(stdout, "\t-h             Display this information.\n");
                                fprintf(stdout, "\t-V             Print version.\n");
                                fprintf(stdout, "\t-v             Be verbose.\n");
                                fprintf(stdout, "\t-d             Print debugging info.\n");
                                fprintf(stdout, "\t-i             Ignore case when scanning.\n");
                                fprintf(stdout, "\t-l             Line oriented output.\n");
                                fprintf(stdout, "\t-n<workers>    Concurrent worker threads limit.\n");
                                fprintf(stdout, "\t-L<length>     Max length of bytes to print.\n");
                                exit(0);

                case 'l':
                                ++line_f_SHARED;
                                break;

                case 'L':
                                if (argv[i][2])	 arg = argv[i]+2;
                                else  arg = argv[++i];

                                if (!arg || sscanf(arg, "%u", &maxlen_SHARED) != 1){
                                    fprintf(stderr, "%s: Invalid length specification: %s\n", argv[0], arg ? arg : "<null>");
                                    exit(1);
                                }
                                j = -2;
                                break;

                case 'n':
                                if (argv[i][2])  arg = argv[i]+2;  else   arg = argv[++i];		
                                if (!arg || sscanf(arg, "%u", &nworkers_SHARED) != 1){
                                    fprintf(stderr,"%s: Invalid workers specification: %s\n",  argv[0], arg ? arg : "<null>");
                                    exit(1);
                                }
                                j = -2;
                                break;

                default:
                                fprintf(stderr, "%s: unknown command line switch: -%c\n",
                                        argv[0], argv[i][j]);
                                exit(1);
            }

EndOptions:

    yu_tmp_len = strlen(argv[i]) + 1;
    rstr_SHARED = (unsigned char*) malloc( yu_tmp_len * sizeof(unsigned char));


    strcpy(rstr_SHARED, argv[i]); //, yu_tmp_len);    
    i++;

    //rlen_SHARED = deslash(rstr_SHARED);
    unsigned char *str = rstr_SHARED;
    unsigned char *wp, *rp;
    rp = wp = str;
    while (*rp){
        if (*rp != '\\')
            *wp++ = *rp++;
        else{
            int val, len, base;
            unsigned char **cp;
            switch (*++rp){
                case 'n': *wp++ = 10; ++rp; break;	
                case 'r':	*wp++ = 13; ++rp; break;
                case 't': *wp++ = 9;  ++rp; break;
                case 'b': *wp++ = 8;  ++rp; break;
                case 'x': 
                          ++rp;	
                          //*wp++ = get_char_code(&rp, 16); 
                          val = 0;
                          len = 0;
                          base = 16;
                          cp = &rp;


                          while (len < (base == 16 ? 2 : 3) &&
                                  ((**cp >= '0' && **cp < '0'+(base > 10 ? 10 : base)) ||
                                   (base >= 10 && toupper(**cp) >= 'A' && toupper(**cp) < 'A'+base-10)))
                          {
                              val *= base;

                              if (**cp >= '0' && **cp < '0'+(base > 10 ? 10 : base))
                                  val += **cp - '0';
                              else if (base >= 10 &&
                                      toupper(**cp) >= 'A' && toupper(**cp) < 'A'+base-10)
                                  val += toupper(**cp) - 'A' + 10;

                              ++*cp;
                              ++len;
                          }

                          *wp++ = val & 0xFF;

                          break;

                case '0': 
                          //*wp++ = get_char_code(&rp, 8);	
                          val = 0;
                          len = 0;
                          base = 8;
                          cp = &rp;


                          while (len < (base == 16 ? 2 : 3) &&
                                  ((**cp >= '0' && **cp < '0'+(base > 10 ? 10 : base)) ||
                                   (base >= 10 && toupper(**cp) >= 'A' && toupper(**cp) < 'A'+base-10)))
                          {
                              val *= base;

                              if (**cp >= '0' && **cp < '0'+(base > 10 ? 10 : base))
                                  val += **cp - '0';
                              else if (base >= 10 &&
                                      toupper(**cp) >= 'A' && toupper(**cp) < 'A'+base-10)
                                  val += toupper(**cp) - 'A' + 10;

                              ++*cp;
                              ++len;
                          }

                          *wp++ = val & 0xFF;

                          break;

                case '1':
                case '2':
                case '3':
                case '4':
                case '5':
                case '6':
                case '7':
                case '8':
                case '9':	
                          //*wp++ = get_char_code(&rp, 10);	

                          val = 0;
                          len = 0;
                          base = 10;
                          cp = &rp;


                          while (len < (base == 16 ? 2 : 3) &&
                                  ((**cp >= '0' && **cp < '0'+(base > 10 ? 10 : base)) ||
                                   (base >= 10 && toupper(**cp) >= 'A' && toupper(**cp) < 'A'+base-10)))
                          {
                              val *= base;

                              if (**cp >= '0' && **cp < '0'+(base > 10 ? 10 : base))
                                  val += **cp - '0';
                              else if (base >= 10 &&
                                      toupper(**cp) >= 'A' && toupper(**cp) < 'A'+base-10)
                                  val += toupper(**cp) - 'A' + 10;

                              ++*cp;
                              ++len;
                          }

                          *wp++ = val & 0xFF;
                          break;

                default:	*wp++ = *rp++;	break;
            }
        }
    }

    *wp = '\0';
    rlen_SHARED = wp-str;


    // bm_init
    int tmp_ret;
    unsigned char *x = rstr_SHARED;
    int m = rlen_SHARED;
    int icase = ignore_case_SHARED;
    int *bmp_icase = &bmb_icase_SHARED;

    //memset(bmp, 0, sizeof(bmp));

    bmb_icase_SHARED = icase;
    bmb_bmGs_SHARED = (int *) calloc(sizeof(int), m);
    if (bmb_bmGs_SHARED == NULL) {
        tmp_ret = -1;
    } else {
        bmb_saved_m_SHARED = m;
        bmb_saved_x_SHARED = (unsigned char *) malloc(m);
        if (bmb_saved_x_SHARED == NULL) {
            tmp_ret = -2;
        } else {
            for (i = 0; i < m; i++) {
                bmb_saved_x_SHARED[i] = icase ? tolower(x[i]) : x[i];
            }

            /* Preprocessing */
            
            //if (preBmGs(bmb_saved_x_SHARED, m, bmb_bmGs_SHARED) < 0) {
            static int preBmGs_ret;
            unsigned char *x = bmb_saved_x_SHARED;
            int* bmGs = bmb_bmGs_SHARED;
            int *suff, i, j;

            suff = (int *) calloc(sizeof(int), m);
            if (suff == NULL) {
                preBmGs_ret = -1;
            } else {
                //suffixes(x, m, suff);
                int f, g, i;

                f = 0;
                suff[m - 1] = m;
                g = m - 1;
                for (i = m - 2; i >= 0; --i){ 
                    if (i > g && suff[i + m - 1 - f] < i - g)
                        suff[i] = suff[i + m - 1 - f];
                    else {
                        if (i < g)
                            g = i;
                        f = i;
                        while (g >= 0 && x[g] == x[g + m - 1 - f])
                            --g;
                        suff[i] = f - g;
                    }
                }

                for (i = 0; i < m; ++i)
                    bmGs[i] = m;

                j = 0;
                for (i = m - 1; i >= -1; --i)
                    if (i == -1 || suff[i] == i + 1)
                        for (; j < m - 1 - i; ++j)
                            if (bmGs[j] == m)
                                bmGs[j] = m - 1 - i;

                for (i = 0; i <= m - 2; ++i)
                    bmGs[m - 1 - suff[i]] = m - 1 - i;

                free(suff);
                preBmGs_ret = 0;
            }


            if (preBmGs_ret < 0) {
                tmp_ret = -3;
            } else {
                //preBmBc((unsigned char *) bmb_saved_x_SHARED, m, bmb_bmBc_SHARED);  
                int i;
                unsigned char *x = (unsigned char *) bmb_saved_x_SHARED;
                int* bmBc = bmb_bmBc_SHARED;

                for (i = 0; i < BM_ASIZE; ++i) bmBc[i] = m;    
                for (i = 0; i < m - 1; ++i)  bmBc[x[i]] = m - i - 1;

            }
        }
    }


    if (tmp_ret < 0)
    {
        fprintf(stderr, "%s: Failed search string setup: %s\n",
                argv[0], rstr_SHARED);
        exit(1);
    }

    max_depth_SHARED = rlb.rlim_max - nworkers_SHARED - 16;

    if (debug_SHARED)
        fprintf(stderr, "max_depth = %d, nworkers = %d\n", max_depth_SHARED,
                nworkers_SHARED);

    //pqueue_init(&pqb, nworkers + 8);
    int qsize = nworkers_SHARED + 8;
    q_buf_SHARED = calloc(sizeof(void *), qsize);
    if (q_buf_SHARED != NULL) {
        q_qsize_SHARED = qsize;
        q_occupied_SHARED = 0;
        q_nextin_SHARED = 0;
        q_nextout_SHARED = 0;
        q_closed_SHARED = 0;
        pthread_mutex_init(&q_mtx, NULL);
        pthread_cond_init(&q_more, NULL);
        pthread_cond_init(&q_less, NULL);
    } else {
        return 0;
    }



    //pthread_attr_init(&pab);
    //pthread_attr_setscope(&pab, PTHREAD_SCOPE_SYSTEM);

    aworkers_SHARED = nworkers_SHARED;

    /*
    for (j = 0; j < nworkers; ++j)
        if (pthread_create(&tid, &pab, worker, NULL) != 0)
        {
            fprintf(stderr, "%s: pthread_create: failed to create worker thread\n",
                    argv[0]);
            exit(1);
        }
        */

    j = 0;
    if (j < nworkers_SHARED) {
        pthread_create(&t1, NULL, worker1, NULL);
    }
    j++;

    if (j < nworkers_SHARED) {
        pthread_create(&t2, NULL, worker2, NULL);
    }
    j++;

#if 0
    if (j < nworkers_SHARED) {
        pthread_create(&t3, NULL, worker3, NULL);
    }
    j++;

    if (j < nworkers_SHARED) {
        pthread_create(&t4, NULL, worker4, NULL);
    }
    j++;
#endif

    /*
    while (i < argc && do_ftw(argv[i++]) == 0)
        ;
    */

    //pqueue_close(&pqb);
    pthread_mutex_lock(&q_mtx);

    q_closed_SHARED = 1;

    //pthread_cond_broadcast(&q_more);
    pthread_cond_signal(&q_more);

    pthread_mutex_unlock(&q_mtx);


    if (debug_SHARED)
        fprintf(stderr, "Waiting for workers to finish...\n");

    // patches
    pthread_mutex_lock(&aworker_lock);
    while (aworkers_SHARED > 0)
        pthread_cond_wait(&aworker_cv, &aworker_lock);
    pthread_mutex_unlock(&aworker_lock);

    // special var to happen later
    int tmp = happen_SHARED;

    if (debug_SHARED)
        fprintf(stderr, "n_files = %d, n_matches = %d, n_workers = %d, n_Mbytes = %d\n",
                n_files_SHARED, n_matches_SHARED, nworkers_SHARED,
                (int) (n_bytes_SHARED / 1000000));

    pthread_exit(0);
    return n_matches_SHARED;
}
