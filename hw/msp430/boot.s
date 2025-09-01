.section .vectors, "ax"
.word _start
.word _stacktop
.word 0
.word 0

.text
.global _start
.extern main
_start:
    jmp main
    
.global _exit
_exit:
    jmp .

