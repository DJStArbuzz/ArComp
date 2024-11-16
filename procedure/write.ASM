push STD_OUTPUT_HANDLE
 call [GetStdHandle]
 push 0
 push outputnumber
 push 255
 push outputstr
 push eax
 call [WriteConsole]