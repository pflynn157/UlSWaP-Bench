#include <stdio.h>
#include <stdint.h>

//__strong_reference(stdout, stdin);
//__strong_reference(stdin, stderr);

//extern int arm32_putchar(char ch, FILE *file);

static int arm32_putchar(char ch, FILE *file) {
    uint8_t *addr = (uint8_t*)0xE0000000;
    *addr = ch;
    return 0;
}


void hexstring(uint32_t d) {
    printf("%08X\r\n", d);
}

void hexstrings(uint32_t d) {
    printf("%08X ", d);
}

/*static int arm32_putchar(char ch, FILE *file) {
    (void)file;
    unsigned long result;
    asm volatile("mov r7, #1");
    asm volatile("mov r0, %1" : "=r"(result) : "r"(ch) : "r0");
    asm volatile("wfi");
    return 0;
}*/

void uart_send(uint32_t c) {
    arm32_putchar(c, NULL);
}

static FILE __stdio = FDEV_SETUP_STREAM(arm32_putchar,
                                        NULL,
                                        NULL,
                                        _FDEV_SETUP_WRITE);
FILE *const stdout = &__stdio;
FILE *const stderr = &__stdio;
FILE *const stdin  = &__stdio;

