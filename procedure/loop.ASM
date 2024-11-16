format PE Console
include 'win32ax.inc'

.data
hellostr DB "Write number: ",10,13,0
abcstr DB 'A',0
inputnumber DD 0
number DD 1
newlinestr DB 10,13,0
inputstr DB " ",0

textstr DB 'Hello to everyone!',0
 foundstr DB 'Found letter in string.',0
 notfoundstr DB 'Did not find letter in string.',0

.code

macro numtostr num, str
{
mov eax, num
xor ecx, ecx
mov ebx, 10

numtostrloop1:
xor edx, edx
div ebx
add edx, '0'
push edx
inc ecx
test eax, eax
jnz numtostrloop1

mov edi, str

numtostrloop2:
pop edx
mov byte[edi], dl
inc edi
dec ecx
test ecx, ecx
jnz numtostrloop2
}

start:

mov edi,textstr
 dec edi
 mov ecx,18

loop1:
 inc edi
 cmp byte[edi], "H"
 loopne loop1 
 test ecx,ecx
 jz notfound

mov eax,19
 sub eax,[number]
 mov [number],eax
 numtostr number,inputstr

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

push STD_OUTPUT_HANDLE
call [GetStdHandle]
push 0
push inputnumber
push 20
push number
push eax
call [WriteConsole]


push STD_INPUT_HANDLE
call[GetStdHandle]
push 0
push inputnumber
push 8
push inputnumber
push eax
call[ReadConsole]



.end start