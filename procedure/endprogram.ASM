

proc endprogram

locals
words db 'Press any key... ', 10, 13, 0
 inputnumber dd 1
 endl

push STD_OUTPUT_HANDLE
call [GetStdHandle]
push 0
push [inputnumber]
push 17
push [words]
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
 push [inputnumber]
 push 1
 push [words]
 push eax
 call [ReadConsole]
 push 0
 call [ExitProcess]


  ret
endp