.extern APTR
.extern IPTR
.extern TPTR

.global restore
restore:
    # See if a checkpoint has ever been taken
    # Key- TPTR will be equal to zero if there is no valid
    #      table.
    lui x31, %hi(TPTR)
    addi x31, x31, %lo(TPTR)
    lw x31, 0(x31)
    beq x31, x0, end
    lui x31, %hi(IPTR)
    addi x31, x31, %lo(IPTR)
    lw x31, 0(x31)
    j cont
end:
    jalr zero, 0(ra)
cont:
    # Restore everything
    lw x1, 4(x31)       # ra
    lw x2, 8(x31)       # sp
    lw x3, 12(x31)
    lw x4, 16(x31)
    lw x5, 20(x31)
    lw x6, 24(x31)
    lw x7, 28(x31)
    lw x8, 32(x31)      # s0
    lw x9, 36(x31)
    lw x10, 40(x31)     # a0
    lw x11, 44(x31)     # a1
    lw x12, 48(x31)     # a2
    lw x13, 52(x31)     # a3
    lw x14, 56(x31)     # a4
    lw x15, 60(x31)     # a5
    lw x16, 64(x31)     # a6
    lw x17, 68(x31)     # a7
    lw x18, 72(x31)
    lw x19, 76(x31)
    lw x20, 80(x31)
    lw x21, 84(x31)
    lw x22, 88(x31)
    lw x23, 92(x31)
    lw x24, 96(x31)
    lw x25, 100(x31)
    lw x26, 104(x31)
    lw x27, 108(x31)
    lw x28, 112(x31)        # x28
    lw x29, 116(x31)        # x29
    lw x30, 120(x31)        # x30
    lw x31, 124(x31)
    
    # Return and jump to our new PC
    jalr zero, 0(ra)
    

