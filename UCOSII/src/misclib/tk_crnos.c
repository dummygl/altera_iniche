/*
 * FILENAME: tk_crnos.c
 *
 * Copyright  2002 By InterNiche Technologies Inc. All rights reserved
 *
 * Wrapper and utility Functions to map NicheTask "TK_" macros to ChronOS
 *
 * MODULE: MISCLIB
 *
 * PORTABLE: yes (within ChronOS & uCOS systems)
 *
 * These wrapper functions for native ChronOS functions are dependant on the
 * the implemenation of the project/target directory osport.c file.
 *
 * Modified: 10-21-2008 (skh)
 */

#include "ipport.h"

#ifdef CHRONOS

#include "ucos_ii.h"
#include "os_cpu.h"

#include OSPORT_H

extern int num_net_tasks;
extern struct inet_taskinfo nettasks[];

 /* 
  * Q and Mutex used by tcp_sleep/wakeup
  */
extern OS_EVENT *global_wakeup_Mutex;
extern struct TCP_PendPost global_TCPwakeup_set[];
extern int global_TCPwakeup_setIndx;

void     TK_OSTaskResume(u_char * Id);
void     TK_OSTimeDly(void);
u_char   TK_OSTaskQuery(void);



void TK_OSTimeDly(void)
{
   OSTimeDly(2);
}



void TK_OSTaskResume(u_char * Id)
{
INT8U err;

   err = OSTaskResume(*Id);
   
   if ((err != OS_NO_ERR) && (err != OS_TASK_NOT_SUSPENDED))
   {
      dprintf("ChronOS API call failure, to Resume Suspended Task!\n");
      dtrap();
      panic("TK_OSTaskResume");      
   }
   return;
}



#ifndef TCPWAKE_RTOS

/*
 * removeWakeSetEntry(void * event)- remove event from wake set.
 *  or return NULL if not there.
 */
static void *
removeWakeSetEntry(void * event)
{
   int i;
   struct TCP_PendPost *wakeP = &global_TCPwakeup_set[0];
	
   /* search for existing entry */
   for (i = 0; i < global_TCPwakeup_setIndx; i++)
   {
      /* match? */
      if ((wakeP->ctick != 0) && (wakeP->soc_event == event))
      {
      	 /*
      	  * clear entry and return
      	  */
      	 wakeP->ctick = 0;
         return (wakeP->soc_event);				
      }
      wakeP++;
   }

   /* not there */	
   return NULL;	
}



/*
 * insertWakeSetEntry(void * event) - insert event into wake set,
 *  purge old entries.
 */
static void
insertWakeSetEntry(void * event)
{
   int i;
   struct TCP_PendPost *wakeP = &global_TCPwakeup_set[0];

   /* are we there already? */
   for (i = 0; i < global_TCPwakeup_setIndx; i++)
   {
      /* match? */
      if ((wakeP->ctick != 0) && (wakeP->soc_event == event))
      {
         /*
          * yup, return
          */
	 wakeP->ctick = cticks;		/* update cticks */
         return;				
      }
      wakeP++;
   }

   /* yup, use empty slot or purge an old one */
   wakeP = &global_TCPwakeup_set[0];
   for (i = 0; i < global_TCPwakeup_setIndx; i++)
   {
      /* empty or old? */
      if (!wakeP->ctick || 
          ((cticks - wakeP->ctick) > GLOBWAKE_PURGE_DELT))
      {
         /*
          * yup,  add ours
          */
         break;
      }
      wakeP++;
   }						

   if (i < GLOBWAKE_SZ)
   {
#ifdef TK_CRON_DIAGS
         dprintf("+++ insertWakeSetEntry add = %lx\n", event);
#endif	

         wakeP->ctick = cticks;				
         wakeP->soc_event = event;	
         if (i > global_TCPwakeup_setIndx)
            global_TCPwakeup_setIndx = i;
   }
   else
   {
      dprintf("*** insertWakeSetEntry, global_TCPwakeup_set is full - dtrap\n");
      dtrap();
   }
}



/*
 * tcp_sleep(void * event) - sleep on this event, if not
 * already given a wakeup
 */
