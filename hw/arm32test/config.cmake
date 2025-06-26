function(set_arm32test_config)
    message(STATUS "Setting Arm configuration (ASCC TEST)")
    
    set(CMAKE_SYSTEM_NAME Generic)
    
    set(PICOLIBC_ROOT ${SYSROOT}/picolibc/picolibc/gcc-arm32)
    set(GCC1 /usr/lib/gcc/arm-none-eabi/13.2.1/thumb/v6-m/nofp)
    
    set(ARCH_LINK_DIRS "${PICOLIBC_ROOT}/lib;${GCC1}" PARENT_SCOPE)
    set(ARCH_INC_DIRS "${PICOLIBC_ROOT}/include" PARENT_SCOPE)
    
    set(ARM_FLAGS "-nostdlib;-ffreestanding;-mthumb;-march=armv6-m;-O2")
    set(ARCH_FLAGS "${ARM_FLAGS};--test-mode" PARENT_SCOPE)
    set(ARCH_LINK_FLAGS "${ARM_FLAGS};-T${ARCH_DIR}/memmap.ld;-nostartfiles;-nostdlib" PARENT_SCOPE)
    set(ARCH_LIBS "-lgcc" PARENT_SCOPE)
    
    set(ARCH_SOURCES "${ARCH_DIR}/boot.s;${ARCH_DIR}/supportFuncs.c" PARENT_SCOPE)
    
    set(CMAKE_C_COMPILER arm32ascc-gcc PARENT_SCOPE)
    set(CMAKE_ASM_COMPILER arm32ascc-gcc PARENT_SCOPE)
    set(ARCH_OBJDUMP arm-none-eabi-objdump PARENT_SCOPE)
    
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/hex)
    set(ARCH_POST_COMMAND arm-none-eabi-objcopy ${PROJECT_BINARY_DIR}/bin/__BENCHMARK__.elf ${PROJECT_BINARY_DIR}/hex/__BENCHMARK__.bin -O binary PARENT_SCOPE)
    
endfunction()

