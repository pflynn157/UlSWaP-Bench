    .text
    
    .extern CHECKPOINT_TABLE1
    .extern CHECKPOINT_TABLE2
    .extern CHECKPOINT_UNROLL
    .extern checkpoint

####################################################################
##
## Memory based checkpoint unroll functions
##
####################################################################

.global checkpoint_unroll_init
.type   checkpoint_unroll_init, @function
checkpoint_unroll_init:
    addi sp, sp, -4
    sw x31, 0(sp)
    lui x31, %hi(CHECKPOINT_UNROLL)
    addi x31, x31, %lo(CHECKPOINT_UNROLL)
    sw a0, 4(x31)
    sw x0, 0(x31)
    lw x31, 0(sp)
    addi sp, sp, 4
    ret
    
.global checkpoint_maybe
.type   checkpoint_maybe, @function
checkpoint_maybe:
    #.word 0x5000000b
    addi sp, sp, -16
    sw x31, 0(sp)
    sw x30, 4(sp)
    sw x29, 8(sp)
    lui x31, %hi(CHECKPOINT_UNROLL)
    addi x31, x31, %lo(CHECKPOINT_UNROLL)
    lw x30, 0(x31)      # i
    lw x29, 4(x31)      # max
    blt x30, x29, cm_next
    sw x0, 0(x31)       # i = 0
    sw x1, 8(x31)       # store RA
    lw x31, 0(sp)
    lw x30, 4(sp)
    lw x29, 8(sp)
    #.word 0x5100000b
    addi sp, sp, 16
    call checkpoint
    lui x1, %hi(CHECKPOINT_UNROLL)
    addi x1, x1, %lo(CHECKPOINT_UNROLL)
    lw x1, 8(x1)
    ret
cm_next:
    addi x30, x30, 1
    sw x30, 0(x31)      # i += 1
    lw x31, 0(sp)
    lw x30, 4(sp)
    lw x29, 8(sp)
    addi sp, sp, 16
    ret

