#
# interniche_nichestack_sw.tcl
#
# A description of the Interniche NicheStack TCP/IP stack,
# version 3.13, for use with the Nios II BSP tools
#

# Create a new software package named "altera_iniche"
create_sw_package altera_iniche

# The version of this software
# Note: Version assignment is based on version of Nios II EDS that
#       this was distributed with. The Niche Stack version is v3.1.4
set_sw_property version 9.0

# (Don't) initialize the driver in alt_sys_init()
set_sw_property auto_initialize false

# Location in generated BSP that above sources will be copied into
set_sw_property bsp_subdirectory iniche

#
# Source file listings...
#

# C/C++ source files
add_sw_property c_source UCOSII/src/alt_iniche_close.c
add_sw_property c_source UCOSII/src/alt_iniche_dev.c
add_sw_property c_source UCOSII/src/alt_iniche_fcntl.c
add_sw_property c_source UCOSII/src/alt_iniche_read.c
add_sw_property c_source UCOSII/src/alt_iniche_write.c

add_sw_property c_source UCOSII/src/allports/allports.c
add_sw_property c_source UCOSII/src/allports/timeouts.c
add_sw_property c_source UCOSII/src/allports/tk_misc.c

add_sw_property c_source UCOSII/src/autoip4/autoip.c
add_sw_property c_source UCOSII/src/autoip4/upnp.c
add_sw_property c_source UCOSII/src/autoip4/upnpmenu.c

add_sw_property c_source UCOSII/src/ftp/ftpclnt.c
add_sw_property c_source UCOSII/src/ftp/ftpsrv.c
add_sw_property c_source UCOSII/src/ftp/ftpcport.c
add_sw_property c_source UCOSII/src/ftp/ftpssock.c
add_sw_property c_source UCOSII/src/ftp/ftpcprn.c
add_sw_property c_source UCOSII/src/ftp/ftpsvfs.c
add_sw_property c_source UCOSII/src/ftp/ftpmenu.c
add_sw_property c_source UCOSII/src/ftp/ftpsport.c

add_sw_property c_source UCOSII/src/ip/et_arp.c
add_sw_property c_source UCOSII/src/ip/icmp.c
add_sw_property c_source UCOSII/src/ip/iface.c
add_sw_property c_source UCOSII/src/ip/ip.c
add_sw_property c_source UCOSII/src/ip/ipdemux.c
add_sw_property c_source UCOSII/src/ip/ipmc.c
add_sw_property c_source UCOSII/src/ip/ipnet.c
add_sw_property c_source UCOSII/src/ip/ipport.c
add_sw_property c_source UCOSII/src/ip/ipraw.c
add_sw_property c_source UCOSII/src/ip/ip_reasm.c
add_sw_property c_source UCOSII/src/ip/iproute.c
add_sw_property c_source UCOSII/src/ip/ipstart.c
add_sw_property c_source UCOSII/src/ip/pmtu.c
add_sw_property c_source UCOSII/src/ip/rtbtree.c
add_sw_property c_source UCOSII/src/ip/udp.c

add_sw_property c_source UCOSII/src/ipmc/igmp2.c
add_sw_property c_source UCOSII/src/ipmc/igmp.c
add_sw_property c_source UCOSII/src/ipmc/igmp_cmn.c
add_sw_property c_source UCOSII/src/ipmc/ipopt.c
add_sw_property c_source UCOSII/src/ipmc/u_mctest.c

