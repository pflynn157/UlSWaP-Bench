/* --------------------------------------------------------------------------
   Generic MSP430X + picolibc (C only, no heap)
   Simulator-friendly memory layout: 32 KiB RAM, FLASH above RAM
   -------------------------------------------------------------------------- */

OUTPUT_ARCH(msp430)
ENTRY(_start)

MEMORY
{
  RAM     (rwx) : ORIGIN = 0x0200,  LENGTH = 0x8000    /* 32 KiB RAM */
  FLASH   (rx)  : ORIGIN = 0x8000,  LENGTH = 0xF8000   /* ~1 MB FLASH */
  VECTORS (rx) : ORIGIN = 0xFF80, LENGTH = 0x80        /* Interrupt vectors */
}

/* Peripheral symbol for assembly code (e.g., WDT) */
PROVIDE(WDTCTL = 0x015C);

SECTIONS
{
  /* --- Reset / trampoline --- */
  .rstjmp ORIGIN(FLASH) :
  {
    KEEP(*(.rstjmp))
  } > FLASH

  /* --- Code and read-only data --- */
  .text :
  {
    KEEP(*(.crt0))                    /* picolibc startup */
    *(.text .text.*)
    *(.upper.text .upper.text.*)
    *(.rodata .rodata.*)
    *(.upper.rodata .upper.rodata.*)
    KEEP(*(.init))
    KEEP(*(.fini))
    _etext = .;
  } > FLASH

  /* --- Initialized data copied from FLASH to RAM --- */
  .data : AT(_etext)
  {
    __data_start = .;
    *(.data .data.*)
    *(.upper.data .upper.data.*)
    __data_end = .;
  } > RAM
  __data_size   = SIZEOF(.data);
  __data_source = LOADADDR(.data);

  /* --- Uninitialized data (BSS) --- */
  .bss (NOLOAD) :
  {
    __bss_start = .;
    *(.bss .bss.*)
    *(.upper.bss .upper.bss.*)
    *(COMMON)
    __bss_end = .;
  } > RAM
  __bss_size = SIZEOF(.bss);

  /* --- Optional .noinit section --- */
  .noinit (NOLOAD) :
  {
    *(.noinit .noinit.*)
  } > RAM

  /* --- Stack at top of RAM --- */
  .stack (NOLOAD) :
  {
    __stack = ORIGIN(RAM) + LENGTH(RAM);
  } > RAM

  /* --- Interrupt vectors at top of FLASH --- */
  .vectors ORIGIN(VECTORS) :
  {
    KEEP(*(.vectors .vectors.*))
  } > VECTORS
}

