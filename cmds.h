#ifndef CMDS_H
#define CMDS_H

#define MAX_RECORD    300
#define MAX_DATA      255
#define MAX_CMDLINE   1024
#define MAX_ARGS      1024
#define MAX_ERRMSG    128

// Commands
#define CMD_START  1
#define CMD_RECORD 2
#define CMD_DONE   3
#define CMD_ERROR  4

// Record types
#define REC_DATA    0x00
#define REC_END     0x01
#define REC_XSEG    0x02
#define REC_SSEG    0x03
#define REC_XADDR   0x04
#define REC_SADDR   0x05
#define REC_SADDR   0x05
#define REC_CMDLINE 0x06
#endif
