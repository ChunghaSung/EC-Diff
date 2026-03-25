
// Author:
/*
 * The patch has been done with conditional signal and conditional wait statements.
 * I kept the semantics of read/write operations in this program.
 * This is not original code since it has been updated for testing purpose.
 * Original code is from inspect paper (http://www.cs.utah.edu/~yuyang/inspect/)
*/


/*
 * Aget, Multithreaded Download Accelerator
 *
 * (c) 2002 Murat Balaban <murat at enderunix dot org>
 * See COPYING for copyright information
 *
 *
 */


/*
 *  aget  usr
 */
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>
#include <fcntl.h>

#include <sys/stat.h>
#include <sys/types.h>
#include <sys/socket.h>

#include <netinet/in.h>

#include <arpa/inet.h>

#include <signal.h>
#include <pthread.h>



/****************************************************************************
 *
 *  Defs.h
 *
 ****************************************************************************/

/*
 * Aget, Multithreaded Download Accelerator
 *
 * (c) 2002 Murat Balaban <murat at enderunix dot org>
 * See COPYING for copyright information
 *
 * $Id: Defs.h,v 1.12 2004/05/31 12:33:11 murat Exp $
 *
 */


#ifndef DEFS_H
#define DEFS_H

#define GETREQSIZ 256
#define GETRECVSIZ 512
#define HEADREQSIZ 512
#define MAXURLSIZ 1024
#define MAXHOSTSIZ 1024
#define MAXIPSIZ 16
#define MAXBUFSIZ 512
#define MAXTHREADS 25
#define HTTPPORT 80
#define UNKNOWNREQ 2
#define FTPREQ 21
#define PROTO_HTTP 0xFF
#define PROTO_FTP 0x00
#define STAT_OK 0xFF		/* Download completed successfully      */
#define STAT_INT 0x0F		/* ^C caught, download interrupted      */
#define STAT_ERR 0x00		/* Download finished with error         */


#define	PROGVERSION  "EnderUNIX Aget v0.4"
#define	HEADREQ  "HEAD %s HTTP/1.1\r\nHost: %s\r\nUser-Agent: %s\r\n\r\n"
#define	GETREQ  "GET %s HTTP/1.1\r\nHost: %s\r\nUser-Agent: %s\r\nRange: bytes=%ld-\r\nConnection: close\r\n\r\n"

#endif


void nop1(){}

pthread_mutex_t patchLock;
pthread_cond_t patchCond;
int patchVar_SHARED;

pthread_mutex_t bwritten_mutex;


// Made structure as globals for accurate testing
// hist_data 
int hist_data_nthreads_SHARED;
int hist_data_bwritten_SHARED;

// request under hist_data
char hist_data_host_SHARED[MAXHOSTSIZ];	/* Remote host  */
char hist_data_url_SHARED[MAXURLSIZ];		/* URL          */
char hist_data_file_SHARED[MAXBUFSIZ];		/* file name    */
char hist_data_lfile_SHARED[MAXBUFSIZ];	/* if local file name is specified      */
char hist_data_ip_SHARED[MAXIPSIZ];		/* Remote IP    */
char hist_data_username_SHARED[MAXBUFSIZ];
char hist_data_password_SHARED[MAXBUFSIZ];
int hist_data_port_SHARED;
int hist_data_clength_SHARED;			/* Content-length       */
unsigned char hist_data_proto_SHARED;		/* Protocol             */

// wthread under hist_data
// assumed there are two
char hist_data_wthread1_getstr_SHARED[GETREQSIZ];
long hist_data_wthread1_soffset_SHARED;  /* Start offset */
long hist_data_wthread1_foffset_SHARED;  /* Finish offset */
long hist_data_wthread1_offset_SHARED;  /* Current offset */
long hist_data_wthread1_clength_SHARED;  /* Content Length */
int hist_data_wthread1_fd_SHARED;
pthread_t hist_data_wthread1_tid;           /* Thread ID */
unsigned char hist_data_wthread1_status_SHARED;    /* thread exit status */

char hist_data_wthread2_getstr_SHARED[GETREQSIZ];
long hist_data_wthread2_soffset_SHARED;  /* Start offset */
long hist_data_wthread2_foffset_SHARED;  /* Finish offset */
long hist_data_wthread2_offset_SHARED;  /* Current offset */
long hist_data_wthread2_clength_SHARED;  /* Content Length */
int hist_data_wthread2_fd_SHARED;
pthread_t hist_data_wthread2_tid;           /* Thread ID */
unsigned char hist_data_wthread2_status_SHARED;    /* thread exit status */


/****************************************************************************
 *
 *  Misc.h
 *
 ****************************************************************************/

/*
 * Aget, Multithreaded Download Accelerator
 *
 * (c) 2002 Murat Balaban <murat at enderunix dot org>
 * See COPYING for copyright information
 *
 * $Id: Misc.h,v 1.8 2003/01/27 07:30:49 murat Exp $
 *
 */


#define	LOGSIZ	1024

int calc_offset (int, int, int);
int numofthreads (int);
//void parse_url (char *, struct request *);
//void usage ();
void revstr (char *);		/* Reverse String                               */
void Log (char *, ...);		/* Log                                          */
void updateProgressBar (float, float);
void handleHttpRetcode (char *);

time_t t_start_SHARED, t_finish_SHARED;


/****************************************************************************
 *
 *  Download.h
 *
 ****************************************************************************/

/*
 * Aget, Multithreaded Download Accelerator
 *
 * (c) 2002 Murat Balaban <murat at enderunix dot org>
 * See COPYING for copyright information
 *
 * $Id: Download.h,v 1.3 2003/01/16 20:15:23 rao Exp $
 *
 */


void *http_get (void *);


/****************************************************************************
 *
 *  Signal.h
 *
 ****************************************************************************/

/*
 * Aget, Multithreaded Download Accelerator
 *
 * (c) 2002 Murat Balaban <murat at enderunix dot org>
 * See COPYING for copyright information
 *
 * $Id: Signal.h,v 1.3 2003/01/26 14:50:15 murat Exp $
 *
 */


