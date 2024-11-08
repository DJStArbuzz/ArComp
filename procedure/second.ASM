                                                                                                       format PE Console
include 'win32ax.inc'
.data

inputnumber DD 0
 text1str DB 'MySTRING1',0
 text2str DB 'My STRING 1',0
 msg1str db 'Strings are equal.',10,13,0
 msg2str db 'Strings are not equal.',10,13,0
 inputnum DD 0
 stdoutputhandle dd 0
 outputstr db 'A', 0


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
mov edx,0x0006
Call setcolor

mov ecx,26
loop1:
 push ecx
 push STD_OUTPUT_HANDLE
 call [GetStdHandle]
 push 0
 push inputnumber
 push 1
 push outputstr
 push eax
 call [WriteConsole]
 inc byte[outputstr]
 pop ecx
 loop loop1




push STD_INPUT_HANDLE
call [GetStdHandle]
    push 0
    push inputnumber
    push 8
    push inputnumber
    push eax
    call [ReadConsole]

setcolor:
 push ebp
 mov ebp,esp

 push eax
 push edx

 push STD_OUTPUT_HANDLE
 call [GetStdHandle]
 mov edx,[ebp+2]
 push edx
 push eax
 call [SetConsoleTextAttribute]

 pop edx
 pop eax
 pop ebp
 ret

.end start
