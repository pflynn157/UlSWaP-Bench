    .text
    
    .extern CHECKPOINT_TABLE1
    .extern CHECKPOINT_TABLE2
    
@@
@@ We need these arguments:
@@ r0 = max
@@ r1 = table
@@
.global checkpoint_unroll_init
.type   checkpoint_unroll_init, %function
checkpoint_unroll_init:
    ldr r1, =CHECKPOINT_UNROLL
    str r0, [r1, #4]
    mov r0, #0
    str r0, [r1, #0]
    bx lr
    
.thumb_func
.global checkpoint_maybe
.type   checkpoint_maybe, %function
checkpoint_maybe:
    bkpt #3
    push {r0, r1, r2}
    ldr r0, =CHECKPOINT_UNROLL
    ldr r1, [r0, #0]                @ i
    ldr r2, [r0, #4]                @ max
    cmp r1, r2
    blt cm_next
    mov r1, #0
    str r1, [r0, #0]                @ i = 0
    mov r1, lr
    str r1, [r0, #8]                @ store LR
    pop {r0, r1, r2}
    bl checkpoint
    push {r0}
    ldr r0, =CHECKPOINT_UNROLL
    ldr r0, [r0, #8]
    mov lr, r0
    pop {r0}
    bkpt #4
    bx lr
cm_next:
    add r1, #1
    str r1, [r0, #0]                @ i += 1
    pop {r0, r1, r2}
    bx lr
    
.global checkpoint_lo_maybe
.type   checkpoint_lo_maybe, %function
checkpoint_lo_maybe:
    bkpt #5
    push {r0, r1, r2}
    ldr r0, =CHECKPOINT_UNROLL
    ldr r1, [r0, #0]                @ i
    ldr r2, [r0, #4]                @ max
    cmp r1, r2
    blt cm_next_lo
    mov r1, #0
    str r1, [r0, #0]                @ i = 0
    mov r1, lr
    str r1, [r0, #8]                @ store LR
    pop {r0, r1, r2}
    bl checkpoint_lo
    push {r0}
    ldr r0, =CHECKPOINT_UNROLL
    ldr r0, [r0, #8]
    mov lr, r0
    pop {r0}
    bkpt #6
    bx lr
cm_next_lo:
    add r1, #1
    str r1, [r0, #0]                @ i += 1
    pop {r0, r1, r2}
    bx lr
    
####################################################################
##
## Global full checkpoint function
##
####################################################################
    .global checkpoint
    .type checkpoint, %function
checkpoint:
    push {r0, r1, r2, r3, r4, r5, r6, r7, lr}
    push {r0, r1}
    
    @ Reset the timer
    @ldr r0, =0xE000E010
    @ldr r1, [r0, #8]
    @mov r2, #0x2
    @orr r1, r2
    @str r1, [r0, #8]
    
    ldr r0, =CHECKPOINT_TABLE1
    ldr r1, [r0]
    cmp r1, #0
    bne ck_set_T2
ck_set_T1:
    mov r1, #2
    b ck_cont
ck_set_T2:
    mov r1, #1
    ldr r0, =CHECKPOINT_TABLE2
ck_cont:
    @ Invalidate the table
    push {r1}
    mov r1, #0
    str r1, [r0]
    pop {r1}
    
    @ Save the lower registers
    str r2, [r0, #12]
    str r3, [r0, #16]
    str r4, [r0, #20]
    str r5, [r0, #24]
    str r6, [r0, #28]
    str r7, [r0, #32]
    pop {r2}
    str r2, [r0, #4]        @ Save r0
    pop {r2}
    str r2, [r0, #8]        @ Save r1
    
    @ Save the upper registers
    @ Don't touch r0 or r1
    mov r2, r8
    str r2, [r0, #36]       @ Save r8
    mov r2, r9
    str r2, [r0, #40]       @ Save r9
    mov r2, r10
    str r2, [r0, #44]       @ Save r10
    mov r2, r11
    str r2, [r0, #48]       @ Save r11
    mov r2, r12
    str r2, [r0, #52]       @ Save r12
    mov r2, sp
    add r2, #36
    str r2, [r0, #56]       @ Save r13 (sp-36)
    mov r2, lr
    str r2, [r0, #60]       @ Save r14 (LR)
    mov r2, pc
    str r2, [r0, #64]       @ Save pc
    
    @ Now validate the proper tables
    cmp r1, #1
    beq ck_z1
    cmp r1, #2
    beq ck_z2
    b ck_done
ck_z1:
    ldr r2, =CHECKPOINT_TABLE1
    mov r1, #0
    str r1, [r2]
    b ck_done
ck_z2:
    ldr r2, =CHECKPOINT_TABLE2
    mov r1, #0
    str r1, [r2]
ck_done:
    
    mov r1, #1
    str r1, [r0]
    
    @ Reset everything and leave
    bkpt #1
    bkpt #7
    pop {r0, r1, r2, r3, r4, r5, r6, r7, pc}   
    
    
####################################################################
##
## Checkpoints the low registers
##
####################################################################
    .global checkpoint_lo
    .type checkpoint_lo, %function
checkpoint_lo:
    push {r0, r1, r2, r3, r4, r5, r6, r7, lr}
    push {r0, r1}
    
    @ Reset the timer
    @ldr r0, =0xE000E010
    @ldr r1, [r0, #8]
    @mov r2, #0x2
    @orr r1, r2
    @str r1, [r0, #8]
    
    ldr r0, =CHECKPOINT_TABLE1
    ldr r1, [r0]
    cmp r1, #0
    bne ck1_set_T2
ck1_set_T1:
    mov r1, #2
    b ck1_cont
ck1_set_T2:
    mov r1, #1
    ldr r0, =CHECKPOINT_TABLE2
ck1_cont:
    @ Invalidate the table
    push {r1}
    mov r1, #0
    str r1, [r0]
    pop {r1}
    
    @ Save the lower registers
    str r2, [r0, #12]
    str r3, [r0, #16]
    str r4, [r0, #20]
    str r5, [r0, #24]
    str r6, [r0, #28]
    str r7, [r0, #32]
    pop {r2}
    str r2, [r0, #4]        @ Save r0
    pop {r2}
    str r2, [r0, #8]        @ Save r1
    
    @ Save the upper registers
    @ Don't touch r0 or r1
    mov r2, sp
    add r2, #36
    str r2, [r0, #56]       @ Save r13 (sp-36)
    mov r2, lr
    str r2, [r0, #60]       @ Save r14 (LR - 12)
    
    @ Now validate the proper tables
    cmp r1, #1
    beq ck1_z1
    cmp r1, #2
    beq ck1_z2
    b ck1_done
ck1_z1:
    ldr r2, =CHECKPOINT_TABLE1
    mov r1, #0
    str r1, [r2]
    b ck1_done
ck1_z2:
    ldr r2, =CHECKPOINT_TABLE2
    mov r1, #0
    str r1, [r2]
ck1_done:
    
    mov r1, #1
    str r1, [r0]
    
    @ Reset everything and leave
    bkpt #1
    bkpt #2
    pop {r0, r1, r2, r3, r4, r5, r6, r7, pc}   
    