sigset_t signal_set;

void *signal_waiter (void *arg);
void sigint_handler (void);
void sigalrm_handler (void);


char *fullurl_SHARED;

// wthread
//struct thread_data *wthread;	/* Worker Threads               */
//char wthread1_getstr_SHARED[GETREQSIZ];
char* wthread1_getstr_SHARED;
long wthread1_soffset_SHARED;			/* Start offset         */
long wthread1_foffset_SHARED;			/* Finish offset        */
long wthread1_offset_SHARED;			/* Current Offset       */
long wthread1_clength_SHARED;			/* Content Length       */
int wthread1_fd_SHARED;
pthread_t wthread1_tid;		/* Thread ID            */
unsigned char wthread1_status_SHARED;		/* thread exit status   */

//char wthread2_getstr_SHARED[GETREQSIZ];
char* wthread2_getstr_SHARED;
long wthread2_soffset_SHARED;			/* Start offset         */
long wthread2_foffset_SHARED;			/* Finish offset        */
long wthread2_offset_SHARED;			/* Current Offset       */
long wthread2_clength_SHARED;			/* Content Length       */
int wthread2_fd_SHARED;
pthread_t wthread2_tid;		/* Thread ID            */
unsigned char wthread2_status_SHARED;		/* thread exit status   */


//char wthread3_getstr_SHARED[GETREQSIZ];
char* wthread3_getstr_SHARED;
long wthread3_soffset_SHARED;			/* Start offset         */
long wthread3_foffset_SHARED;			/* Finish offset        */
long wthread3_offset_SHARED;			/* Current Offset       */
long wthread3_clength_SHARED;			/* Content Length       */
int wthread3_fd_SHARED;
pthread_t wthread3_tid;		/* Thread ID            */
unsigned char wthread3_status_SHARED;		/* thread exit status   */

//char wthread2_getstr_SHARED[GETREQSIZ];
char* wthread4_getstr_SHARED;
long wthread4_soffset_SHARED;			/* Start offset         */
long wthread4_foffset_SHARED;			/* Finish offset        */
long wthread4_offset_SHARED;			/* Current Offset       */
long wthread4_clength_SHARED;			/* Content Length       */
int wthread4_fd_SHARED;
pthread_t wthread4_tid;		/* Thread ID            */
unsigned char wthread4_status_SHARED;		/* thread exit status   */

//extern struct request *req;
char req_host_SHARED[MAXHOSTSIZ];	/* Remote host  */
char req_url_SHARED[MAXURLSIZ];		/* URL          */
char req_file_SHARED[MAXBUFSIZ];		/* file name    */
char req_lfile_SHARED[MAXBUFSIZ];	/* if local file name is specified      */
char req_ip_SHARED[MAXIPSIZ];		/* Remote IP    */
char req_username_SHARED[MAXBUFSIZ];
char req_password_SHARED[MAXBUFSIZ];
int req_port_SHARED;
int req_clength_SHARED;			/* Content-length       */
unsigned char req_proto_SHARED;		/* Protocol             */


int fsuggested_SHARED, nthreads_SHARED;
int bwritten_SHARED;
pthread_t hthread;

int errno_SHARED;

/*
void usage ()
{
  fprintf (stderr, "usage: aget [options] url\n");
  fprintf (stderr, "\toptions:\n");
  fprintf (stderr, "\t\t-p port number\n");
  fprintf (stderr, "\t\t-l local file name\n");
  fprintf (stderr, "\t\t-n suggested number of threads\n");
  fprintf (stderr, "\t\t-f force using suggested number of threads\n");
  fprintf (stderr, "\t\t-h this screen\n");
  fprintf (stderr, "\t\t-v version info\n");
  fprintf (stderr, "\n");
  fprintf (stderr, "http//www.enderunix.org/aget/\n");
}
*/


void *signal_waiter (void *arg)
{
    int signal, i;

    arg = NULL;

    //pthread_sigmask (SIG_UNBLOCK, &signal_set, NULL);
    //while (1)
    //{
        /*
#ifdef SOLARIS
        sigwait (&signal_set);
#else
        sigwait (&signal_set, &signal);
#endif
*/
        switch (signal)
        {
            case SIGINT:
                //sigint_handler ();
                printf ("^C caught, saving download job...\n");

                /*
                for (i = 0; i < nthreads; i++)
                {
                    pthread_cancel (wthread[i].tid);
                    wthread[i].status &= STAT_INT;
                }
                */
                i = 0;
                if (i < nthreads_SHARED) {
                    //pthread_cancel(wthread1_tid);
                    wthread1_status_SHARED &= STAT_INT;
                }
                i++;

                if (i < nthreads_SHARED) {
                    //pthread_cancel(wthread2_tid);
                    wthread2_status_SHARED &= STAT_INT;
                }
                i++;

                if (i < nthreads_SHARED) {
                    //pthread_cancel(wthread2_tid);
                    wthread3_status_SHARED &= STAT_INT;
                }
                i++;

                if (i < nthreads_SHARED) {
                    //pthread_cancel(wthread2_tid);
                    wthread4_status_SHARED &= STAT_INT;
                }
                i++;


                //save_log ();
                char *logfile;
                //struct hist_data h;
                FILE *fp;
                int h_nthreads;
                int h_bwritten;
                /*
                logfile = (char *) malloc (255 *sizeof (char));
                memset(logfile, 0, 255);
                */



                if (strlen (req_lfile_SHARED) == 0)
                    snprintf (logfile, 255, "aget-%s.log", req_file_SHARED);
                else
                    snprintf (logfile, 255, "aget-%s.log", req_lfile_SHARED);

                if ((fp = fopen (logfile, "w")) == NULL)
                {
                    fprintf (stderr, "cannot open log file %s for writing: %s\n", logfile,
                            strerror (errno_SHARED));
                } else {


                    //memcpy (&(h.req), req, sizeof (struct request));
                    //memcpy (&(h.wthread), wthread, sizeof (struct thread_data) * nthreads);

                    h_nthreads = nthreads_SHARED;
                    h_bwritten = bwritten_SHARED;

                    // patch
                    nop1();
                    patchVar_SHARED = 1;
                    nop1();
                    nop1();


                    printf ("--> Logfile is: %s, so far %d bytes have been transferred\n",
                            logfile, h_bwritten);

                    //fwrite (&h, sizeof (struct hist_data), 1, fp);
                    fclose (fp);

                    free (logfile);
                }


                break;
            case SIGALRM:
                //sigalrm_handler ();
                printf ("Signal Alarm came\n");
                //updateProgressBar (bwritten, req->clength);
                float cur = bwritten_SHARED;
                float tot = req_clength_SHARED;
                float rat;
                int ndot;
                static float prev = -1;

                rat = cur / tot;
                ndot = (int) (rat * 100);

                if (!((ndot < prev + 5) && (ndot != 100))) {
                    for (i = 0; i < ndot; i += 2)
                        putchar ('.');
                    for (i = ndot - 1; i < 100; i += 2)
                        putchar (' ');
                    printf ("[%d%% completed]\n", ndot);
                    prev = ndot;

                    alarm (1);
                }

                break;

        }
    //}
        return NULL;
}



