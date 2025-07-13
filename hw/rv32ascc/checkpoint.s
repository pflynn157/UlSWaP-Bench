    .text
    
    .extern APTR
    .extern IPTR
    .extern TPTR
    
##
## Checkpoint sync
## When we enter a new function, both tables should be syncronized with
## the new functions state so we can update incrementally.
##
## Checkpoint
## Sync the new table
##
    .global checkpoint_sync
    .type checkpoint_sync, @function
checkpoint_sync:
    addi sp, sp, -16
    sw x31, 0(sp)
    sw x30, 4(sp)
    
    lui x31, %hi(APTR)
    addi x31, x31, %lo(APTR)
    lw x31, 0(x31)
    
    lui x30, %hi(IPTR)
    addi x30, x30, %lo(IPTR)
    lw x30, 0(x30)
    
    lw x31, 0(sp)
    lw x30, 4(sp)
    addi sp, sp, 16
    ret
    
####################################################################
##
## Global full checkpoint function
##
####################################################################
    .global checkpoint
    .type checkpoint, @function
checkpoint:
    # Allocate the stack and save our working registers
    addi x2, x2, -16
    sw x31, 0(x2)           # Holds our table address
    sw x30, 4(x2)           # Working register
    
    lui x31, %hi(APTR)
    addi x31, x31, %lo(APTR)
    lw x31, 0(x31)
    
    # Save all the registers
    sw x1, 4(x31)       # ra
    addi x30, x2, 16
    sw x30, 8(x31)       # sp + 16
    sw x3, 12(x31)
    sw x4, 16(x31)
    sw x5, 20(x31)
    sw x6, 24(x31)
    sw x7, 28(x31)
    sw x8, 32(x31)      # s0
    sw x9, 36(x31)
    sw x10, 40(x31)     # a0
    sw x11, 44(x31)     # a1
    sw x12, 48(x31)     # a2
    sw x13, 52(x31)     # a3
    sw x14, 56(x31)     # a4
    sw x15, 60(x31)     # a5
    sw x16, 64(x31)     # a6
    sw x17, 68(x31)     # a7
    sw x18, 72(x31)
    sw x19, 76(x31)
    sw x20, 80(x31)
    sw x21, 84(x31)
    sw x22, 88(x31)
    sw x23, 92(x31)
    sw x24, 96(x31)
    sw x25, 100(x31)
    sw x26, 104(x31)
    sw x27, 108(x31)
    sw x28, 112(x31)
    sw x29, 116(x31)
    
    # Save x30 and x31
    lw x30, 0(x2)
    sw x30, 124(x31)        # x31
    lw x30, 4(x2)
    sw x30, 120(x31)        # x30
    
    # Swap the checkpoint tables
    lui x30, %hi(PTR_BASE)
    addi x30, x30, %lo(PTR_BASE)
    lw x31, 0(x30)
    sw x31, 8(x30)                      # TMP = APTR
    lw x31, 4(x30)
    sw x31, 0(x30)                      # APTR = IPTR
    lw x31, 8(x30)
    sw x31, 4(x30)                      # IPTR = TMP
    
    # Restore x29, x30, and x31, and restore the stack
    lw x31, 0(x2)
    lw x30, 4(x2)
    addi x2, x2, 16
    
    # Count the checkpoint
    .word 0x2000000b
    
    # Return
    jalr zero, 0(ra)
    
