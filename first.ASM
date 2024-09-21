format PE Console
include 'win32ax.inc'
.data
hellostr DB "Cin name of user: ",10,13,0
inputnumber DD 0
inputstr db "",10, 13, 0
colorstr DB "WORLD",10,13,0
.code

macro setcolor color
{
push STD_OUTPUT_HANDLE
call [GetStdHandle]
push color
push eax
call [SetConsoleTextAttribute]
}
start:
;push STD_OUTPUT_HANDLE
;call [GetStdHandle]
;push 0x0004
;push eax
;call [SetConsoleTextAttribute]

xor ecx, ecx
showcolors:
cmp ecx,16
jz endcolors
push ecx

setcolor ecx

push STD_OUTPUT_HANDLE
call [GetStdHandle]
push 0
push inputnumber
push 7
push colorstr
push eax
call [WriteConsole]
pop ecx
inc ecx
jmp showcolors
endcolors:

push STD_OUTPUT_HANDLE
call [GetStdHandle]
push 0
push inputnumber
push 20
push hellostr
push eax
call [WriteConsole]

push STD_INPUT_HANDLE
call [GetStdHandle]
push 0
push inputnumber
push 8
push inputstr
push eax
call [ReadConsole]

push STD_OUTPUT_HANDLE
call [GetStdHandle]
push 0
push inputnumber
push 20
push inputstr
push eax
call [WriteConsole]

push STD_INPUT_HANDLE
call [GetStdHandle]
push 0
push inputnumber
push 8
push inputstr
push eax
call [ReadConsole]

push STD_INPUT_HANDLE
call [GetStdHandle]
push NULL
push eax
call [SetConsoleMode]
.end start
