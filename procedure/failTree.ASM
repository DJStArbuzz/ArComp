format PE Console
include 'win32ax.inc'
.data

abcstr DB '*',0
text1str DB 'tre',0
text2str DB 'My STRING 1',0
msg1str db 'Strings are equal.',10,13,0
msg2str db 'Strings are not equal.',10,13,0
inputnum DD 0
stdoutputhandle dd 0
outputstr db 'A', 0
inputnumber DD 0

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

mycolor:
push ebp
mov ebp, esp

push eax
push ecx

push STD_OUTPUT_HANDLE
call [GetStdHandle]
mov ecx,[ebp+8]
push ecx
push eax
call [SetConsoleTextAttribute]

pop edx
pop eax
pop ebp
ret 4


tree:
push ebp
mov ebp, esp

push eax
push ecx

 mov ecx,[ebp+8]

loop1:
 push ecx

push STD_OUTPUT_HANDLE
call [GetStdHandle]
push 0
push inputnumber
push 1
push abcstr
push eax
call [WriteConsole]

 loop loop1



; push ebp
; mov ebp, esp
; push STD_
; call [Get Std
; mov ecx, [es[ + 8]
; push ecx
;
;push eax
;
;call
;pop ebp
;ret 4

;cal myproc:
;mov eax, myproc
;call eax
; âûçîâ ïî ìåòêå
start:

;push STD_INPUT_HANDLE
;call [GetStdHandle]
;push 0
;push inputnum
;push 1
;push inputnumber
;push eax
;call [ReadConsole]

; push [argN]
;push [arg0]
; call myProc

; myproc:
; push ebp
; mov ebp, esp

mov ecx, text1str
xor eax, eax
dec eax
notzero:
inc eax
cmp byte[ecx+eax], 0
jne notzero

add eax, 1
mov edx, eax
push edx
call mycolor

push edx
call tree


push STD_INPUT_HANDLE
call [GetStdHandle]
push 0
push inputnumber
push 8
push inputnumber
push eax
call [ReadConsole]

.end start