void *http_get1 (void *arg)
{
    //struct thread_data *td;
    char* td_getstr;
    long td_soffset;
    long td_foffset;
    long td_offset;
    long td_clength;
    int td_fd;
    unsigned char td_status;

    int sd;
    char *rbuf, *s;
    int dr, dw, i;
    long foffset;
    //pthread_t tid;
    //tid = pthread_self ();

    /* Block out all signals        */
    //pthread_sigmask (SIG_BLOCK, &signal_set, NULL);

    /* Set Cancellation Type to Asynchronous        */
    //pthread_setcanceltype (PTHREAD_CANCEL_ASYNCHRONOUS, NULL);

    //td = (struct thread_data *) arg;
    td_getstr = wthread1_getstr_SHARED;
    td_soffset = wthread1_soffset_SHARED;
    td_offset = wthread1_offset_SHARED;
    td_clength = wthread1_clength_SHARED;
    td_fd = wthread1_fd_SHARED;
    td_status = wthread1_status_SHARED;


    foffset = td_foffset;

    /*
    rbuf = (char *) malloc (GETRECVSIZ * sizeof (char) );
    memset(rbuf, 0, sizeof(char) * GETRECVSIZ);
    */
    rbuf = "test";


    if ((sd = socket (AF_INET, SOCK_STREAM, 0)) == -1)
    {
        printf ("<THREAD #%ld> socket creation failed: %s", wthread1_tid, strerror (errno_SHARED));
        pthread_exit ((void *) 1);
    }

    if ((send (sd, td_getstr, strlen (td_getstr), 0)) == -1)
    {
        printf ("<THREAD #%ld> send failed: %s", wthread1_tid, strerror (errno_SHARED));
        pthread_exit ((void *) 1);
    }

    if ((dr = recv (sd, rbuf, GETRECVSIZ, 0)) == -1)
    {
        printf ("<THREAD #%ld> recv failed: %s", wthread1_tid, strerror (errno_SHARED));
        pthread_exit ((void *) 1);
    }

    //handleHttpRetcode (rbuf);
    if ((strstr (rbuf, "HTTP/1.1 416")) != NULL)
    {
        printf("Server returned HTTP/1.1 416 - Requested Range Not Satisfiable\n");
        exit (1);
    }
    else if ((strstr (rbuf, "HTTP/1.1 403")) != NULL)
    {
        printf("<Server returned HTTP/1.1 403 - Permission Denied\n");
        exit (1);
    }
    else if ((strstr (rbuf, "HTTP/1.1 404")) != NULL)
    {
        printf("<Server returned HTTP/1.1 404 - File Not Found\n");
        exit (1);
    }


    if ((strstr (rbuf, "HTTP/1.1 206")) == NULL)
    {
        printf("Something unhandled happened, shutting down...\n");
        exit (1);
    }

    s = rbuf;
    i = 0;
    while (1)
    {
        if (*s == '\n' && *(s - 1) == '\r' && *(s - 2) == '\n'
                && *(s - 3) == '\r')
        {
            s++;
            i++;
            break;
        }
        s++;
        i++;
    }
    td_offset = td_soffset;

    if ((dr - i) > foffset)
        dw = pwrite (td_fd, s, (foffset - i), td_soffset);
    else
        dw = pwrite (td_fd, s, (dr - i), td_soffset);
    td_offset = td_soffset + dw;

    // patch
    nop1();
    while(!patchVar_SHARED) {
        nop1();
    }
    nop1();


    pthread_mutex_lock (&bwritten_mutex);
    bwritten_SHARED += dw;
    pthread_mutex_unlock (&bwritten_mutex);

    while (td_offset < foffset)
    {
        memset (rbuf, GETRECVSIZ, 0);
        dr = recv (sd, rbuf, GETRECVSIZ, 0);
        if ((td_offset + dr) > foffset)
            dw = pwrite (td_fd, rbuf, foffset - td_offset, td_offset);
        else
            dw = pwrite (td_fd, rbuf, dr, td_offset);
        td_offset += dw;
        pthread_mutex_lock (&bwritten_mutex);
        bwritten_SHARED += dw;
        pthread_mutex_unlock (&bwritten_mutex);
        //updateProgressBar (bwritten_SHARED, td_clength);
        float cur = bwritten_SHARED;
        float tot = td_clength;
        float rat;
        int ndot;
        static float prev = -1;

        rat = cur / tot;
        ndot = (int) (rat * 100);

        if (!((ndot < prev + 5) && (ndot != 100))) {
            for (i = 0; i < ndot; i += 2)
                putchar ('.');
            for (i = ndot - 1; i < 100; i += 2)
                putchar (' ');
            printf ("[%d%% completed]\n", ndot);
            prev = ndot;
        }

    }

    if (td_offset == td_foffset)
        td_status = STAT_OK;	/* Tell thet download is OK.    */

    close (sd);

    /*        printf("<THREAD #%ld> Part %d completed, leaving thread...\n", tid, td->tind);*/
    return NULL;
}


