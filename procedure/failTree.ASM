format PE Console
include 'win32ax.inc'
.data

abcstr DB '*',0
text1str DB 'tree',0
text2str DB 'My STRING 1',0
msg1str db 'Strings are equal.',10,13,0
msg2str db 'Strings are not equal.',10,13,0
inputnum DD 0
stdoutputhandle dd 0
outputstr db 'A', 0
inputnumber DD 0
 newline db 13, 10          ; Символы
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
    
    ; Получаем дескриптор стандартного вывода
    push STD_OUTPUT_HANDLE
    call [GetStdHandle]
    
    ; Устанавливаем цвет консоли
    mov ecx, [ebp + 8]               ; Получаем атрибут цвета из аргументов
    push ecx
    push eax
    call [SetConsoleTextAttribute]

    ; Получаем количество повторений
    mov ecx, [ebp + 8]               ; Загружаем значение в ecx

mainLoop:
    cmp ecx, 0                       ; Проверяем, не равно ли ecx нулю
    je end_mainLoop                  ; Если ecx = 0, выходим из цикла mainLoop

    push ecx                         ; Сохраняем значение ecx для внутреннего цикла
    mov ebx, ecx                     ; Сохраняем в ebx, чтобы использовать в loop1
    sub ecx, 1
loop1:
    ; Проверяем, не равно ли ecx нулю
    cmp ecx, 0                       ; Проверяем значение ecx
    je end_loop1                     ; Если ecx = 0, выходим из цикла

    push ecx                         ; Сохраняем текущее значение ecx
    push STD_OUTPUT_HANDLE           ; Подготавливаем параметры для GetStdHandle
    call [GetStdHandle]
    push 0                           ; Указываем, что не нужно использовать флаг
    push inputnumber                 ; Количество символов
    push 1                           ; Количество символов для записи
    push abcstr                      ; Указатель на строку
    push eax                         ; Дескриптор консоли
    call [WriteConsole]              ; Выводим строку на консоль
    pop ecx                          ; Восстанавливаем ecx




    dec ecx                          ; Уменьшаем значение ecx
    jmp loop1                        ; Возвращаемся к началу цикла loop1

end_loop1:
    push ecx                         ; Сохраняем текущее значение ecx
    push STD_OUTPUT_HANDLE           ; Подготавливаем параметры для GetStdHandle
    call [GetStdHandle]
    push 0                           ; Указываем, что не нужно использовать флаг
    push 2                           ; Количество символов для записи (два символа)
    push newline                     ; Указатель на строку переноса
    push eax                         ; Дескриптор консоли
    call [WriteConsole]              ; Выводим перенос строки
    pop ecx                          ; Восстанавливаем ecx

    pop ecx                          ; Восстанавливаем значение ecx перед продолжением mainLoop
    dec ebx                          ; Уменьшаем значение из ebx (количество оставшихся повторений)
    mov ecx, ebx                     ; Перемещаем результат обратно в ecx
    jmp mainLoop                     ; Возвращаемся в основной цикл

end_mainLoop:
    pop ecx                          ; Восстанавливаем регистры
    pop eax
    pop ebp
    ret 4



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
; вызов по метке
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



push STD_INPUT_HANDLE
call [GetStdHandle]
push 0
push inputnumber
push 8
push inputnumber
push eax
call [ReadConsole]

.end start
