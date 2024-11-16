format PE Console
include 'win32ax.inc'

.data
text1str DB 'My STRING 1',0
 text2str DB 'My STRING 2',0
 msg1str db 'Strings are equal.',10,13,0
msg2str db 'Strings are not equal.',10,13,0
 inputnum DD 0
 stdoutputhandle dd 0
 inputnumber DW 0
 outputstr db '', 0

star DB '*',0
text DB 'tree',0
number DD 0
newline db 10, 13


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

proc color
  push ebp
  mov ebp, esp

  push eax
  push ecx

  ; Устанавливаем цвет консоли
  push STD_OUTPUT_HANDLE
  call [GetStdHandle]
  mov ecx, [ebp + 8]               ; Цвет из аргументов
  push ecx
  push eax
  call [SetConsoleTextAttribute]
  pop ecx
pop eax
pop ebp
ret
endp

proc drawTree
  push ebp
  mov ebp, esp

  push eax
  push ecx

  mov ecx, [ebp + 8]

  mainLoop:
    cmp ecx, 0                       ; Проверяем, не равно ли ecx нулю
    je end_mainLoop                  ; Если ecx = 0, выходим из цикла

    push ecx; Сохраняем значение ecx для внутреннего цикла
    ccall color
    push ecx
    mov ebx, ecx                     ; Сохраняем в ebx, чтобы использовать в loop1

    sub ecx, 1
    loop1:
        cmp ecx, 0                       ; Проверяем значение ecx
        je end_loop1                     ; Если ecx = 0, выходим из цикла

        push ecx                         ; Сохраняем текущее значение ecx
        push STD_OUTPUT_HANDLE           ; Подготавливаем параметры для GetStdHandle
        call [GetStdHandle]
        push 0                           ; Указываем, что не нужно использовать флаг
        push number                 ; Количество символов
        push 1                           ; Количество символов для записи
        push star                        ; Указатель на строку
        push eax                         ; Дескриптор консоли
        call [WriteConsole]              ; Выводим строку на консоль

        pop ecx                          ; Восстанавливаем ecx
        dec ecx                          ; Уменьшаем значение ecx
        jmp loop1                        ;

    end_loop1:

    push STD_OUTPUT_HANDLE
    call [GetStdHandle]
    push 0
    push number
    push 2
    push newline
    push eax
    call [WriteConsole]              ; Выводим перенос строки

    pop ecx                          ; Восстанавливаем значение ecx перед продолжением mainLoop
    dec ebx                          ; Уменьшаем значение из ebx
    mov ecx, ebx                     ; Перемещаем результат обратно в ecx
    jmp mainLoop                     ; Возвращаемся в основной цикл

end_mainLoop:

pop ecx
pop eax
pop ebp
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

push eax
 ccall drawTree

call [GetStdHandle]
    push 0
    push inputnumber
    push 8
    push inputnumber
    push eax
    call [ReadConsole]


.end start