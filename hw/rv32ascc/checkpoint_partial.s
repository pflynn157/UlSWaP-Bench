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
    lui x31, %hi(APTR)
    addi x31, x31, %lo(APTR)
    lw x31, 0(x31)
    #.word 0x3100000b
    jalr zero, 0(ra)

checkpoint_final:
    #.word 0x3200000b
    # Save the next PC and the SP
    addi x30, x2, 16
    sw x30, 8(x31)       # sp + 16
    sw x1, 4(x31)
    
    # Save x29, x30, and x31
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
    #.word 0x3000000b
    
    # Return
    jalr zero, 0(ra)