void
tcp_sleep(void * event)
{
#ifdef NOT_USED
#if OS_CRITICAL_METHOD == 3                      /* Allocate storage for CPU status register           */
   OS_CPU_SR  cpu_sr;
#endif
   int i;
   int QLen;
#endif

   INT8U error;
   struct wake_event *Pext = OSTCBCur->OSTCBExtPtr;   

#ifdef TK_CRON_DIAGS
dprintf("+++ tcp_sleep = %lx\n", event);
#endif
 
   /*
    * gain control of the global wakeup mutex
    */
   OSMutexPend(global_wakeup_Mutex, 0, &error);
   if (error != OS_NO_ERR)
   {
      dprintf("*** tcp_sleep, OSMutexPend = %d\n", error);
      dtrap(); 		
   }   	
   
   /*
    * we are now in mutex
    * -----------------------------------
    */
    
   /*
    * check to see if our cookie is in the global wakeup set
    */
   if (removeWakeSetEntry(event) != NULL)
   {
      /*
       * yes, give up mutex
       */
      error = OSMutexPost(global_wakeup_Mutex);
      if (error != OS_NO_ERR)
      {
         dprintf("*** tcp_sleep, OSMutexPost(2) = %d\n", error);
         dtrap(); 		
      }  
  	
      /*
       * we had a wakeup, return
       */ 	    
      return;   		   		
   }
     		
   /*
    * our cookie is not in the wake set.
    */   		
   		    
   /*
    * put our cookie in the TCB ext.
    */
   Pext->soc_event = event;
   	
   /*
    * give up mutex
    */
   error = OSMutexPost(global_wakeup_Mutex);
   if (error != OS_NO_ERR)
   {
      dprintf("*** tcp_sleep, OSMutexPost(2) = %d\n", error);
      dtrap(); 		
   }      
   	
   /*
    * we are now out of the mutex
    * -----------------------------------
    */   
   	
   UNLOCK_NET_RESOURCE(NET_RESID);  /* Exiting net code (into suspension) */
   
   OSSemPend(Pext->wake_sem, 0, &error);   /* pend for semaphore */
   if (error)
   {
      int errct = 0;

      /* sometimes we get a "timeout" error even though we passed a zero
       * to indicate we'll wait forever. When this happens, try again:
       */
      while(error == 10)
      {
         if(errct++ > 1000)
         {
            dtrap();    /* fatal? */
            return;
         }
         OSSemPend(Pext->wake_sem, 0, &error);
      }
   } 

   LOCK_NET_RESOURCE(NET_RESID);    /* re-entering net code */
}



/*
 * tcp_wakeup(void * event) - wakeup TCB with this event,
 *   else put in wake set.
 */
void
tcp_wakeup(void * event)
{
   int   i;          /* task table index */
   INT8U error;
 
   /*
    * gain control of the global wakeup mutex
    */
   OSMutexPend(global_wakeup_Mutex, 0, &error);
   if (error != OS_NO_ERR)
   {
      dprintf("*** tcp_wakeup, OSMutexPend = %d\n", error);
      dtrap(); 		
   } 

#ifdef TK_CRON_DIAGS
   dprintf("+++ tcp_wakeup = %lx\n", event);
#endif

   /*
    * we are now in mutex
    * -----------------------------------
    */
    
    /* 
     * Loop through task tables, try to find the cookie.
     */
   for (i = 0; i < OS_LOWEST_PRIO; i++)
   {
      struct wake_event *WEP;
      OS_TCB *tcb;

      if ((tcb = (OS_TCB *)OSTCBPrioTbl[i]) == (OS_TCB *)NULL)
         continue;	/* unassigned priority */

      /* use extension */
      WEP =tcb->OSTCBExtPtr;

      if (WEP->soc_event == event)
      {

#ifdef TK_CRON_DIAGS
         dprintf("+++ tcp_wakeup OSSemPost = %lx\n", event);
#endif

      	 /* we found the TCB with our cookie */
         error = OSSemPost(WEP->wake_sem);
         if (error != OS_NO_ERR)
         {
            dprintf("*** tcp_wakeup, OSSemPost = %d, %p\n", error, WEP->wake_sem);
            dtrap(); 		
         }
         /* clear the cookie */     
         WEP->soc_event = NULL;
 
         /*
          * give up mutex
          */
         error = OSMutexPost(global_wakeup_Mutex);
         if (error != OS_NO_ERR)
         {
            dprintf("*** tcp_wakeup, OSMutexPost = %d\n", error);
            dtrap(); 	
         }	
   
  	 return;   /* we woke it up ! */
      }
   }  /* for() */
   
   /* 
    * we didn't find the cookie in the wake set.
    * Q it up.
    */
   insertWakeSetEntry(event);  	

   /*
    * give up mutex
    */
   error = OSMutexPost(global_wakeup_Mutex);
   if (error != OS_NO_ERR)
   {
      dprintf("*** tcp_sleep, OSMutexPost = %d\n", error);
      dtrap(); 		
   }      
   	
   /*
    * we are now out of the mutex
    * -----------------------------------
    */
  
   return;
}
 
