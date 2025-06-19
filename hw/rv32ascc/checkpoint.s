    .text
    
    .extern CHECKPOINT_REGION
    .extern CHECKPOINT_REGION2
    .extern CHECKPOINT_TABLE1
    .extern CHECKPOINT_TABLE2
    
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
    sw x30, 4(x2)           # Holds the next valid table
    sw x29, 8(x2)           # Working register

    /* Check the validity bit */
    /*
     * If the bit for the first table is set, check the second table
     * T1 == 0 -> Set T1, zero T2
     * T1 == 1 && T2 == 0 -> Set T2, zero T1
     * if x30 == 1 -> Zero T1
     * if x30 == 2 -> Zero T2
     */
    lui x31, %hi(CHECKPOINT_TABLE1)
    addi x31, x31, %lo(CHECKPOINT_TABLE1)
    #add x30, zero, zero
    lw x29, 0(x31)
    bne x29, zero, ck_set_T2
ck_set_T1:
    li x30, 2
    j ck_cont
ck_set_T2:
    li x30, 1
    lui x31, %hi(CHECKPOINT_TABLE2)
    addi x31, x31, %lo(CHECKPOINT_TABLE2)
ck_cont:
    /* Set the validity bit == 0(x31) */
    /* The table should be invalid until we are completely done saving it */
    sw zero, 0(x31)
    
    # Save all the registers
    sw x1, 4(x31)       # ra
    addi x29, x2, 16
    sw x29, 8(x31)       # sp + 16
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
    
    # Save x29, x30, and x31
    lw x29, 0(x2)
    sw x29, 124(x31)        # x31
    lw x29, 4(x2)
    sw x29, 120(x31)        # x30
    lw x29, 8(x2)
    sw x29, 116(x31)        # x29
    
    # Now, we will zero out one of the checkpoint tables
    # x30 == 1 -> Zero table 1 (we're on table 2)
    # x30 == 2 -> Zero table 2 (we're on table 1)
    li x29, 1
    beq x29, x30, ck_z1
    li x29, 2
    beq x29, x30, ck_z2
    j ck_done
ck_z1:
    lui x29, %hi(CHECKPOINT_TABLE1)
    addi x29, x29, %lo(CHECKPOINT_TABLE1)
    sw zero, 0(x29)
    j ck_done
ck_z2:
    lui x29, %hi(CHECKPOINT_TABLE2)
    addi x29, x29, %lo(CHECKPOINT_TABLE2)
    sw zero, 0(x29)
ck_done:

    # Set the validity bit == 0(x31)
    li x29, 1
    sw x29, 0(x31)
    
    # Restore x29, x30, and x31, and restore the stack
    lw x31, 0(x2)
    lw x30, 4(x2)
    lw x29, 8(x2)
    addi x2, x2, 16
    
    /* Return */
    jalr zero, 0(ra)
    
