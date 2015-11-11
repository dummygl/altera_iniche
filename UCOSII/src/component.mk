# *******************************************************************************
# *                                                                             *
# * License Agreement                                                           *
# *                                                                             *
# * Copyright (c) 2008 Altera Corporation, San Jose, California, USA.           *
# * All rights reserved.                                                        *
# *                                                                             *
# * Permission is hereby granted, free of charge, to any person obtaining a     *
# * copy of this software and associated documentation files (the "Software"),  *
# * to deal in the Software without restriction, including without limitation   *
# * the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
# * and/or sell copies of the Software, and to permit persons to whom the       *
# * Software is furnished to do so, subject to the following conditions:        *
# *                                                                             *
# * The above copyright notice and this permission notice shall be included in  *
# * all copies or substantial portions of the Software.                         *
# *                                                                             *
# * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
# * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
# * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
# * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
# * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
# * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
# * DEALINGS IN THE SOFTWARE.                                                   *
# *                                                                             *
# * This agreement shall be governed in all respects by the laws of the State   *
# * of California and by the laws of the United States of America.              *
# *                                                                             *
# * Altera does not recommend, suggest or require that this reference design    *
# * file be used in conjunction or combination with any other product.          *
# *******************************************************************************

# Set up the include paths.
INCLUDE_PATH +=                                                                \
    $(filter %/altera_iniche,                                                  \
             $(COMPONENTS))/UCOSII/src/h               \
    $(filter %/altera_iniche,                                                  \
             $(COMPONENTS))/UCOSII/src/nios2

# Copy Interniche Nios II port file to system description folder,
# if it does not already exist, so that it is writeable. The source
# ipport.h file, located in UCOSII/src/h/nios2, will not be
# seen during build since it is not added to the include path above.
INICHE_SRC_DIR = $(SOPC_KIT_NIOS2)/components/altera_iniche/UCOSII/src
$(GTF_GENERATED)/system.h: $(SYSTEM_DIR)/ipport.h

$(SYSTEM_DIR)/ipport.h:
	if [ ! -f "$(GTF_GENERATED)/ipport.h" ]; then \
          cp "$(INICHE_SRC_DIR)/h/nios2/ipport.h" \
             "$(GTF_GENERATED)"; \
        fi

# Add alt sources.
C_LIB_SRCS += alt_iniche_close.c                                               \
              alt_iniche_dev.c                                                 \
              alt_iniche_fcntl.c                                               \
              alt_iniche_read.c                                                \
              alt_iniche_write.c

# Add allports sources.
C_LIB_SRCS += $(addprefix allports/, allports.c        \
                                                             timeouts.c        \
                                                             tk_misc.c)

# Add auto IP sources.
C_LIB_SRCS += $(addprefix autoip4/, autoip.c        \
                                                             upnp.c        \
                                                             upnpmenu.c)

# Add ftp sources.
C_LIB_SRCS += $(addprefix ftp/, ftpclnt.c        \
                                                             ftpcport.c       \
                                                             ftpcprn.c        \
                                                             ftpmenu.c        \
                                                             ftpsport.c       \
                                                             ftpsrv.c         \
                                                             ftpssock.c       \
                                                             ftpsvfs.c)

# Add core IP sources.
C_LIB_SRCS += $(addprefix ip/, ip.c                    \
                                                       et_arp.c                \
                                                       icmp.c                  \
                                                       iface.c                 \
                                                       ip_reasm.c              \
                                                       ipdemux.c               \
                                                       ipmc.c                  \
                                                       ipnet.c                 \
                                                       ipport.c                \
                                                       ipraw.c                 \
                                                       ip_reasm.c              \
                                                       iproute.c               \
                                                       ipstart.c               \
                                                       pmtu.c                  \
                                                       rtbtree.c               \
                                                       udp.c)

