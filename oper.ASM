format PE Console
include 'win32ax.inc'

.data
 inputnumber DD 0
 outputstring DB "123", 10,13,0
 inputstr DB "",10, 13, 0
 num_char DD 5
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


mov eax, 32
imul eax, 9
add eax, 6
shr eax, 1 ; äåëèòü íà 2
add eax, 11

numtostr eax, outputstring


push STD_OUTPUT_HANDLE
call [GetStdHandle]

push 0
    push inputnumber
    push outputstring
    push eax
    call [WriteConsole]

    push STD_INPUT_HANDLE
    call [GetStdHandle]
    push 0
    push inputnumber
    push 20
    push inputstr
    push eax
    call [ReadConsole]

.end start
