target_sources(activity_rec PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c)

target_link_libraries(activity_rec c m)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(activity_rec PRIVATE
            "-opt" "ignore,checkpoint,riscv-ra,idempotent,outer-loop,simple-call,mem-loop-unroll,basic-checkpoint"
            "--unroll" "512"
            "SHELL:--ignore-function record_stats"
            "SHELL:--ignore-function featurize"
            "--verbose"
            "--mem-setup-function" "benchmark_main"
            #"SHELL:--ignore-function print_hexstring"
            #"SHELL:--ignore-function hexstring"
            #"SHELL:--ignore-function hexstrings"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(activity_rec PRIVATE
            "-opt" "ignore,checkpoint,outer-loop,simple-call,mem-loop-unroll,arm-checkpoint"
            "--mem-setup-function" "benchmark_main"
            "--unroll" "512"
            "--verbose"
        )
    endif()
endif()
