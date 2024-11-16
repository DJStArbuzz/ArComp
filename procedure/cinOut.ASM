format PE Console
include 'win32ax.inc'
 include 'endprogram.asm'
.data
hellostr DB "Hello world.",0

.code
start:
 ccall endprogram
.end start