void *http_get2 (void *arg)
{
    //struct thread_data *td;
    char* td_getstr;
    long td_soffset;
    long td_foffset;
    long td_offset;
    long td_clength;
    int td_fd;
    unsigned char td_status;

    int sd;
    char *rbuf, *s;
    int dr, dw, i;
    long foffset;
    pthread_t tid;
    //tid = pthread_self ();

    /* Block out all signals        */
    //pthread_sigmask (SIG_BLOCK, &signal_set, NULL);

    /* Set Cancellation Type to Asynchronous        */
    //pthread_setcanceltype (PTHREAD_CANCEL_ASYNCHRONOUS, NULL);

    //td = (struct thread_data *) arg;
    td_getstr = wthread2_getstr_SHARED;
    td_soffset = wthread2_soffset_SHARED;
    td_offset = wthread2_offset_SHARED;
    td_clength = wthread2_clength_SHARED;
    td_fd = wthread2_fd_SHARED;
    td_status = wthread2_status_SHARED;


    foffset = td_foffset;

    /*
    rbuf = (char *) malloc (GETRECVSIZ * sizeof (char) );
    memset(rbuf, 0, sizeof(char) * GETRECVSIZ);
    */
    rbuf = "test";


    if ((sd = socket (AF_INET, SOCK_STREAM, 0)) == -1)
    {
        printf ("<THREAD #%ld> socket creation failed: %s", wthread2_tid, strerror (errno_SHARED));
        pthread_exit ((void *) 1);
    }

    if ((send (sd, td_getstr, strlen (td_getstr), 0)) == -1)
    {
        printf ("<THREAD #%ld> send failed: %s", wthread2_tid, strerror (errno_SHARED));
        pthread_exit ((void *) 1);
    }

    if ((dr = recv (sd, rbuf, GETRECVSIZ, 0)) == -1)
    {
        printf ("<THREAD #%ld> recv failed: %s", wthread2_tid, strerror (errno_SHARED));
        pthread_exit ((void *) 1);
    }

    //handleHttpRetcode (rbuf);
    if ((strstr (rbuf, "HTTP/1.1 416")) != NULL)
    {
        printf("Server returned HTTP/1.1 416 - Requested Range Not Satisfiable\n");
        exit (1);
    }
    else if ((strstr (rbuf, "HTTP/1.1 403")) != NULL)
    {
        printf("<Server returned HTTP/1.1 403 - Permission Denied\n");
        exit (1);
    }
    else if ((strstr (rbuf, "HTTP/1.1 404")) != NULL)
    {
        printf("<Server returned HTTP/1.1 404 - File Not Found\n");
        exit (1);
    }


    if ((strstr (rbuf, "HTTP/1.1 206")) == NULL)
    {
        printf("Something unhandled happened, shutting down...\n");
        exit (1);
    }

    s = rbuf;
    i = 0;
    while (1)
    {
        if (*s == '\n' && *(s - 1) == '\r' && *(s - 2) == '\n'
                && *(s - 3) == '\r')
        {
            s++;
            i++;
            break;
        }
        s++;
        i++;
    }
    td_offset = td_soffset;

    if ((dr - i) > foffset)
        dw = pwrite (td_fd, s, (foffset - i), td_soffset);
    else
        dw = pwrite (td_fd, s, (dr - i), td_soffset);
    td_offset = td_soffset + dw;

    // patch
    nop1();
    while(!patchVar_SHARED) {
        nop1();
    }
    nop1();


    pthread_mutex_lock (&bwritten_mutex);
    bwritten_SHARED += dw;
    pthread_mutex_unlock (&bwritten_mutex);

    while (td_offset < foffset)
    {
        memset (rbuf, GETRECVSIZ, 0);
        dr = recv (sd, rbuf, GETRECVSIZ, 0);
        if ((td_offset + dr) > foffset)
            dw = pwrite (td_fd, rbuf, foffset - td_offset, td_offset);
        else
            dw = pwrite (td_fd, rbuf, dr, td_offset);
        td_offset += dw;
        pthread_mutex_lock (&bwritten_mutex);
        bwritten_SHARED += dw;
        pthread_mutex_unlock (&bwritten_mutex);
        //updateProgressBar (bwritten_SHARED, td_clength);
        float cur = bwritten_SHARED;
        float tot = td_clength;
        float rat;
        int ndot;
        static float prev = -1;

        rat = cur / tot;
        ndot = (int) (rat * 100);

        if (!((ndot < prev + 5) && (ndot != 100))) {
            for (i = 0; i < ndot; i += 2)
                putchar ('.');
            for (i = ndot - 1; i < 100; i += 2)
                putchar (' ');
            printf ("[%d%% completed]\n", ndot);
            prev = ndot;
        }

    }

    if (td_offset == td_foffset)
        td_status = STAT_OK;	/* Tell thet download is OK.    */

    close (sd);

    /*        printf("<THREAD #%ld> Part %d completed, leaving thread...\n", tid, td->tind);*/
    pthread_exit (NULL);
    return NULL;
}



