format PE console
entry start
include 'win32ax.inc'

section '.rdata' data readable writeable
  fmt  db   '%s', 13, 10, 0
  ext  db   'press key...%c',0
  src  db   'first st 1 20 3 45 67 90 1000 92 2974 4',0
  begin db  'Write sentence:', 13, 10, 0
  error db  'Допущена ошибка (число больше 3999)', 13, 10, 0
  nums db '0123456789'
  index dd 0

  outputstr db  '', 13, 10, 0
  res  db   256 dup(0)
  tmp db "!", 0
  buff3 db 2 dup(0)
  dst  db   256 dup(0)
  dst3  db   256 dup(0)
  dst2  db   256 dup(0)
  char db   0
  flag dd 0
  inputnumber dd 0
        
section '.idata' data readable import
  library kernel32, 'kernel32.dll', msvcrt,   'msvcrt.dll'
        
    import kernel32, ExitProcess, 'ExitProcess', lstrcat,'lstrcatA'
  import msvcrt, printf, 'printf', scanf, 'scanf'

section '.text' code executable

str_reverse: 
  mov esi, [esp + 8]
  mov edi, [esp + 4]
  xor ecx, ecx
@read:
  lodsb
  cmp al, 0
  je  @write
  push ax
  inc ecx
jmp @read
@write:  
  pop ax
  stosb
loop @write
  ret 8


macro numtostr num,str
{
mov eax,[num]
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

start:
  ; вывод строки
  invoke printf, fmt, src
  ; первый реверс
  push   src
  push   dst
  call   str_reverse


 ; invoke printf, fmt, dst
  mov ecx, dst
  xor eax, eax

 ; размер строки
mov ecx, dst
 xor eax, eax
 dec eax
 notzero:
 inc eax
 cmp byte[ecx+eax], 0
 jne notzero

;mov edi, src
;invoke printf, fmt, edi

mov eax,eax
sub eax,[inputnumber]
mov [inputnumber],eax
add [inputnumber], 1
;numtostr inputnumber,outputstr
;invoke printf, fmt, outputstr
;mov edi, src
mov ebx, 0

mov edi, dst
dec edi

mainLoop:
  inc ebx  ; на 1 итерацию меньше стал
  cmp ebx, [inputnumber]
  je endl

  inc edi

  mov esi, nums
  dec esi
  mov ecx, 11

  loop1:
     inc esi
     mov al, byte[edi]
     cmp byte[esi], al
     loopnz loop1
     test ecx, ecx
     jnz  found

  notfound:
      mov [flag], 0
      mov [char], al
      cmp [char], ' '
      je whitespace
      jne notwh

     whitespace:
           invoke  lstrcat, res,  " "
          jmp endfind
     notwh:
            invoke  lstrcat, res, "_"
                      jmp endfind
  found:
         inc [flag]
         cmp al, "4"
         jl foundLess4

         cmp [flag], 5
         je zero
         cmp al, "4"
         je foundEqual4

         cmp al, "9"
          jl foundLess9

         cmp al, "9"
          je foundEqual9

         cmp al, "0"
         je zero

          zero:
            add [flag], 1
             jmp mainLoop

          foundLess4:
            cmp [flag], 1
            je first

            cmp [flag], 2
            je second

            cmp [flag], 3
            je third

            cmp [flag], 4
            je fourth

              first:
                   mov [char], al
                   loop14:
                   cmp [char], '0'
                   je fin
                  ; invoke printf, fmt, "X"
                    invoke  lstrcat, res, 'I'
                   dec byte[char]
                   jmp loop14
             second:
                   mov [char], al
                   loop24:
                     cmp [char], '0'
                     je fin
                   ;invoke printf, fmt, "X"
                     invoke  lstrcat, res, 'X'
                     dec byte[char]
                     jmp loop24
           third:
                  mov [char], al
                  loop34:
                     cmp [char], '0'
                     je fin
                     invoke  lstrcat, res, 'C'
                    ;invoke printf, fmt, "C"
                     dec byte[char]
                     jmp loop34
           fourth:
                  mov [char], al
                  loop44:
                     cmp [char], '0'
                     je fin
                     invoke  lstrcat, res, 'M'
                    ; invoke printf, fmt, "M"
                     dec byte[char]
                    jmp loop44
           fin:
                jmp mainLoop

; четверка
          foundEqual4:
            cmp [flag], 1
            je first2

            cmp [flag], 2
            je second2

            cmp [flag], 3
            je third2

            first2:
               invoke  lstrcat, res, 'V'
               invoke  lstrcat, res, 'I'

               ; invoke printf, fmt, "VI"
               jmp fin4

             second2:
               invoke  lstrcat, res, 'L'
               invoke  lstrcat, res, 'X'
                    ; invoke printf, fmt, "LX"
               jmp fin4


              third2:
                invoke  lstrcat, res, 'D'
                invoke  lstrcat, res, 'C'
                    ; invoke printf, fmt, "DC"
                jmp fin4
             fin4:
                jmp mainLoop



          foundLess9:
            cmp [flag], 1
            je first3

            cmp [flag], 2
            je second3

            cmp [flag], 3
            je third3

            first3:
              mov [char], al
                  loopl43:
                    cmp [char], '5'
                    je fin1
                    invoke  lstrcat, res, 'I'
                    ; invoke printf, fmt, "I"
                     dec byte[char]
                    jmp loopl43
                fin1:
                     invoke  lstrcat, res, 'V'
                  ;  invoke printf, fmt, "V"
                      jmp mainLoop
            second3:
                   mov [char], al
                   loop243:
                     cmp [char], '5'
                     je fin2
                     invoke  lstrcat, res, 'X'
                    ; invoke printf, fmt, "I"
                     dec byte[char]
                     jmp loop243
                   fin2:
                       invoke  lstrcat, res, 'L'
                  ;  invoke printf, fmt, "V"
                       jmp mainLoop
           third3:
                  mov [char], al
                  loop343:
                     cmp [char], '5'
                     je fin3
                     invoke  lstrcat, res, 'C'
                    ; invoke printf, fmt, "C"
                     dec byte[char]
                     jmp loop343
                  fin3:
                     invoke  lstrcat, res, 'D'
                  ; invoke printf, fmt, "D"
                     jmp mainLoop

          foundEqual9:
             cmp [flag], 1
            je first4

            cmp [flag], 2
            je second4

            cmp [flag], 3
            je third4

            first4:
              invoke  lstrcat, res, 'X'
              invoke  lstrcat, res, 'I'
          ;      invoke printf, fmt, "IX"
              jmp mainLoop

            second4:
              invoke  lstrcat, res, 'C'
              invoke  lstrcat, res, 'X'
                    ; invoke printf, fmt, "XC"
              jmp mainLoop


            third4:
              invoke  lstrcat, res, 'M'
              invoke  lstrcat, res, 'C'
                   ;  invoke printf, fmt, "CM"
              jmp mainLoop


   endfind:
    jmp mainLoop

endl:
   push   res
   push   dst2
   call   str_reverse
  invoke printf, fmt,  dst2

  invoke scanf, ext, char
  invoke ExitProcess, 0
