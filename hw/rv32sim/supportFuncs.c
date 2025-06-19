#include <stdio.h>
#include <stdint.h>

#define IO_DISPLAY 0x40000000

extern void _exit();

void _interrupt_exception() {
    printf("Error: A general exception occurred.\n");
    _exit();
}

void _bus_exception() {
    printf("Error: A bus exception occurred.\n");
    _exit();
}

void _float_exception() {
    printf("Error: Floating point exception.\n");
    _exit();
}

int riscv_putchar(char ch, FILE *file) {
    (void)file;
    uint8_t *addr = (uint8_t*)IO_DISPLAY;
    *addr = ch;
    return 0;
}

static FILE __stdio = FDEV_SETUP_STREAM(riscv_putchar,
                                        NULL,
                                        NULL,
                                        _FDEV_SETUP_WRITE);
FILE *const stdout = &__stdio;
FILE *const stderr = &__stdio;
FILE *const stdin  = &__stdio;

//__strong_reference(stdout, stdin);
//__strong_reference(stdin, stderr);


void hexstring(uint32_t d) {
    printf("%08X\r\n", d);
}

void hexstrings(uint32_t d) {
    printf("%08X ", d);
}

void uart_send(uint32_t c) {
    riscv_putchar(c, NULL);
}

