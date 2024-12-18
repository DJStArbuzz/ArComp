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

    push ecx; ��������� �������� ecx ��� ����������� �����
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

call [GetStdHandle]
    push 0
    push inputnumber
    push 8
    push inputnumber
    push eax
    call [ReadConsole]


.end start