void *http_get3 (void *arg)
{
    //struct thread_data *td;
    char* td_getstr;
    long td_soffset;
    long td_foffset;
    long td_offset;
    long td_clength;
    int td_fd;
    unsigned char td_status;

    int sd;
    char *rbuf, *s;
    int dr, dw, i;
    long foffset;
    pthread_t tid;
    //tid = pthread_self ();

    /* Block out all signals        */
    //pthread_sigmask (SIG_BLOCK, &signal_set, NULL);

    /* Set Cancellation Type to Asynchronous        */
    //pthread_setcanceltype (PTHREAD_CANCEL_ASYNCHRONOUS, NULL);

    //td = (struct thread_data *) arg;
    td_getstr = wthread3_getstr_SHARED;
    td_soffset = wthread3_soffset_SHARED;
    td_offset = wthread3_offset_SHARED;
    td_clength = wthread3_clength_SHARED;
    td_fd = wthread3_fd_SHARED;
    td_status = wthread3_status_SHARED;


    foffset = td_foffset;

    /*
    rbuf = (char *) malloc (GETRECVSIZ * sizeof (char) );
    memset(rbuf, 0, sizeof(char) * GETRECVSIZ);
    */
    rbuf = "test";


    if ((sd = socket (AF_INET, SOCK_STREAM, 0)) == -1)
    {
        printf ("<THREAD #%ld> socket creation failed: %s", wthread3_tid, strerror (errno_SHARED));
        pthread_exit ((void *) 1);
    }

    if ((send (sd, td_getstr, strlen (td_getstr), 0)) == -1)
    {
        printf ("<THREAD #%ld> send failed: %s", wthread3_tid, strerror (errno_SHARED));
        pthread_exit ((void *) 1);
    }

    if ((dr = recv (sd, rbuf, GETRECVSIZ, 0)) == -1)
    {
        printf ("<THREAD #%ld> recv failed: %s", wthread3_tid, strerror (errno_SHARED));
        pthread_exit ((void *) 1);
    }

    //handleHttpRetcode (rbuf);
    if ((strstr (rbuf, "HTTP/1.1 416")) != NULL)
    {
        printf("Server returned HTTP/1.1 416 - Requested Range Not Satisfiable\n");
        exit (1);
    }
    else if ((strstr (rbuf, "HTTP/1.1 403")) != NULL)
    {
        printf("<Server returned HTTP/1.1 403 - Permission Denied\n");
        exit (1);
    }
    else if ((strstr (rbuf, "HTTP/1.1 404")) != NULL)
    {
        printf("<Server returned HTTP/1.1 404 - File Not Found\n");
        exit (1);
    }


    if ((strstr (rbuf, "HTTP/1.1 206")) == NULL)
    {
        printf("Something unhandled happened, shutting down...\n");
        exit (1);
    }

    s = rbuf;
    i = 0;
    while (1)
    {
        if (*s == '\n' && *(s - 1) == '\r' && *(s - 2) == '\n'
                && *(s - 3) == '\r')
        {
            s++;
            i++;
            break;
        }
        s++;
        i++;
    }
    td_offset = td_soffset;

    if ((dr - i) > foffset)
        dw = pwrite (td_fd, s, (foffset - i), td_soffset);
    else
        dw = pwrite (td_fd, s, (dr - i), td_soffset);
    td_offset = td_soffset + dw;


    // patch
    nop1();
    while(!patchVar_SHARED) {
        nop1();
    }
    nop1();


    pthread_mutex_lock (&bwritten_mutex);
    bwritten_SHARED += dw;
    pthread_mutex_unlock (&bwritten_mutex);

    while (td_offset < foffset)
    {
        memset (rbuf, GETRECVSIZ, 0);
        dr = recv (sd, rbuf, GETRECVSIZ, 0);
        if ((td_offset + dr) > foffset)
            dw = pwrite (td_fd, rbuf, foffset - td_offset, td_offset);
        else
            dw = pwrite (td_fd, rbuf, dr, td_offset);
        td_offset += dw;
        pthread_mutex_lock (&bwritten_mutex);
        bwritten_SHARED += dw;
        pthread_mutex_unlock (&bwritten_mutex);
        //updateProgressBar (bwritten_SHARED, td_clength);
        float cur = bwritten_SHARED;
        float tot = td_clength;
        float rat;
        int ndot;
        static float prev = -1;

        rat = cur / tot;
        ndot = (int) (rat * 100);

        if (!((ndot < prev + 5) && (ndot != 100))) {
            for (i = 0; i < ndot; i += 2)
                putchar ('.');
            for (i = ndot - 1; i < 100; i += 2)
                putchar (' ');
            printf ("[%d%% completed]\n", ndot);
            prev = ndot;
        }

    }

    if (td_offset == td_foffset)
        td_status = STAT_OK;	/* Tell thet download is OK.    */

    close (sd);

    /*        printf("<THREAD #%ld> Part %d completed, leaving thread...\n", tid, td->tind);*/
    pthread_exit (NULL);
    return NULL;
}