# Add multicast sources.
C_LIB_SRCS += $(addprefix ipmc/, igmp2.c        \
                                                             igmp.c        \
                                                             igmp_cmn.c    \
                                                             ipopt.c       \
                                                             u_mctest.c)

# Add misclib sources.
C_LIB_SRCS += $(addprefix misclib/, app_ping.c         \
                                                            bsdsock.c          \
                                                            cksum.c            \
                                                            cu_srv.c           \
                                                            dhcsetup.c         \
                                                            genlist.c          \
                                                            iniche_log.c       \
                                                            iniche_qsort.c     \
                                                            in_utils.c         \
                                                            localtime.c        \
                                                            memdev.c           \
                                                            memio.c            \
                                                            memwrap.c          \
                                                            menulib.c          \
                                                            menus.c            \
                                                            msring.c           \
                                                            netmain.c          \
                                                            nextcarg.c         \
                                                            nrmenus.c          \
                                                            nvfsio.c           \
                                                            nvparms.c          \
                                                            parseip.c          \
                                                            pcycles.c          \
                                                            profiler.c         \
                                                            rawiptst.c         \
                                                            reshost.c          \
                                                            rfsim.c            \
                                                            rttest.c           \
                                                            soperr.c           \
                                                            strilib.c          \
                                                            strlib.c           \
                                                            strtol.c           \
                                                            syslog.c           \
                                                            task.c             \
                                                            tcp_echo.c         \
                                                            tcpcksum.c         \
                                                            testmenu.c         \
                                                            tk_crnos.c         \
                                                            ttyio.c            \
                                                            udp_echo.c         \
                                                            userpass.c)

# Add net sources.
C_LIB_SRCS += $(addprefix net/, dhcpclnt.c             \
                                                        dhcputil.c             \
                                                        dnsclnt.c              \
                                                        ifmap.c                \
                                                        macloop.c              \
                                                        ping.c                 \
                                                        pktalloc.c             \
                                                        q.c                    \
                                                        slip.c                 \
                                                        slipif.c               \
                                                        udp_open.c)

# Add Nios 2 port specific sources.
C_LIB_SRCS += $(addprefix nios2/, brdutils.c           \
                                                          osportco.c           \
                                                          targnios.c)

ASM_LIB_SRCS += $(addprefix nios2/, asm_cksum.S)

# Add TCP sources.
C_LIB_SRCS += $(addprefix tcp/, in_pcb.c               \
                                                        nptcp.c                \
                                                        rawsock.c              \
                                                        sockcall.c             \
                                                        socket.c               \
                                                        socket2.c              \
                                                        soselect.c             \
                                                        tcp_in.c               \
                                                        tcp_menu.c             \
                                                        tcp_out.c              \
                                                        tcpport.c              \
                                                        tcpsack.c              \
                                                        tcp_subr.c             \
                                                        tcp_timr.c             \
                                                        tcp_usr.c              \
                                                        tcp_zio.c              \
                                                        udpsock.c)

# Add telnet sources.
C_LIB_SRCS += $(addprefix telnet/, telerr.c               \
                                                        telmenu.c              \
                                                        telnet.c               \
                                                        telparse.c             \
                                                        telport.c)

# Add tftp sources.
C_LIB_SRCS += $(addprefix tftp/, tftpcli.c               \
                                                        tftpmenu.c             \
                                                        tftpport.c             \
                                                        tftpsrv.c              \
                                                        tftpudp.c              \
                                                        tftputil.c)

# Add vfs sources.
C_LIB_SRCS += $(addprefix vfs/, vfsfiles.c               \
                                                        vfsport.c             \
                                                        vfssync.c             \
                                                        vfsutil.c)

# Configure to build as Altera InterNiche.
CPPFLAGS += -DALT_INICHE

# Optionally suppress licensing warning message
ifeq ($(NICHESTACK_LICENSE), GRANTED)
  CPPFLAGS += -DALT_INICHE_SUPRESS_LICENSE_WARNING
endif
