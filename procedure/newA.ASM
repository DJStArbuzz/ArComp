format PE Console
include 'win32ax.inc'
 include 'endprogram.asm'
.data

 inputnum DD 0
 stdoutputhandle dd 0
 outputstr db 'A', 0
 outputnumber DD 0


.code
macro numtostr num, str
{
mov eax,num
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

proc myProcColor, a
 push STD_OUTPUT_HANDLE
  call [GetStdHandle]
  push [a]
  push eax
  call [SetConsoleTextAttribute]

  ret
endp

start:
 ccall myProcColor, 0x006

 ccall endprogram

.end start