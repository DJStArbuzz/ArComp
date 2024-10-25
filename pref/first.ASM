                                                                                                       format PE Console
include 'win32ax.inc'
.data

 inputnumber DD 0
 text1str DB 'My STRING 1',0
 text2str DB 'My STRING 1',0
 msg1str db 'Strings are equal.',10,13,0
 msg2str db 'Strings are not equal.',10,13,0
 inputnum DD 0
 stdoutputhandle dd 0
 outputstr db '', 0


sizeOutput db '      ', 0

.code
macro numtostr num, str
{
mov eax,num
xor ecx,ecx
mov ebx,10
numtostrloop1:
xor edx,edx
div ebx
add edx, '0'
push edx
inc ecx
test eax,eax
jnz numtostrloop1
mov edi,str
numtostrloop2:
pop edx
mov byte[edi],dl
inc edi
dec ecx
test ecx,ecx
jnz numtostrloop2
}

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

mov ecx,text1str
 xor eax, eax
 dec eax
 notzero:
 inc eax
 cmp byte[ecx+eax], 0
 jne notzero

numtostr eax,outputstr

push STD_OUTPUT_HANDLE
call [GetStdHandle]

push 0
    push 20
    push outputstr
    push eax
    call [WriteConsole]


.end start
