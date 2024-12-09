format PE console
entry start
include 'win32ax.inc'

section '.rdata' data readable writeable
  fmt  db   '%s', 13, 10, 0
  ext  db   'press key...%c',0
  src  db   'first 1 20 3 45 67 90 3000 92 3974 4',0
  begin db  'Write sentence:', 13, 10, 0
  error db  'Äîïóùåíà îøèáêà (÷èñëî áîëüøå 3999)', 13, 10, 0
  nums db '0123456789'
  index dd 0

  outputstr db  '', 13, 10, 0
  res db '', 0
  tmp db "", 0

  dst  db   256 dup(0)
  dst3  db   256 dup(0)
  dst2  db   256 dup(0)
  char db   0
  flag dd 0
  inputnumber dd 0
        
section '.idata' data readable import
  library kernel32, 'kernel32.dll', msvcrt,   'msvcrt.dll'
        
  import kernel32, ExitProcess, 'ExitProcess'
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

macro   string name, data
{
  local ..start
..start:
sizeof.#name =  $ - ..start
}

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
  ; âûâîä ñòðîêè
  invoke printf, fmt, src
  ; ïåðâûé ðåâåðñ
  push   src
  push   dst
  call   str_reverse


  invoke printf, fmt, dst
  mov ecx, dst
  xor eax, eax

 ; ðàçìåð ñòðîêè
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

mov eax, 0

mainLoop:
  inc ebx  ; íà 1 èòåðàöèþ ìåíüøå ñòàë
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

     invoke printf, fmt, 'a'


     mov [flag], 0
     jmp endfind
  found:

         cmp al, "0"
         je zero

         inc [flag]
         cmp al, "4"
         jl foundLess4

         cmp [flag], 4
         je zero
         cmp al, "4"
         je foundEqual4

         cmp al, "9"
          jl foundLess9

         cmp al, "9"
          je foundEqual9

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
                  loopl4:
                    cmp [char], '0'
                    je endfind
                    push "I"

                     mov ecx, eax
                     mov [dst3 + ecx], "I"
                     inc eax

                     dec byte[char]
                    jmp loopl4
             second:
                   mov [char], al
                  loop24:
                    cmp [char], '0'
                    je endfind

                      mov ecx, eax
                     mov [dst3 + ecx], "X"
                     inc eax

                     dec byte[char]
                    jmp loop24
           third:
                      mov [char], al
                  loop34:
                    cmp [char], '0'
                    je endfind

                      mov ecx, eax
                     mov [dst3 + ecx], "C"
                     inc eax

                     dec byte[char]
                    jmp loop34
           fourth:
                    mov [char], al
                  loop44:
                    cmp [char], '0'
                    je endfind

                      mov ecx, eax
                     mov [dst3 + ecx], "M"
                     inc eax

                     dec byte[char]
                    jmp loop44

; ÷åòâåðêà
          foundEqual4:
            cmp [flag], 1
            je first2

            cmp [flag], 2
            je second2

            cmp [flag], 3
            je third2

              first2:

                 mov ecx, eax
                     mov [dst3 + ecx], "V"
                     inc eax
                      mov [dst3 + ecx+1], "I"
                     inc eax

                                    je endfind

             second2:

                                            mov ecx, eax
                     mov [dst3 + ecx], "L"
                     inc eax
                      mov [dst3 + ecx+1], "X"
                     inc eax

                                         je endfind


           third2:
                 mov ecx, eax
                                           mov ecx, eax
                     mov [dst3 + ecx], "D"
                     inc eax
                      mov [dst3 + ecx+1], "C"
                     inc eax
                                         je endfind



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

                     mov ecx, eax
                     mov [dst3 + ecx], "I"
                     inc eax

                     invoke printf, fmt, "I"
                     dec byte[char]
                    jmp loopl43
                fin1:

                                          mov ecx, eax
                     mov [dst3 + ecx], "V"
                     inc eax

                    je endfind
            second3:
                       mov [char], al
                  loop243:
                    cmp [char], '5'
                      je fin2

                      mov ecx, eax
                     mov [dst3 + ecx], "X"
                     inc eax


                     dec byte[char]
                    jmp loop243
                 fin2:

                      mov ecx, eax
                     mov [dst3 + ecx], "L"

                     inc eax
                    je endfind
           third3:
                      mov [char], al
                  loop343:
                    cmp [char], '5'
                    je fin3

                    je endfind

                      mov ecx, eax
                     mov [dst3 + ecx], "C"
                     inc eax

                     dec byte[char]
                    jmp loop343
                   fin3:
                     mov ecx, eax
                     mov [dst3 + ecx], "D"
                     inc eax
                    je endfind

          foundEqual9:
             cmp [flag], 1
            je first4

            cmp [flag], 2
            je second4

            cmp [flag], 3
            je third4

              first4:
                                     mov ecx, eax
                     mov [dst3 + ecx], "I"
                     inc eax
                      mov [dst3 + ecx+1], "X"
                     inc eax
                                    je endfind

             second4:
                                                         mov ecx, eax
                     mov [dst3 + ecx], "X"
                     inc eax
                      mov [dst3 + ecx+1], "C"
                     inc eax
                                         je endfind


           third4:

                                                        mov ecx, eax
                     mov [dst3 + ecx], "C"
                     inc eax
                      mov [dst3 + ecx+1], "M"
                     inc eax
                                         je endfind

          zero:

            add [flag], 1
             jmp endfind


   endfind:
   jmp mainLoop

endl:
    push   dst2
  push   dst3
  call   str_reverse

  invoke printf, fmt, dst2

  invoke scanf, ext, char
  invoke ExitProcess, 0