void *http_get4 (void *arg)
{
    //struct thread_data *td;
    char* td_getstr;
    long td_soffset;
    long td_foffset;
    long td_offset;
    long td_clength;
    int td_fd;
    unsigned char td_status;

    int sd;
    char *rbuf, *s;
    int dr, dw, i;
    long foffset;
    pthread_t tid;
    //tid = pthread_self ();

    /* Block out all signals        */
    //pthread_sigmask (SIG_BLOCK, &signal_set, NULL);

    /* Set Cancellation Type to Asynchronous        */
    //pthread_setcanceltype (PTHREAD_CANCEL_ASYNCHRONOUS, NULL);

    //td = (struct thread_data *) arg;
    td_getstr = wthread4_getstr_SHARED;
    td_soffset = wthread4_soffset_SHARED;
    td_offset = wthread4_offset_SHARED;
    td_clength = wthread4_clength_SHARED;
    td_fd = wthread4_fd_SHARED;
    td_status = wthread4_status_SHARED;


    foffset = td_foffset;

    /*
    rbuf = (char *) malloc (GETRECVSIZ * sizeof (char) );
    memset(rbuf, 0, sizeof(char) * GETRECVSIZ);
    */
    rbuf = "test";


    if ((sd = socket (AF_INET, SOCK_STREAM, 0)) == -1)
    {
        printf ("<THREAD #%ld> socket creation failed: %s", wthread4_tid, strerror (errno_SHARED));
        pthread_exit ((void *) 1);
    }

    if ((send (sd, td_getstr, strlen (td_getstr), 0)) == -1)
    {
        printf ("<THREAD #%ld> send failed: %s", wthread4_tid, strerror (errno_SHARED));
        pthread_exit ((void *) 1);
    }

    if ((dr = recv (sd, rbuf, GETRECVSIZ, 0)) == -1)
    {
        printf ("<THREAD #%ld> recv failed: %s", wthread4_tid, strerror (errno_SHARED));
        pthread_exit ((void *) 1);
    }

    //handleHttpRetcode (rbuf);
    if ((strstr (rbuf, "HTTP/1.1 416")) != NULL)
    {
        printf("Server returned HTTP/1.1 416 - Requested Range Not Satisfiable\n");
        exit (1);
    }
    else if ((strstr (rbuf, "HTTP/1.1 403")) != NULL)
    {
        printf("<Server returned HTTP/1.1 403 - Permission Denied\n");
        exit (1);
    }
    else if ((strstr (rbuf, "HTTP/1.1 404")) != NULL)
    {
        printf("<Server returned HTTP/1.1 404 - File Not Found\n");
        exit (1);
    }


    if ((strstr (rbuf, "HTTP/1.1 206")) == NULL)
    {
        printf("Something unhandled happened, shutting down...\n");
        exit (1);
    }

    s = rbuf;
    i = 0;
    while (1)
    {
        if (*s == '\n' && *(s - 1) == '\r' && *(s - 2) == '\n'
                && *(s - 3) == '\r')
        {
            s++;
            i++;
            break;
        }
        s++;
        i++;
    }
    td_offset = td_soffset;

    if ((dr - i) > foffset)
        dw = pwrite (td_fd, s, (foffset - i), td_soffset);
    else
        dw = pwrite (td_fd, s, (dr - i), td_soffset);
    td_offset = td_soffset + dw;


    // patch
    nop1();
    while(!patchVar_SHARED) {
        nop1();
    }
    nop1();


    pthread_mutex_lock (&bwritten_mutex);
    bwritten_SHARED += dw;
    pthread_mutex_unlock (&bwritten_mutex);

    while (td_offset < foffset)
    {
        memset (rbuf, GETRECVSIZ, 0);
        dr = recv (sd, rbuf, GETRECVSIZ, 0);
        if ((td_offset + dr) > foffset)
            dw = pwrite (td_fd, rbuf, foffset - td_offset, td_offset);
        else
            dw = pwrite (td_fd, rbuf, dr, td_offset);
        td_offset += dw;
        pthread_mutex_lock (&bwritten_mutex);
        bwritten_SHARED += dw;
        pthread_mutex_unlock (&bwritten_mutex);
        //updateProgressBar (bwritten_SHARED, td_clength);
        float cur = bwritten_SHARED;
        float tot = td_clength;
        float rat;
        int ndot;
        static float prev = -1;

        rat = cur / tot;
        ndot = (int) (rat * 100);

        if (!((ndot < prev + 5) && (ndot != 100))) {
            for (i = 0; i < ndot; i += 2)
                putchar ('.');
            for (i = ndot - 1; i < 100; i += 2)
                putchar (' ');
            printf ("[%d%% completed]\n", ndot);
            prev = ndot;
        }

    }

    if (td_offset == td_foffset)
        td_status = STAT_OK;	/* Tell thet download is OK.    */

    close (sd);

    /*        printf("<THREAD #%ld> Part %d completed, leaving thread...\n", tid, td->tind);*/
    pthread_exit (NULL);
    return NULL;
}


