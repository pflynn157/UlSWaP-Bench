.extern main
.extern _interrupt_exception
.extern _bus_exception
.extern _float_exception

.extern _stacktop

.section .vectors, "ax"
.word _start                    # The program start
.word _interrupt_exception      # Exception handler
.word _bus_exception            # Bus exception handler
.word _float_exception          # Float exception handler
.word 0

# Interrupts- the simulator supports 16
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0


.text
.global _start
_start:
    # Setup the stack and call main
    lui sp, %hi(_stacktop)
    addi sp, sp, %lo(_stacktop)
    
    call main
    
    # Return and exit
    jal x0, _exit

.global _exit
_exit:
    .word 0xABCD0013
    beq x0, x0, _exit
    