add_sw_property c_source UCOSII/src/misclib/app_ping.c
add_sw_property c_source UCOSII/src/misclib/bsdsock.c
add_sw_property c_source UCOSII/src/misclib/cksum.c
add_sw_property c_source UCOSII/src/misclib/cu_srv.c
add_sw_property c_source UCOSII/src/misclib/dhcsetup.c
add_sw_property c_source UCOSII/src/misclib/genlist.c
add_sw_property c_source UCOSII/src/misclib/iniche_log.c
add_sw_property c_source UCOSII/src/misclib/iniche_qsort.c
add_sw_property c_source UCOSII/src/misclib/in_utils.c
add_sw_property c_source UCOSII/src/misclib/localtime.c
add_sw_property c_source UCOSII/src/misclib/memdev.c
add_sw_property c_source UCOSII/src/misclib/memio.c
add_sw_property c_source UCOSII/src/misclib/memwrap.c
add_sw_property c_source UCOSII/src/misclib/menulib.c
add_sw_property c_source UCOSII/src/misclib/menus.c
add_sw_property c_source UCOSII/src/misclib/msring.c
add_sw_property c_source UCOSII/src/misclib/netmain.c
add_sw_property c_source UCOSII/src/misclib/nextcarg.c
add_sw_property c_source UCOSII/src/misclib/nrmenus.c
add_sw_property c_source UCOSII/src/misclib/nvfsio.c
add_sw_property c_source UCOSII/src/misclib/nvparms.c
add_sw_property c_source UCOSII/src/misclib/parseip.c
add_sw_property c_source UCOSII/src/misclib/pcycles.c
add_sw_property c_source UCOSII/src/misclib/profiler.c
add_sw_property c_source UCOSII/src/misclib/rawiptst.c
add_sw_property c_source UCOSII/src/misclib/reshost.c
add_sw_property c_source UCOSII/src/misclib/rfsim.c
add_sw_property c_source UCOSII/src/misclib/rttest.c
add_sw_property c_source UCOSII/src/misclib/soperr.c
add_sw_property c_source UCOSII/src/misclib/strilib.c
add_sw_property c_source UCOSII/src/misclib/strlib.c
add_sw_property c_source UCOSII/src/misclib/strtol.c
add_sw_property c_source UCOSII/src/misclib/syslog.c
add_sw_property c_source UCOSII/src/misclib/task.c
add_sw_property c_source UCOSII/src/misclib/tcpcksum.c
add_sw_property c_source UCOSII/src/misclib/tcp_echo.c
add_sw_property c_source UCOSII/src/misclib/testmenu.c
add_sw_property c_source UCOSII/src/misclib/tk_crnos.c
add_sw_property c_source UCOSII/src/misclib/ttyio.c
add_sw_property c_source UCOSII/src/misclib/udp_echo.c
add_sw_property c_source UCOSII/src/misclib/userpass.c

add_sw_property c_source UCOSII/src/net/dhcpclnt.c
add_sw_property c_source UCOSII/src/net/dhcputil.c
add_sw_property c_source UCOSII/src/net/dnsclnt.c
add_sw_property c_source UCOSII/src/net/ifmap.c
add_sw_property c_source UCOSII/src/net/macloop.c
add_sw_property c_source UCOSII/src/net/ping.c
add_sw_property c_source UCOSII/src/net/pktalloc.c
add_sw_property c_source UCOSII/src/net/q.c
add_sw_property c_source UCOSII/src/net/slip.c
add_sw_property c_source UCOSII/src/net/slipif.c
add_sw_property c_source UCOSII/src/net/udp_open.c

add_sw_property c_source UCOSII/src/nios2/brdutils.c
add_sw_property c_source UCOSII/src/nios2/osportco.c
add_sw_property c_source UCOSII/src/nios2/targnios.c

add_sw_property c_source UCOSII/src/tcp/in_pcb.c
add_sw_property c_source UCOSII/src/tcp/nptcp.c
add_sw_property c_source UCOSII/src/tcp/rawsock.c
add_sw_property c_source UCOSII/src/tcp/sockcall.c
add_sw_property c_source UCOSII/src/tcp/socket.c
add_sw_property c_source UCOSII/src/tcp/socket2.c
add_sw_property c_source UCOSII/src/tcp/soselect.c
add_sw_property c_source UCOSII/src/tcp/tcp_in.c
add_sw_property c_source UCOSII/src/tcp/tcp_menu.c
add_sw_property c_source UCOSII/src/tcp/tcp_out.c
add_sw_property c_source UCOSII/src/tcp/tcpport.c
add_sw_property c_source UCOSII/src/tcp/tcpsack.c
add_sw_property c_source UCOSII/src/tcp/tcp_subr.c
add_sw_property c_source UCOSII/src/tcp/tcp_timr.c
add_sw_property c_source UCOSII/src/tcp/tcp_usr.c
add_sw_property c_source UCOSII/src/tcp/tcp_zio.c
add_sw_property c_source UCOSII/src/tcp/udpsock.c

add_sw_property c_source UCOSII/src/telnet/telerr.c
add_sw_property c_source UCOSII/src/telnet/telparse.c
add_sw_property c_source UCOSII/src/telnet/telmenu.c
add_sw_property c_source UCOSII/src/telnet/telport.c
add_sw_property c_source UCOSII/src/telnet/telnet.c

