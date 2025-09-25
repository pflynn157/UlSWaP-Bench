target_sources(basicmath PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c
                                 ${CMAKE_CURRENT_LIST_DIR}/cubic.c
                                 ${CMAKE_CURRENT_LIST_DIR}/isqrt.c
                                 ${CMAKE_CURRENT_LIST_DIR}/rad2deg.c)

# if (${ARCH} STREQUAL "riscv")

target_link_libraries(basicmath m c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(basicmath PRIVATE
            "-opt" "ignore,checkpoint,riscv-ra,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
            "--unroll" "16"
            "--verbose"
            "--mem-setup-function" "benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(basicmath PRIVATE
            "-opt" "ignore,checkpoint,span,arm-checkpoint"
            "--unroll" "128"
            "SHELL:--ignore-function SolveCubic"
            "SHELL:--ignore-function my_srand"
            "SHELL:--ignore-function my_rand"
            "--span" "50"
            "--verbose"
        )
    endif()
endif()
