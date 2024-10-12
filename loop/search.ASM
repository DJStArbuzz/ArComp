format PE Console
include 'win32ax.inc'

.data
hellostr DB "Write number: ",10,13,0
abcstr DB 'A',0
inputnumber DD 0
innumb DD 0
newlinestr DB 10,13,0

textstr DB 'Hello to everyone!',0
 foundstr DB 'Found letter in string.',0
 notfoundstr DB 'Did not find letter in string.',0

.code

start:

mov edi,textstr
 dec edi
 mov ecx,18

loop1:
 inc edi
 cmp byte[edi], "a"
 loopne loop1 
 test ecx,ecx
 jz notfound

 push STD_OUTPUT_HANDLE
 call [GetStdHandle]
 push 0
 push inputnumber
 push 23
 push foundstr
 push eax
 call [WriteConsole]
 jmp endfind

notfound:
 push STD_OUTPUT_HANDLE
 call [GetStdHandle]
 push 0
 push inputnumber
 push 31
 push notfoundstr
 push eax
 call [WriteConsole]

endfind:

push STD_INPUT_HANDLE
call[GetStdHandle]
push 0
push inputnumber
push 8
push inputnumber
push eax
call[ReadConsole]



.end start
