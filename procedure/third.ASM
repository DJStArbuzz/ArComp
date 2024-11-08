format PE Console
include 'win32ax.inc'
.data

inputnumber DD 0
text1str DB 'abcds', 0
text2str DB 'My STRING 1', 0
msg1str db 'Strings are equal.', 10, 13, 0
msg2str db 'Strings are not equal.', 10, 13, 0
inputnum DD 0
stdoutputhandle dd 0
outputstr db 'A', 0

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
    mov byte [edi], dl
    inc edi
    dec ecx
    test ecx, ecx
    jnz numtostrloop2
}

start:

    ; Âûâîäèì ñòðîêó


    push text1str       ; ïåðåäàåì ñòðîêó â ñòåê;
    call OutputString   ; âûâîäèì ñòðîêó

    ; Ïàóçà ïåðåä çàâåðøåíèåì


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
    mov ebp, esp

    push eax
    push edx

    push STD_OUTPUT_HANDLE
    call [GetStdHandle]
    mov edx, [ebp + 3]
    push edx
    push eax
    call [SetConsoleTextAttribute]

    pop edx
    pop eax
    pop ebp
    ret 4                ; âîçâðàùàåì 4 áàéòà íà ñòåê


OutputString:
    push ebp
    mov ebp, esp

    push eax               ; Ñîõðàíÿåì çíà÷åíèå EAX 
    push edx               ; Ñîõðàíÿåì çíà÷åíèå EDX 

    push STD_OUTPUT_HANDLE
    call [GetStdHandle]    ; Ïîëó÷àåì äåñêðèïòîð ñòàíäàðòíîãî âûâîäà
    mov ebx, eax           ; Ñîõðàíÿåì äåñêðèïòîð â EBX

    mov edx, [ebp + 8]     ; Ïîëó÷àåì àäðåñ ñòðîêè


    mov ecx, 5     ; Ïîëó÷àåì êîëè÷åñòâî ñèìâîëîâ äëÿ âûâîäà
    push 0                 ; NULL äëÿ lpNumberOfCharsWritten
    push ecx               ; Êîëè÷åñòâî ñèìâîëîâ
    push edx               ; Àäðåñ ñòðîêè
    push ebx               ; Äåñêðèïòîð ñòàíäàðòíîãî âûâîäà
    call [WriteConsole]    ; Âûâîäèì ñòðîêó

    pop edx
    pop eax
    pop ebp
    ret 8

.end start
