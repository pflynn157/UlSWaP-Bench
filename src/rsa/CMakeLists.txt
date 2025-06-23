target_sources(rsa PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c
                           ${CMAKE_CURRENT_LIST_DIR}/rsa_test.c
                           ${CMAKE_CURRENT_LIST_DIR}/bn.c)

target_link_libraries(rsa c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(rsa PRIVATE
            "-opt ignore,checkpoint,simple-flat,simple-loop-unroll,mem-loop-unroll,basic-checkpoint"
            "--unroll 8192"
            "--ignore-function bignum_init"
            "--ignore-function bignum_mul"
            "--ignore-function bignum_div"
            "--verbose"
            "--mem-setup-function benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(rsa PRIVATE
            "-opt ignore,checkpoint,span,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "--unroll 4096"
            "--ignore-function bignum_init"
            "--ignore-function bignum_mul"
            "--ignore-function bignum_div"
            "--span 50"
            "--verbose"
        )
    endif()
endif()

