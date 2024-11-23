format PE Console
include '..\include\win32ax.inc'
.data
msg1str DB 'Strings are equal.',10,13,0
msg2str DB 'Strings are not equal.',10,13,0
stdoutputhandle DD 0
randombuffer DD 0
star db "#",0

inputnumber DD 10
inputnum DD 0
num DD 10
newlinestr DB 10,13
res db "mmmmmm",10
z DB "*",0

.code
proc setcolor uses edx eax, a ; ïðîöåäóðà ñìåíû öâåòà
push STD_OUTPUT_HANDLE ;ñìåíà öâåòà
call [GetStdHandle]
mov edx,[a]
push edx
push eax
call [SetConsoleTextAttribute]
ret
endp

elochka:
inc ebp
ccall setcolor, ebp ;ïîìåíÿòü öâåò
dec ebp

mov ecx,ebp ;ecx - ñ÷åò÷èê öèêëà
loop1:
push ecx
push STD_OUTPUT_HANDLE ;âûâîä
call [GetStdHandle]
push 0
push inputnumber
push 1
push z ; çâåçäî÷êà
push eax
call [WriteConsole]
pop ecx
loop loop1 ; ïîâòîð öèêëà

push STD_OUTPUT_HANDLE ;âûâîä
call [GetStdHandle]
push 0
push inputnumber
push 1
push newlinestr ; íîâàÿ ñòðîêà
push eax
call [WriteConsole]

dec ebp ; óìåíüøåíèå êîëè÷åñòâà çâåçäî÷åê â ñòðîêå
jz lab1 ; åñëè ïðåäûäóùàÿ êîìàíäû çàêîí÷èëñÿ 0 âûïîëíèòü ïåðåõîä â lab1

call elochka ; çàïóñê åëî÷êè
ret ; âîçâðàò èç ïðîöåäóðû

proc WRandom
push edx ecx
mov eax, [randombuffer]
or eax, eax
jnz @f ; eax 0
rdtsc
xor eax, edx ;
mov [randombuffer],eax
@@:
xor edx, edx
mov ecx, 127773
div ecx ;ecx=x(i)%Q
mov ecx, eax ; ecx = X(i)/Q
mov eax, 16807
mul edx ;eax =a*(ecx)
mov edx, ecx
mov ecx, eax
mov eax, 2836
mul edx ; R*[X(i)/Q]
sub ecx, eax ; ecx = a*(X(i)mod Q)
xor edx, edx
mov eax, ecx
mov [randombuffer],ecx
mov ecx, 100000
div ecx ; ecx=eax%100000
mov eax, edx
pop ecx edx
ret
endp
start:


lab1:

mov ecx,2000
loop2:
cmp ecx,1
jz endloop2

push ecx
ccall WRandom


ccall setcolor, eax

push STD_OUTPUT_HANDLE
call [GetStdHandle]
push 0
push inputnumber
push 1
push star
push eax
call [WriteConsole]

pop ecx
dec ecx

jmp loop2
endloop2:

push STD_INPUT_HANDLE
call [GetStdHandle]
push 0
push inputnum
push 8
push star
push eax
call [ReadConsole]

.end start
