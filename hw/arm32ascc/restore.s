    .text
    
    .extern CHECKPOINT_TABLE1
    .extern CHECKPOINT_TABLE2

.global restore
restore:
    ldr r0, =CHECKPOINT_TABLE1
    ldr r1, [r0]
    cmp r1, #0
    beq rs_T2
    b cont
rs_T2:
    ldr r0, =CHECKPOINT_TABLE2
    ldr r1, [r0]
    cmp r1, #0
    beq end
    b cont
end:
    mov r0, #0
    bx lr
cont:
    @ r0 = Memory register
    ldr r1, [r0, #60]       @ Load LR
    mov lr, r1
    ldr r1, [r0, #56]       @ Load SP
    mov sp, r1
    ldr r1, [r0, #52]       @ r12
    mov r12, r1
    ldr r1, [r0, #48]       @ r11
    mov r11, r1
    ldr r1, [r0, #44]       @ r10
    mov r10, r1
    ldr r1, [r0, #40]       @ r9
    mov r9, r1
    ldr r1, [r0, #36]       @ r8
    mov r8, r1
    
    ldr r7, [r0, #32]
    ldr r6, [r0, #28]
    ldr r5, [r0, #24]
    ldr r4, [r0, #20]
    ldr r3, [r0, #16]
    ldr r2, [r0, #12]
    ldr r1, [r0, #8]
    ldr r0, [r0, #4]
    
    bx lr
    
