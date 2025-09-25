target_sources(lorawan_up PRIVATE ${CMAKE_CURRENT_LIST_DIR}/aes.c
                                  ${CMAKE_CURRENT_LIST_DIR}/cmac.c
                                  ${CMAKE_CURRENT_LIST_DIR}/lw.c
                                  ${CMAKE_CURRENT_LIST_DIR}/lorawan_up_test.c)

target_link_libraries(lorawan_up c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(lorawan_up PRIVATE
            "-opt" "checkpoint,riscv-ra,idempotent,outer-loop,simple-call,mem-loop-unroll,live-checkpoint"
            "--unroll" "512"
            "--mem-setup-function" "benchmark_main"
            "--verbose"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(lorawan_up PRIVATE
            "-opt" "ignore,checkpoint,span,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "--unroll" "512"
            "--span" "50"
            "SHELL:--ignore-function xor_block"
            "SHELL:--ignore-function lw_cpy"
            "--verbose"
        )
    endif()
endif()

