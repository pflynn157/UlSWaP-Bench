target_sources(lorawan_down PRIVATE ${CMAKE_CURRENT_LIST_DIR}/aes.c
                                    ${CMAKE_CURRENT_LIST_DIR}/cmac.c
                                    ${CMAKE_CURRENT_LIST_DIR}/lw.c
                                    ${CMAKE_CURRENT_LIST_DIR}/lorawan_down_test.c
                                    ${CMAKE_CURRENT_LIST_DIR}/inputs.c)

target_link_libraries(lorawan_down c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(lorawan_down PRIVATE
            "-opt" "checkpoint,simple-flat,idempotent,outer-loop,simple-call,mem-loop-unroll,live-checkpoint"
            "--unroll" "512"
            "--verbose"
            "--mem-setup-function" "benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(lorawan_down PRIVATE
            "-opt" "ignore,checkpoint,span,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "SHELL:--ignore-function xor_block"
            "SHELL:--ignore-function lw_cpy"
            "--unroll" "1024"
            "--span" "50"
            "--verbose"
        )
    endif()
endif()

