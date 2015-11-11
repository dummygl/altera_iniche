/*
 * FILENAME: dnsport.h
 *
 * Copyright  2000 By InterNiche Technologies Inc. All rights reserved
 *
 *
 * MODULE: DNS
 *
 *
 * PORTABLE: no
 */

/* dnsport.h
 *
 * Per-port DNS definition. Most of these are pretty much the same on all
 * systems, but may require tuning for weird cases 
 */

#ifndef _DNSPORT_H_
#define _DNSPORT_H_     1

#define  UDPPORT_DNS 53 /* UDP port to use */

typedef unsigned long time_t;
typedef short int16_t;
typedef unsigned short u_int16_t;
typedef unsigned long u_int32_t;


/* a unix-y timeval structure */

#ifndef timeval   /* does this work on all compilers? */

/*
 * Altera Niche Stack Nios port modification
 * answer to above... apparently not. Timeval included
 * in our C library sys/time.h
 */
#ifndef ALT_INICHE
struct timeval {
     unsigned long  tv_sec;
     unsigned long  tv_usec;
};
#endif

#endif   /* timeval */

#endif  /* _DNSPORT_H_ */

