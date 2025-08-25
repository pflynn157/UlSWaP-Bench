function(set_rv64sim_config)
    message(STATUS "Setting RISC-V 64 (ISA Simulator) configuration")
    
    set(CMAKE_SYSTEM_NAME Generic)
    
    set(PICOLIBC_ROOT ${SYSROOT}/picolibc/picolibc/rv64im)
    set(GCC1 /usr/lib/gcc/riscv64-unknown-elf/13.2.0/rv64im/lp64)
    set(GCC2 /usr/lib/gcc/riscv64-unknown-elf/10.2.0/rv64im/lp64)
    
    set(ARCH_LINK_DIRS "${PICOLIBC_ROOT}/lib;${GCC1};${GCC2}" PARENT_SCOPE)
    set(ARCH_INC_DIRS "${PICOLIBC_ROOT}/include" PARENT_SCOPE)
    
    set(RV64_FLAGS "-nostdlib;-ffreestanding;-march=rv64im;-mabi=lp64;-O2")
    set(ARCH_FLAGS "${RV64_FLAGS}" PARENT_SCOPE)
    set(ARCH_LINK_FLAGS "-Wl,-m,elf64lriscv;${RV32FLAGS};-T${ARCH_DIR}/memmap.ld;-nostartfiles;-nostdlib" PARENT_SCOPE)
    set(ARCH_LIBS "-lgcc" PARENT_SCOPE)
    
    set(ARCH_SOURCES "${ARCH_DIR}/boot.s;${ARCH_DIR}/supportFuncs.c" PARENT_SCOPE)
    
    set(CMAKE_C_COMPILER riscv64-unknown-elf-gcc PARENT_SCOPE)
    set(CMAKE_ASM_COMPILER riscv64-unknown-elf-gcc PARENT_SCOPE)
    set(ARCH_OBJDUMP riscv64-unknown-elf-objdump PARENT_SCOPE)
    
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/hex)
    set(ARCH_POST_COMMAND riscv64-unknown-elf-objcopy ${PROJECT_BINARY_DIR}/bin/__BENCHMARK__.elf ${PROJECT_BINARY_DIR}/hex/__BENCHMARK__.bin -O binary PARENT_SCOPE)
    
endfunction()

