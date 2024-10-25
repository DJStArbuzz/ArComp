                                                                                                       format PE Console
include 'win32ax.inc'
.data

 text1str DB 'My STRING 1',0
 text2str DB 'My STRING 1',0
 msg1str db 'Strings are equal.',10,13,0
 msg2str db 'Strings are not equal.',10,13,0
 inputnum DD 0
 stdoutputhandle dd 0

.code


start:

push STD_OUTPUT_HANDLE
 call [GetStdHandle]
 mov [stdoutputhandle],eax
 cld
 mov esi,text1str
 mov edi,text2str
 mov ecx,12
 repe cmpsb
 je strequal
 push 0
 push inputnum
 push 24
 push msg2str
 push [stdoutputhandle]
 call [WriteConsole]
 jmp strnotequal
 strequal:
 push 0
 push inputnum
 push 20
 push msg1str
 push [stdoutputhandle]
 call [WriteConsole]
 strnotequal:


.end start