add_sw_property c_source UCOSII/src/tftp/tftpcli.c
add_sw_property c_source UCOSII/src/tftp/tftpsrv.c
add_sw_property c_source UCOSII/src/tftp/tftpmenu.c
add_sw_property c_source UCOSII/src/tftp/tftpudp.c
add_sw_property c_source UCOSII/src/tftp/tftpport.c
add_sw_property c_source UCOSII/src/tftp/tftputil.c

add_sw_property c_source UCOSII/src/vfs/vfsfiles.c
add_sw_property c_source UCOSII/src/vfs/vfsport.c
add_sw_property c_source UCOSII/src/vfs/vfssync.c
add_sw_property c_source UCOSII/src/vfs/vfsutil.c

# Assembly files
add_sw_property asm_source UCOSII/src/nios2/asm_cksum.S

# Include files
add_sw_property include_source UCOSII/inc/alt_iniche_dev.h
add_sw_property include_source UCOSII/inc/os/alt_syscall.h

add_sw_property include_source UCOSII/src/autoip4/autoip.h
add_sw_property include_source UCOSII/src/autoip4/ds_app.h
add_sw_property include_source UCOSII/src/autoip4/upnp.h

add_sw_property include_source UCOSII/src/ftp/ftpclnt.h
add_sw_property include_source UCOSII/src/ftp/ftpport.h
add_sw_property include_source UCOSII/src/ftp/ftpsrv.h

add_sw_property include_source UCOSII/src/h/app_ping.h
add_sw_property include_source UCOSII/src/h/arp.h
add_sw_property include_source UCOSII/src/h/bsdsock.h
add_sw_property include_source UCOSII/src/h/comline.h
add_sw_property include_source UCOSII/src/h/crypt_api.h
add_sw_property include_source UCOSII/src/h/crypt_port.h
add_sw_property include_source UCOSII/src/h/dhcpclnt.h
add_sw_property include_source UCOSII/src/h/dns.h
add_sw_property include_source UCOSII/src/h/dnsport.h
add_sw_property include_source UCOSII/src/h/ether.h
add_sw_property include_source UCOSII/src/h/genlist.h
add_sw_property include_source UCOSII/src/h/htcmptab.h
add_sw_property include_source UCOSII/src/h/icmp.h
add_sw_property include_source UCOSII/src/h/ifmap.h
add_sw_property include_source UCOSII/src/h/iniche_log.h
add_sw_property include_source UCOSII/src/h/iniche_log_port.h
add_sw_property include_source UCOSII/src/h/intimers.h
add_sw_property include_source UCOSII/src/h/in_utils.h
add_sw_property include_source UCOSII/src/h/ip.h
add_sw_property include_source UCOSII/src/h/ip6.h
add_sw_property include_source UCOSII/src/h/libport.h
add_sw_property include_source UCOSII/src/h/mbuf.h
add_sw_property include_source UCOSII/src/h/memwrap.h
add_sw_property include_source UCOSII/src/h/menu.h
add_sw_property include_source UCOSII/src/h/msring.h
add_sw_property include_source UCOSII/src/h/nameser.h
add_sw_property include_source UCOSII/src/h/net.h
add_sw_property include_source UCOSII/src/h/netbuf.h
add_sw_property include_source UCOSII/src/h/nptcp.h
add_sw_property include_source UCOSII/src/h/nptypes.h
add_sw_property include_source UCOSII/src/h/ns.h
add_sw_property include_source UCOSII/src/h/ns_debug.h
add_sw_property include_source UCOSII/src/h/nvfsio.h
add_sw_property include_source UCOSII/src/h/nvparms.h
add_sw_property include_source UCOSII/src/h/pmtu.h
add_sw_property include_source UCOSII/src/h/ppp_port.h
add_sw_property include_source UCOSII/src/h/profiler.h
add_sw_property include_source UCOSII/src/h/q.h
add_sw_property include_source UCOSII/src/h/snmpport.h
add_sw_property include_source UCOSII/src/h/snmp_vie.h
add_sw_property include_source UCOSII/src/h/sockcall.h
add_sw_property include_source UCOSII/src/h/socket.h
add_sw_property include_source UCOSII/src/h/socket6.h
add_sw_property include_source UCOSII/src/h/sockvar.h
add_sw_property include_source UCOSII/src/h/syslog.h
add_sw_property include_source UCOSII/src/h/task.h
add_sw_property include_source UCOSII/src/h/tcp.h
add_sw_property include_source UCOSII/src/h/tcpapp.h
add_sw_property include_source UCOSII/src/h/tcpport.h
add_sw_property include_source UCOSII/src/h/tk_crnos.h
add_sw_property include_source UCOSII/src/h/tk_ntask.h
add_sw_property include_source UCOSII/src/h/udp.h
add_sw_property include_source UCOSII/src/h/userpass.h
add_sw_property include_source UCOSII/src/h/vfsfiles.h
add_sw_property include_source UCOSII/src/h/webport.h