int  main (int argc, char **argv)
{
    extern char *optarg;
    extern int optind;
    int c, error = 0, ret;
    //struct hist_data h;
    int retlog;

    pthread_mutex_init(&bwritten_mutex, 0);

    /* Allocate heap for download request   
     * struct request stores all the information that might be
     * of interest
     */
    //req = (struct request *) malloc (1 * sizeof (struct request));
    //memset(req, 0, sizeof(struct request));


    /* Only some signals will be emitted    */
    /*   sigemptyset (&signal_set); */
    /*   sigaddset (&signal_set, SIGINT); */
    /*   sigaddset (&signal_set, SIGALRM); */

    /* Block out all signals        */
    /*   pthread_sigmask (SIG_BLOCK, &signal_set, NULL); */

    /* Create a thread for hadling signals  */
    /*
       if ((ret = pthread_create (&hthread, NULL, signal_waiter, NULL)) != 0){ 
       fprintf (stderr, "main: cannot create signal_waiter thread: %s, exiting...\n", 
       strerror (errno));
       exit (-1); 
       } 
     */

    pthread_create(&hthread, NULL, signal_waiter, NULL);

    while (!error && (c = getopt (argc, argv, "p:l:n:hfv")) != -1){
        switch (c){
            case 'p':   req_port_SHARED = atoi(optarg);  break;
            case 'f':   fsuggested_SHARED = 1;  break;
            case 'l':   strncpy (req_lfile_SHARED, optarg, MAXBUFSIZ);  break;
            case 'n':
                        if ((nthreads_SHARED = atoi (optarg)) > MAXTHREADS) {
                            printf ("Error: Maximum # of threads allowed is %d\n", MAXTHREADS);
                            nthreads_SHARED = 0;
                        }
                        break;

            case 'h':
                        printf ("%s\n", PROGVERSION);
                        //usage ();
                        exit (0);
                        break;
            case 'v':
                        printf ("%s\nby Murat BALABAN <murat@enderunix.org>\n",
                                PROGVERSION);
                        exit (0);
                        break;
            default:
                        error = 1;
                        //usage ();
                        exit (1);
                        break;
        }
    }

    if (error){
        //usage ();
        exit (1);
    }

    if (fsuggested_SHARED == 1 && nthreads_SHARED == 0) {
        fprintf (stderr,
                "\nERROR: -f and -n should be used together!, exiting...\n\n");
        //usage ();
        exit (1);
    }

    if (argc == 2)		/* If only url is supplied...   */
        fullurl_SHARED = strdup (argv[1]);
    else if (optind < argc)
        if (argc > 2)
            fullurl_SHARED = strdup (argv[optind]);
        else
        {
            //usage ();
            exit (1);
        }
    else if (optind == argc)
    {
        //usage ();
        exit (1);
    }

    //parse_url (fullurl, req);

    /* If a log file for a previous try has been found, read it and
     * resume the download job (resume_get), otherwise, start with
     * a clean job (get) 
     *
     * Logfile is of the pattern: aget-$file_name.log
     */
    //if ((retlog = read_log (&h)) != -1) 
    if (retlog != -1) 
    {
        //resume_get (&h);
        int i, fd, diff_sec, nok = 0;
        char *fmt;

        nthreads_SHARED = hist_data_nthreads_SHARED;

        /*
           fmt = (char *) malloc ((GETREQSIZ - 2) * sizeof (char));
           memset(fmt, 0, GETREQSIZ - 2);
         */
        fmt = "000";


        /*
           wthread =
           (struct thread_data *) malloc (nthreads * sizeof (struct thread_data));
           memcpy (req, &h->req, sizeof (struct request));
           memcpy (wthread, h->wthread, sizeof (struct thread_data) * nthreads);
         */
        /*
        wthread1_getstr_SHARED = hist_data_wthread1_getstr_SHARED;
        wthread1_soffset_SHARED = hist_data_wthread1_soffset_SHARED;
        wthread1_foffset_SHARED = hist_data_wthread1_foffset_SHARED;
        wthread1_offset_SHARED = hist_data_wthread1_offset_SHARED;
        wthread1_clength_SHARED = hist_data_wthread1_clength_SHARED;
        wthread1_fd_SHARED = hist_data_wthread1_fd_SHARED;
        //wthread1_tid_SHARED;
        wthread1_status_SHARED = hist_data_wthread1_status_SHARED;

        wthread2_getstr_SHARED = hist_data_wthread2_getstr_SHARED;
        wthread2_soffset_SHARED = hist_data_wthread2_soffset_SHARED;
        wthread2_foffset_SHARED = hist_data_wthread2_foffset_SHARED;
        wthread2_offset_SHARED = hist_data_wthread2_offset_SHARED;
        wthread2_clength_SHARED = hist_data_wthread2_clength_SHARED;
        wthread2_fd_SHARED = hist_data_wthread2_fd_SHARED;
        //wthread2_tid_SHARED;
        wthread2_status_SHARED = hist_data_wthread2_status_SHARED;
        */

        /*
           Log
           ("Resuming download %s (%d bytes) from site %s(%s:%d). Number of Threads: %d",
           req->url, req->clength, req->host, req->ip, req->port, nthreads);
         */

        char* tmp1 = req_url_SHARED;
        int tmp2 = req_clength_SHARED;
        tmp1 = req_host_SHARED;
        tmp1 = req_ip_SHARED;
        tmp2 = req_port_SHARED;
        tmp2 = nthreads_SHARED;


        if (strlen (req_lfile_SHARED) != 0)
        {
            if ((fd = open (req_lfile_SHARED, O_RDWR, S_IRWXU)) == -1)
            {
                fprintf (stderr, "get: cannot open file %s for writing: %s\n",
                        req_lfile_SHARED, strerror (errno_SHARED));
                exit (1);
            }

        }
        else
        {
            if ((fd = open (req_file_SHARED, O_RDWR, S_IRWXU)) == -1)
            {
                fprintf (stderr, "get: cannot open file %s for writing: %s\n",
                        req_lfile_SHARED, strerror (errno_SHARED));
                exit (1);
            }
        }

        time (&t_start_SHARED);


#ifdef DEBUG
        /*
           for (i = 0; i < nthreads; i++)
           printf ("Start: %ld, Finish: %ld, Offset: %ld, Diff: %ld\n",
           wthread[i].soffset,
           wthread[i].foffset,
           wthread[i].offset, wthread[i].offset - wthread[i].soffset);
         */
        i = 0; 
        if (i < nthreads_SHARED) {
            printf ("Start: %ld, Finish: %ld, Offset: %ld, Diff: %ld\n",
                    wthread1_soffset_SHARED,
                    wthread1_foffset_SHARED,
                    wthread1_offset_SHARED, wthread1_offset_SHARED - wthread1_soffset_SHARED);
        }
        i++;

        if (i < nthreads_SHARED) {
            printf ("Start: %ld, Finish: %ld, Offset: %ld, Diff: %ld\n",
                    wthread2_soffset_SHARED,
                    wthread2_foffset_SHARED,
                    wthread2_offset_SHARED, wthread2_offset_SHARED - wthread2_soffset_SHARED);
        }
        i++;

#endif

        i = 0;
        if (i < nthreads_SHARED) {

            wthread1_soffset_SHARED = wthread1_offset_SHARED;
            wthread1_fd_SHARED = fd;
            snprintf (fmt, GETREQSIZ, GETREQ, req_url_SHARED, req_host_SHARED, PROGVERSION,
                    wthread1_offset_SHARED);
            strncpy (wthread1_getstr_SHARED, fmt, GETREQSIZ);
            pthread_create (&wthread1_tid, NULL, http_get1, NULL);
        }
        i++;

        if (i < nthreads_SHARED) {

            wthread2_soffset_SHARED = wthread2_offset_SHARED;
            wthread2_fd_SHARED = fd;
            snprintf (fmt, GETREQSIZ, GETREQ, req_url_SHARED, req_host_SHARED, PROGVERSION,
                    wthread2_offset_SHARED);
            strncpy (wthread2_getstr_SHARED, fmt, GETREQSIZ);
            pthread_create (&wthread2_tid, NULL, http_get2, NULL);
        }
        i++;


        i = 0;
        if (i < nthreads_SHARED)
            pthread_join(wthread1_tid, NULL);
        i++;

        if (i < nthreads_SHARED)
            pthread_join(wthread2_tid, NULL);
        i++;


        i = 0;
        if (i < nthreads_SHARED) {
            pthread_join(wthread1_tid, NULL);
            if (wthread1_status_SHARED == STAT_OK) 
                nok++;
        }
        i++;

        if (i < nthreads_SHARED) {
            pthread_join(wthread2_tid, NULL);
            if (wthread2_status_SHARED == STAT_OK) 
                nok++;
        }



        if (nok == nthreads_SHARED)
            pthread_cancel (hthread);
        else
            pthread_join (hthread, NULL);



        time (&t_finish_SHARED);
        if ((diff_sec = t_finish_SHARED - t_start_SHARED) == 0)
            diff_sec = 1;		/* Avoid division by zero       */

        printf ("Download completed, job completed in %d seconds. (%d Kb/sec)",
                diff_sec, ((req_clength_SHARED - hist_data_bwritten_SHARED) / diff_sec) / 1024);
        printf ("Shutting down...");
        close (fd);
    }
    else 
    {
        //get (req);
        int i, ret, fd, diff_sec, nok = 0;
        long soffset, foffset;
        char *fmt;

        /*
        if (req_proto_SHARED == PROTO_HTTP)
            http_head_req (req);
        */

        /* According to the content-length, get the
         * suggested number of threads to open.
         * if the user insists on his value, let it be that way,
         * use the user's value.
         */
        //ret = numofthreads (req_clength_SHARED);

        if (fsuggested_SHARED == 0)
        {
            if (ret == 0)
                nthreads_SHARED = 1;
            else
                nthreads_SHARED = ret;
        }

        //wthread = (struct thread_data *) malloc (nthreads * sizeof (struct thread_data));

        printf ("Downloading %s (%d bytes) from site %s(%s:%d). Number of Threads: %d",
                req_url_SHARED, req_clength_SHARED, req_host_SHARED, req_ip_SHARED, req_port_SHARED, nthreads_SHARED);

        if (strlen (req_lfile_SHARED) != 0)
        {
            if ((fd = open (req_lfile_SHARED, O_CREAT | O_RDWR, S_IRWXU)) == -1)
            {
                fprintf (stderr, "get: cannot open file %s for writing: %s\n",
                        req_lfile_SHARED, strerror (errno_SHARED));
                exit (1);
            }

        }
        else
        {
            if ((fd = open (req_file_SHARED, O_CREAT | O_RDWR, S_IRWXU)) == -1)
            {
                fprintf (stderr, "get: cannot open file %s for writing: %s\n",
                        req_lfile_SHARED, strerror (errno_SHARED));
                exit (1);
            }
        }

        if ((lseek (fd, req_clength_SHARED - 1, SEEK_SET)) == -1)
        {
            fprintf (stderr, "get: couldn't lseek:  %s\n", strerror (errno_SHARED));
            exit (1);
        }

        if ((write (fd, "0", 1)) == -1)
        {
            fprintf (stderr, "get: couldn't allocate space for download file: %s\n",
                    strerror (errno_SHARED));
            exit (1);
        }

        /* Get the starting time, prepare GET format string, and start the threads */
        //fmt = (char *) malloc ((GETREQSIZ - 2) * sizeof (char));
        //memset(fmt, 0, ((GETREQSIZ - 2) * sizeof (char)));
        fmt = "test";

        time (&t_start_SHARED);
        i = 0;
        if (i < nthreads_SHARED) {
            int total = req_clength_SHARED;
            int part = i;
            int nthreads = nthreads_SHARED;
            soffset = (part * (total / nthreads));
            total = req_clength_SHARED;
            part = i;
            nthreads = nthreads_SHARED;
            foffset = (part * (total / nthreads));
            wthread3_soffset_SHARED = soffset;
            wthread3_foffset_SHARED = (i == nthreads_SHARED - 1 ? req_clength_SHARED : foffset);
            wthread3_fd_SHARED = dup (fd);
            wthread3_clength_SHARED = req_clength_SHARED;
            snprintf (fmt, GETREQSIZ, GETREQ, req_url_SHARED, req_host_SHARED, PROGVERSION,
                    soffset);
            strncpy (wthread3_getstr_SHARED, fmt, GETREQSIZ);
            pthread_create (&wthread3_tid, NULL, http_get3, NULL);
        }
        i++;

        if (i < nthreads_SHARED) {
            int total = req_clength_SHARED;
            int part = i;
            int nthreads = nthreads_SHARED;
            soffset = (part * (total / nthreads));
            total = req_clength_SHARED;
            part = i;
            nthreads = nthreads_SHARED;
            foffset = (part * (total / nthreads));
            wthread4_soffset_SHARED = soffset;
            wthread4_foffset_SHARED = (i == nthreads_SHARED - 1 ? req_clength_SHARED : foffset);
            wthread4_fd_SHARED = dup (fd);
            wthread4_clength_SHARED = req_clength_SHARED;
            snprintf (fmt, GETREQSIZ, GETREQ, req_url_SHARED, req_host_SHARED, PROGVERSION,
                    soffset);
            strncpy (wthread4_getstr_SHARED, fmt, GETREQSIZ);
            pthread_create (&wthread4_tid, NULL, http_get4, NULL);
        }
        i++;


        
        free (fmt);


        /* Wait for all of the threads to finish... 
         * 
         * TODO: If a thread fails, restart that!
         */
        /*
        for (i = 0; i < nthreads; i++)
        {
            pthread_join (wthread[i].tid, NULL);
            if (wthread[i].status == STAT_OK)
                nok++;
        }
        */
        i = 0;
        if (i < nthreads_SHARED) {
            pthread_join (wthread3_tid, NULL);
            if (wthread3_status_SHARED == STAT_OK)
                nok++;
        }
        i++;

        if (i < nthreads_SHARED) {
            pthread_join (wthread4_tid, NULL);
            if (wthread4_status_SHARED == STAT_OK)
                nok++;
        }
        i++;


        /*   if (nok == nthreads) */
        /*     pthread_cancel (hthread); */
        /*   else */
        /*     pthread_join (hthread, NULL); */

        /* Get the finish time, derive some stats       */
        time (&t_finish_SHARED);
        if ((diff_sec = t_finish_SHARED - t_start_SHARED) == 0)
            diff_sec = 1;		/* Avoid division by zero       */

        printf ("Download completed, job completed in %d seconds. (%d Kb/sec)",
                diff_sec, (req_clength_SHARED / diff_sec) / 1024);
        printf ("Shutting down...");
        close (fd);
    }

    return 0;
}
