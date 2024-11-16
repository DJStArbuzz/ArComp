format PE Console
include 'win32ax.inc'
 include 'endprogram.asm'
.data

star DB '*',0
text DB 'tree',0
number DD 0
newline db 10, 13

.code

color:
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
ret 4



drawTree:
  push ebp
  mov ebp, esp

  push eax
  push ecx

  mov ecx, [ebp + 8]

  mainLoop:
    cmp ecx, 0                       ; Проверяем, не равно ли ecx нулю
    je end_mainLoop                  ; Если ecx = 0, выходим из цикла

    push ecx                         ; Сохраняем значение ecx для внутреннего цикла
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
ret 4



start:

mov ecx, text
xor eax, eax

notzero:
 inc eax
 cmp byte[ecx+eax], 0
 jne notzero

 add eax, 1
 push eax
 call color

 push eax
 call drawTree

 push eax

 ccall endprogram
.end start