# ipport.h is located under nios2 so that the legacy (IDE) build system
# can copy it into a writeable location; for (new) BSPs, ipport.h will
# be located in a sub-directory. A corresponding include-path is added
# below.
add_sw_property include_source UCOSII/src/h/nios2/ipport.h

add_sw_property include_source UCOSII/src/ip/ip_reasm.h

add_sw_property include_source UCOSII/src/ipmc/igmp.h
add_sw_property include_source UCOSII/src/ipmc/igmp2.h
add_sw_property include_source UCOSII/src/ipmc/igmp_cmn.h

add_sw_property include_source UCOSII/src/net/heapbuf.h
add_sw_property include_source UCOSII/src/net/slip.h
add_sw_property include_source UCOSII/src/net/slipport.h

add_sw_property include_source UCOSII/src/nios2/osport.h
add_sw_property include_source UCOSII/src/nios2/uart.h

add_sw_property include_source UCOSII/src/tcp/in_pcb.h
add_sw_property include_source UCOSII/src/tcp/protosw.h
add_sw_property include_source UCOSII/src/tcp/tcp_fsm.h
add_sw_property include_source UCOSII/src/tcp/tcpip.h
add_sw_property include_source UCOSII/src/tcp/tcp_seq.h
add_sw_property include_source UCOSII/src/tcp/tcp_timr.h
add_sw_property include_source UCOSII/src/tcp/tcp_var.h

add_sw_property include_source UCOSII/src/telnet/telnet.h
add_sw_property include_source UCOSII/src/telnet/telport.h

add_sw_property include_source UCOSII/src/tftp/tftp.h
add_sw_property include_source UCOSII/src/tftp/tftpport.h

add_sw_property include_source UCOSII/src/vfs/vfsport.h

# Include paths
add_sw_property include_directory UCOSII/inc
add_sw_property include_directory UCOSII/src/h
add_sw_property include_directory UCOSII/src/h/nios2
add_sw_property include_directory UCOSII/src/nios2

# This driver supports only UCOSII BSP (OS) type
add_sw_property supported_bsp_type UCOSII

# Add preprocessor definitions to public makefile: ALT_INICHE
add_sw_property alt_cppflags_addition "-DALT_INICHE"

# Add preprocessor flag to supress licensing warning if licensing variable set
set mylist [array names env]
foreach foo $mylist {
  if {$foo == "NICHESTACK_LICENSE"} {
    if {$env($foo) == "GRANTED"} {
      add_sw_property alt_cppflags_addition "-DALT_INICHE_SUPRESS_LICENSE_WARNING"
    }
  }
}

# Interniche stack configuration options
add_sw_setting quoted_string system_h_define iniche_default_if INICHE_DEFAULT_IF NOT_USED "Deprecated setting: Default MAC interface. This setting was formerly used by Altera networking example applications. It need not be assigned a valid value for the use of networking example designs in Nios II 8.0. If you are using this setting in a project, it is recomended that you remove the dependency. This setting may be removed in a future release."

add_sw_setting boolean_define_only system_h_define enable_dhcp_client DHCP_CLIENT true "Use DHCP to automatically assign IP address"

add_sw_setting boolean_define_only system_h_define enable_ip_fragments IP_FRAGMENTS true "Reassemble IP packet fragments"

add_sw_setting boolean_define_only system_h_define enable_include_tcp INCLUDE_TCP true "Enable TCP protocol"

add_sw_setting boolean_define_only system_h_define enable_tcp_zerocopy TCP_ZEROCOPY false "Use TCP zero-copy"

add_sw_setting boolean_define_only system_h_define enable_net_stats NET_STATS false "Enable statistics"

# End of file
