proc endprogram

push STD_OUTPUT_HANDLE
call [GetStdHandle]
push 0
push inputnumber
push 20
push words
push eax
call [WriteConsole]

push STD_INPUT_HANDLE
call [GetStdHandle]
    push 0
    push inputnumber
    push 8
    push inputnumber
    push eax
    call [ReadConsole]

  ret
endp