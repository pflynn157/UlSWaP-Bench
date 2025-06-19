.text
.global CHECKPOINT_REGION
CHECKPOINT_REGION:
    s_r2: .word 0
    s_r1: .word 0
    s_r0: .word 0
    s_space:
        .word 0
        .word 0
        .word 0
        .word 0
        
.global CHECKPOINT_UNROLL
CHECKPOINT_UNROLL:
    s_inc: .word 0
    s_max: .word 0
    s_lr:  .word 0
    u_space:
        .word 0
        .word 0

.global CHECKPOINT_TABLE1
CHECKPOINT_TABLE1:
    t1_valid: .word 0
    t1_r0: .word 0
    t1_r1: .word 0
    t1_r2: .word 0
    t1_r3: .word 0
    t1_r4: .word 0
    t1_r5: .word 0
    t1_r6: .word 0
    t1_r7: .word 0
    t1_r8: .word 0
    t1_r9: .word 0
    t1_r10: .word 0
    t1_r11: .word 0
    t1_r12: .word 0
    t1_r13: .word 0
    t1_r14: .word 0
    t1_r15: .word 0
    t1_space:
        .word 0
        .word 0
        .word 0
        .word 0

.global CHECKPOINT_TABLE2
CHECKPOINT_TABLE2:
    t2_valid: .word 0
    t2_r0: .word 0
    t2_r1: .word 0
    t2_r2: .word 0
    t2_r3: .word 0
    t2_r4: .word 0
    t2_r5: .word 0
    t2_r6: .word 0
    t2_r7: .word 0
    t2_r8: .word 0
    t2_r9: .word 0
    t2_r10: .word 0
    t2_r11: .word 0
    t2_r12: .word 0
    t2_r13: .word 0
    t2_r14: .word 0
    t2_r15: .word 0
    t2_space:
        .word 0
        .word 0
        .word 0
        .word 0
    
