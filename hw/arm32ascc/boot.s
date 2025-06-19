
/* vectors.s */
/*
	
The first interrupt vector position (at 0) should always point to the
startup stack top. When the reset interrupt is reached, it also loads
the stack pointer. (As far as I can say, the latter one is
unnecessary as the HW anyway reloads the SP from the 0th
vector before calling the reset handler.)

The Cortex-M stack pointer should always point to the last item in the
stack. At startup there are no items in the stack and thus the
pointer should point to the first address above the actual
memory, 0x020010000 in this case. With the original linker
script the stack pointer is set to 0x0200ffff, which actually
results in sp = 0x0200fffc (the hardware forces word-aligned
stack). After this the stack is misaligned by 4.

*/

.section .vectors, "ax"
	
;@ .cpu cortex-m0
.thumb

.word   _stacktop   /* stack top address */
.word   _start      /* 1 Reset */
.word   hang        /* 2 NMI */
.word   hang1        /* 3 HardFault */
.word   hang2        /* 4 MemManage */
.word   hang3        /* 5 BusFault */
.word   hang4        /* 6 UsageFault */
.word   hang5        /* 7 RESERVED */
.word   hang6        /* 8 RESERVED */
.word   hang7        /* 9 RESERVED*/
.word   hang8        /* 10 RESERVED */
.word   hang9        /* 11 SVCall */
.word   hang10        /* 12 Debug Monitor */
.word   hang11        /* 13 RESERVED */
.word   hang12        /* 14 PendSV */
.word   hang13        /* 15 SysTick */
@.word   wdt_interrupt        /* 15 SysTick */
.word   hang14        /* 16 External Interrupt(0) */
.word   hang15        /* 17 External Interrupt(1) */
.word   hang16        /* 18 External Interrupt(2) */
.word   hang17        /* 19 ...   */

.thumb_func
hang:   b .

.thumb_func
hang1:   b .

.thumb_func
hang2:   b .

.thumb_func
hang3:   b .

.thumb_func
hang4:   b .

.thumb_func
hang5:   b .

.thumb_func
hang6:   b .

.thumb_func
hang7:   b .

.thumb_func
hang8:   b .

.thumb_func
hang9:   b .

.thumb_func
hang10:   b .

.thumb_func
hang11:   b .

.thumb_func
hang12:   b .

.thumb_func
hang13:   b .

.thumb_func
hang14:   b .

.thumb_func
hang15:   b .

.thumb_func
hang16:   b .

.thumb_func
hang17:   b .

.text

.thumb_func
.global _start
_start:
    bl init
    bl main
    .word 0xAAFBAAFB
    
.thumb_func
.global exit
exit:
    .word 0xAAFBAAFB
    @ldr r0,=0xF0000000 ;@ halt
    @str r0,[r0]
    b exit

.thumb_func
.global _exit
_exit:
    bl exit
    
@@
@@ Watchdog timer interrupt checkpoint function
@@ This is saved to the stack:
@@ * sp - 4 = xpsr      (sp + 28)
@@ * sp - 8 = pc        (sp + 24)
@@ * sp - 12 = lr       (sp + 20)
@@ * sp - 16 = r12      (sp + 16)
@@ * sp - 20 = r3       (sp + 12)
@@ * sp - 24 = r2       (sp + 8)
@@ * sp - 28 = r1       (sp + 4)
@@ * sp - 32 = r0       (sp + 0)
@@ --> New sp -= 32
@@
@.thumb_func
@.global wdt_interrupt
@wdt_interrupt:
@    @
@    @ Get the correct table
@    @ r0 = address
@    @ r1 = table to invalidate
@    @
@    ldr r0, =CHECKPOINT_TABLE1
@    ldr r1, [r0]
@    cmp r1, #0
@    bne ck_set_T2
@ck_set_T1:
@    mov r1, #2
@    b ck_cont
@ck_set_T2:
@    mov r1, #1
@    ldr r0, =CHECKPOINT_TABLE2
@ck_cont:
@    
@    @ Invalidate the table
@    mov r1, #0
@    str r1, [r0]
@    
@    @ Save the lower registers
@    str r2, [r0, #12]
@    str r3, [r0, #16]
@    str r4, [r0, #20]
@    str r5, [r0, #24]
@    str r6, [r0, #28]
@    str r7, [r0, #32]
@    ldr r2, [sp, #0]
@    str r2, [r0, #4]        @ Save r0
@    ldr r2, [sp, #4]
@    str r2, [r0, #8]        @ Save r1
@    
@    @ Save the upper registers
@    @ Don't touch r0 or r1
@    mov r2, r8
@    str r2, [r0, #36]       @ Save r8
@    mov r2, r9
@    str r2, [r0, #40]       @ Save r9
@    mov r2, r10
@    str r2, [r0, #44]       @ Save r10
@    mov r2, r11
@    str r2, [r0, #48]       @ Save r11
@    mov r2, r12
@    str r2, [r0, #52]       @ Save r12
@    mov r2, sp
@    add r2, #32
@    str r2, [r0, #56]       @ Save r13 (sp + 32)
@    ldr r2, [sp, #24]       @ Get the PC- save this as LR
@    str r2, [r0, #60]       @ Save r14 (LR)
@    
@    @ Now validate the proper tables
@    cmp r1, #1
@    beq ck_z1
@    cmp r1, #2
@    beq ck_z2
@    b ck_done
@ck_z1:
@    ldr r2, =CHECKPOINT_TABLE1
@    mov r1, #0
@    str r1, [r2]
@    b ck_done
@ck_z2:
@    ldr r2, =CHECKPOINT_TABLE2
@    mov r1, #0
@    str r1, [r2]
@ck_done:
@    
@    mov r1, #1
@    str r1, [r0]
@    
@    @ Reset the timer
@    ldr r0, =0xE000E010
@    ldr r1, [r0, #8]
@    mov r2, #0x2
@    orr r1, r2
@    str r1, [r0, #8]
@
@    bx lr

.end

