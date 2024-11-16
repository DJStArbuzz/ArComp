

proc endprogram

locals
words db 'Press any key... ', 10, 13, 0
 inputnumber dd 1
 endl

lea ebx, [words]
lea ecx, [inputnumber]
push STD_OUTPUT_HANDLE
call [GetStdHandle]
push 0
push ecx
push 17
push ebx
push eax
call [WriteConsole]

push STD_INPUT_HANDLE
 call [GetStdHandle]
 push NULL
 push eax
 call [SetConsoleMode]
 push STD_INPUT_HANDLE
 call [GetStdHandle]
 push 0
 push ecx
 push 1
 push ebx
 push eax
 call [ReadConsole]
 push 0
 call [ExitProcess]


  ret
endp