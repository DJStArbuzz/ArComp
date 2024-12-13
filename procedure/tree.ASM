format PE Console
include 'win32ax.inc'
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

  ; ������������� ���� �������
  push STD_OUTPUT_HANDLE
  call [GetStdHandle]
  mov ecx, [ebp + 8]               ; ���� �� ����������
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
    cmp ecx, 0                       ; ���������, �� ����� �� ecx ����
    je end_mainLoop                  ; ���� ecx = 0, ������� �� �����

    push ecx                         ; ��������� �������� ecx ��� ����������� �����
    mov ebx, ecx                     ; ��������� � ebx, ����� ������������ � loop1
    sub ecx, 1
    loop1:
        cmp ecx, 0                       ; ��������� �������� ecx
        je end_loop1                     ; ���� ecx = 0, ������� �� �����

        push ecx                         ; ��������� ������� �������� ecx
        push STD_OUTPUT_HANDLE           ; �������������� ��������� ��� GetStdHandle
        call [GetStdHandle]
        push 0                           ; ���������, ��� �� ����� ������������ ����
        push number                 ; ���������� ��������
        push 1                           ; ���������� �������� ��� ������
        push star                        ; ��������� �� ������
        push eax                         ; ���������� �������
        call [WriteConsole]              ; ������� ������ �� �������

        pop ecx                          ; ��������������� ecx
        dec ecx                          ; ��������� �������� ecx
        jmp loop1                        ;

    end_loop1:

    push STD_OUTPUT_HANDLE
    call [GetStdHandle]
    push 0
    push number
    push 2
    push newline
    push eax
    call [WriteConsole]              ; ������� ������� ������

    pop ecx                          ; ��������������� �������� ecx ����� ������������ mainLoop
    dec ebx                          ; ��������� �������� �� ebx
    mov ecx, ebx                     ; ���������� ��������� ������� � ecx
    jmp mainLoop                     ; ������������ � �������� ����

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

 push STD_INPUT_HANDLE
 call [GetStdHandle]
 push 8
 push number
 push eax
 call [ReadConsole]

.end start