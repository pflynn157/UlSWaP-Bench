    .text
    
    .extern CHECKPOINT_REGION
    .extern CHECKPOINT_REGION2
    .extern CHECKPOINT_TABLE1
    .extern CHECKPOINT_TABLE2
    
####################################################################
##
## Partial checkpoint functions
##
####################################################################
    .global checkpoint_init
    .global checkpoint_final
    
    .type checkpoint_init, @function
    .type checkpoint_final, @function
    
checkpoint_init:
    addi x2, x2, -16
    sw x31, 0(x2)
    sw x30, 4(x2)
    sw x29, 8(x2)
    lui x31, %hi(CHECKPOINT_TABLE1)
    addi x31, x31, %lo(CHECKPOINT_TABLE1)
    lw x29, 0(x31)
    bne x29, zero, cki_set_T2
cki_set_T1:
    li x30, 2
    j cki_cont
cki_set_T2:
    li x30, 1
    lui x31, %hi(CHECKPOINT_TABLE2)
    addi x31, x31, %lo(CHECKPOINT_TABLE2)
cki_cont:
    sw zero, 0(x31)
    jalr zero, 0(ra)

checkpoint_final:
    # Save the next PC
    addi x29, x2, 16
    sw x29, 8(x31)       # sp + 16
    sw x1, 4(x31)
    
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
    beq x29, x30, ckf_z1
    li x29, 2
    beq x29, x30, ckf_z2
    j ckf_done
ckf_z1:
    lui x29, %hi(CHECKPOINT_TABLE1)
    addi x29, x29, %lo(CHECKPOINT_TABLE1)
    sw zero, 0(x29)
    j ckf_done
ckf_z2:
    lui x29, %hi(CHECKPOINT_TABLE2)
    addi x29, x29, %lo(CHECKPOINT_TABLE2)
    sw zero, 0(x29)
ckf_done:

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

