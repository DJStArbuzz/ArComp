format PE Console
include 'win32ax.inc'
.data

star DB '*',0
text DB 'trr',0
number DD 0
newline db 10, 13

.code

color:
  push ebp
  mov ebp, esp

  push eax
  push ecx

  ; Óñòàíàâëèâàåì öâåò êîíñîëè
  push STD_OUTPUT_HANDLE
  call [GetStdHandle]
  mov ecx, [ebp + 8]               ; Öâåò èç àðãóìåíòîâ
  push ecx
  push eax
  call [SetConsoleTextAttribute]
  pop ecx
pop eax
pop ebp
ret 4


drawTree:
  push ebp
  mov ebp, esp

  push eax
  push ecx

  mov ecx, [ebp + 8]

  mainLoop:
    cmp ecx, 0                       ; Ïðîâåðÿåì, íå ðàâíî ëè ecx íóëþ
    je end_mainLoop                  ; Åñëè ecx = 0, âûõîäèì èç öèêëà

    push ecx                         ; Ñîõðàíÿåì çíà÷åíèå ecx äëÿ âíóòðåííåãî öèêëà
    mov ebx, ecx                     ; Ñîõðàíÿåì â ebx, ÷òîáû èñïîëüçîâàòü â loop1
    sub ecx, 1
    loop1:
        cmp ecx, 0                       ; Ïðîâåðÿåì çíà÷åíèå ecx
        je end_loop1                     ; Åñëè ecx = 0, âûõîäèì èç öèêëà

        push ecx                         ; Ñîõðàíÿåì òåêóùåå çíà÷åíèå ecx
        push STD_OUTPUT_HANDLE           ; Ïîäãîòàâëèâàåì ïàðàìåòðû äëÿ GetStdHandle
        call [GetStdHandle]
        push 0                           ; Óêàçûâàåì, ÷òî íå íóæíî èñïîëüçîâàòü ôëàã
        push number                 ; Êîëè÷åñòâî ñèìâîëîâ
        push 1                           ; Êîëè÷åñòâî ñèìâîëîâ äëÿ çàïèñè
        push star                        ; Óêàçàòåëü íà ñòðîêó
        push eax                         ; Äåñêðèïòîð êîíñîëè
        call [WriteConsole]              ; Âûâîäèì ñòðîêó íà êîíñîëü

        pop ecx                          ; Âîññòàíàâëèâàåì ecx
        dec ecx                          ; Óìåíüøàåì çíà÷åíèå ecx
        jmp loop1                        ;

    end_loop1:

    push STD_OUTPUT_HANDLE
    call [GetStdHandle]
    push 0
    push number
    push 2
    push newline
    push eax
    call [WriteConsole]              ; Âûâîäèì ïåðåíîñ ñòðîêè

    pop ecx                          ; Âîññòàíàâëèâàåì çíà÷åíèå ecx ïåðåä ïðîäîëæåíèåì mainLoop
    dec ebx                          ; Óìåíüøàåì çíà÷åíèå èç ebx
    mov ecx, ebx                     ; Ïåðåìåùàåì ðåçóëüòàò îáðàòíî â ecx
    jmp mainLoop                     ; Âîçâðàùàåìñÿ â îñíîâíîé öèêë

end_mainLoop:

pop ecx
pop eax
pop ebp
ret 4

proc myProcColor, a
 push STD_OUTPUT_HANDLE
  call [GetStdHandle]
  push [a]
  push eax
  call [SetConsoleTextAttribute]

  ret
endp


start:

mov ecx, text
xor eax, eax

notzero:
 inc eax
 cmp byte[ecx+eax], 0
 jne notzero

 add eax, 1

 ccall myProcColor, 0x006

 push eax
 call drawTree

 push eax

 push STD_INPUT_HANDLE
 call [GetStdHandle]
 push 8
 push number
 push eax
 ccall [ReadConsole]

.end start
