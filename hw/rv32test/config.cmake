function(set_rv32test_config)
    message(STATUS "Setting RISC-V (ISA Simulator) configuration")
    
    set(CMAKE_SYSTEM_NAME Generic)
    
    set(PICOLIBC_ROOT ${SYSROOT}/picolibc/picolibc/rv32im_ascc)
    set(GCC1 /usr/lib/gcc/riscv64-unknown-elf/13.2.0/rv32im/ilp32)
    set(GCC2 /usr/lib/gcc/riscv64-unknown-elf/10.2.0/rv32im/ilp32)
    
    set(ARCH_LINK_DIRS "${PICOLIBC_ROOT}/lib;${GCC1};${GCC2}" PARENT_SCOPE)
    set(ARCH_INC_DIRS "${PICOLIBC_ROOT}/include" PARENT_SCOPE)
    
    set(RV32_FLAGS "-nostdlib;-ffreestanding;-march=rv32im;-mabi=ilp32;-O2")
    set(ARCH_FLAGS "${RV32_FLAGS};--test-mode" PARENT_SCOPE)
    set(ARCH_LINK_FLAGS "-Wl,-m,elf32lriscv;${RV32FLAGS};-T${ARCH_DIR}/memmap.ld;-nostartfiles;-nostdlib" PARENT_SCOPE)
    set(ARCH_LIBS "-lgcc" PARENT_SCOPE)
    
    set(ARCH_SOURCES "${ARCH_DIR}/boot.s;${ARCH_DIR}/supportFuncs.c" PARENT_SCOPE)
    
    set(CMAKE_C_COMPILER rv32ascc-gcc PARENT_SCOPE)
    set(CMAKE_ASM_COMPILER rv32ascc-gcc PARENT_SCOPE)
    set(ARCH_OBJDUMP riscv64-unknown-elf-objdump PARENT_SCOPE)
    
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/hex)
    set(ARCH_POST_COMMAND riscv64-unknown-elf-objcopy ${PROJECT_BINARY_DIR}/bin/__BENCHMARK__.elf ${PROJECT_BINARY_DIR}/hex/__BENCHMARK__.bin -O binary PARENT_SCOPE)
    
endfunction()

