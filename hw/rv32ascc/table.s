.text

.global APTR
.global IPTR
.global TPTR
.global PTR_BASE
PTR_BASE:
    APTR: .word TABLE_A
    IPTR: .word TABLE_B
    TPTR: .word 0

.global CHECKPOINT_TABLE1
.global CHECKPOINT_TABLE2
CHECKPOINT_TABLE1: .word TABLE_A
CHECKPOINT_TABLE2: .word TABLE_B

.global CHECKPOINT_UNROLL
CHECKPOINT_UNROLL:
    s_inc: .word 0
    s_max: .word 0
    s_lr:  .word 0
    u_space:
        .word 0
        .word 0
    
.global TABLE_A
TABLE_A:
    t1_x0: .word 0
    t1_x1: .word 0
    t1_x2: .word 0
    t1_x3: .word 0
    t1_x4: .word 0
    t1_x5: .word 0
    t1_x6: .word 0
    t1_x7: .word 0
    t1_x8: .word 0
    t1_x9: .word 0
    t1_x10: .word 0
    t1_x11: .word 0
    t1_x12: .word 0
    t1_x13: .word 0
    t1_x14: .word 0
    t1_x15: .word 0
    t1_x16: .word 0
    t1_x17: .word 0
    t1_x18: .word 0
    t1_x19: .word 0
    t1_x20: .word 0
    t1_x21: .word 0
    t1_x22: .word 0
    t1_x23: .word 0
    t1_x24: .word 0
    t1_x25: .word 0
    t1_x26: .word 0
    t1_x27: .word 0
    t1_x28: .word 0
    t1_x29: .word 0
    t1_x30: .word 0
    t1_x31: .word 0
    t1_space:
        .word 0
        .word 0
        .word 0
        .word 0

.global TABLE_B
TABLE_B:
    t2_x0: .word 0
    t2_x1: .word 0
    t2_x2: .word 0
    t2_x3: .word 0
    t2_x4: .word 0
    t2_x5: .word 0
    t2_x6: .word 0
    t2_x7: .word 0
    t2_x8: .word 0
    t2_x9: .word 0
    t2_x10: .word 0
    t2_x11: .word 0
    t2_x12: .word 0
    t2_x13: .word 0
    t2_x14: .word 0
    t2_x15: .word 0
    t2_x16: .word 0
    t2_x17: .word 0
    t2_x18: .word 0
    t2_x19: .word 0
    t2_x20: .word 0
    t2_x21: .word 0
    t2_x22: .word 0
    t2_x23: .word 0
    t2_x24: .word 0
    t2_x25: .word 0
    t2_x26: .word 0
    t2_x27: .word 0
    t2_x28: .word 0
    t2_x29: .word 0
    t2_x30: .word 0
    t2_x31: .word 0
    t2_space:
        .word 0
        .word 0
        .word 0
        .word 0
    