#endif   /* TCPWAKE_RTOS */



u_char TK_OSTaskQuery(void)
{
   OS_TCB task_data;
   INT8U err, task_prio;

   err = OSTaskQuery(OS_PRIO_SELF, &task_data);

   if (err == OS_NO_ERR)
   {
      task_prio = task_data.OSTCBPrio;
   }
   else
   {
      dprintf("ChronOS API call failure, unable to identify task!");
      panic("TK_OSTaskQuery");
      return 0;
   }
   
   return task_prio;
}



void
tk_yield(void)
{
   int   lower_ready;    /* index to next lower ready table */
   
   /* To avoid pointless and lengthy delays to the calling task, ONLY
    * do this if there is another task of similar priority ready to run.
    * We check this task's OSRdyTbl[] entry, and the next entry down. In
    * this task's entry we expect to find only our own bit set, the other
    * should have no bits set. If any of these bits are set then we call
    * OSTimeDly() to give them a chance to run.
    */

   lower_ready = OSTCBCur->OSTCBY + 1;

   if((OSRdyTbl[OSTCBCur->OSTCBY] != OSTCBCur->OSTCBBitX) ||
      (OSRdyTbl[lower_ready]))
   {
      /* To ensure cycles to the lower priority tasks we should really
       * delay by two ticks, but that really hurts performance on some
       * long-tick targets. One tick works better overall....
       */
      OSTimeDly(1);
   }
}


extern struct inet_taskinfo * nettask;
extern int num_net_tasks;

static char * app_text = "app";

int
tk_stats(void * pio)
{
   int      i;    /* index into generic nettasks table */
   int      t;    /* index into ChronOS TCB table */
   OS_TCB * tcb;  /* ChronOS Task Control Block */
   OS_STK * sp;   /* scratch stack pointer */
   int      stackuse;
   char *   name;
   

   ns_printf(pio, "ChronOS RTOS stats:\n");

#ifdef NO_INICHE_EXTENSIONS
   ns_printf(pio, "Context switches; Delay:  %lu\n",
      OSCtxSwCtr);
#else
   ns_printf(pio, "Context switches; Delay:  %lu, Interrupt: %lu\n",
      OSCtxSwCtr, OSCtxIntCtr);
#endif

   ns_printf(pio, "       name     prio. state    wakeups stack-size stack-use \n");

   
   for(t = 0; t <= OS_LOWEST_PRIO ; t++)
   {
      /* get pointer to TCB and see if entry is in use and not a mutex */
      tcb = OSTCBPrioTbl[t];
      if ((tcb == NULL) || (tcb == (OS_TCB *)1))
         continue;

      if(t == OS_LOWEST_PRIO)    /* lowest priority is alwasy IDLE task */
         name = "idle";
      else if(t == (OS_LOWEST_PRIO-1))    /* next lowest may be stats task */
         name = "stats";
      else
         name = app_text;           /* default name to application */

      /* See if we can find name for this in our "core task" array. This
       * may overwrite the "stats" task name if there is no stats task
       * and the priority is in use by an applcation.
       */
      for(i = 0; i < num_net_tasks; i++)
      {
         if(nettasks[i].priority == tcb->OSTCBPrio)
         {
            name = nettasks[i].name;
            break;
         }
      }

#ifdef NO_INICHE_EXTENSIONS
      ns_printf(pio, "%15s %2d    0x%04x,    ---   ",
         name, tcb->OSTCBPrio, tcb->OSTCBStat);
#else
      ns_printf(pio, "%15s %2d    0x%04x, %9ld,",
         name, tcb->OSTCBPrio, tcb->OSTCBStat, tcb->wakeups);
#endif

      /* Find lowest non-zero value in stack so we can estimate the
       * unused portion. Subtracting this from size gives us the used
       * portion of the stack.
       */
#if OS_TASK_CREATE_EXT_EN > 0
      if(tcb->OSTCBStkBottom && tcb->OSTCBStkSize)
      {
         sp = tcb->OSTCBStkBottom + 1;
         while(*sp == 0)
            sp++;
         /* This OS traditionally keeps the size in OS_STK (int) units rather
          * than bytes, so convert back to bytes for display.
          */
         stackuse = (tcb->OSTCBStkSize - (sp - tcb->OSTCBStkBottom)) * sizeof(OS_STK);
         ns_printf(pio, "%6d,      %6d\n",
            tcb->OSTCBStkSize * sizeof(OS_STK),  stackuse);
      }
      else
#endif
      {
         ns_printf(pio, "No stack data\n");
      }
   }

   return 0;
}


#endif /* CHRONOS */

