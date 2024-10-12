format PE Console
include 'win32ax.inc'

.data
hellostr DB "Cin num: ", 0
abcstr DB 'A',0
 inputnumber DW 0
newlinestr DB 10,13,0
inputstr DD 0


.code

start:

push STD_OUTPUT_HANDLE
call [GetStdHandle]
push 0
push inputnumber
push 9
push hellostr
push eax
call [WriteConsole]


push STD_INPUT_HANDLE
call [GetStdHandle]
push 0
push inputnumber
push 8
push inputnumber
push eax
call [ReadConsole]

mov ecx, inputnumber

loop1:
 push ecx
 mov ecx,13
loop2:
 push ecx
 push STD_OUTPUT_HANDLE
 call [GetStdHandle]
 push 0
 push inputnumber
 push 1
 push abcstr
 push eax
 call [WriteConsole]
 inc byte[abcstr]
 pop ecx
 loop loop2
 push STD_OUTPUT_HANDLE
 call [GetStdHandle]
 push 0
 push inputnumber
 push 2
 push newlinestr
 push eax
 call [WriteConsole]
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


.end start
