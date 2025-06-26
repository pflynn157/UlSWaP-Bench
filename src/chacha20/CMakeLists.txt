target_sources(chacha20 PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c)

target_link_libraries(chacha20 c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(chacha20 PRIVATE
            "-opt" "checkpoint,simple-flat,outer-loop,simple-call,simple-loop-unroll,mem-loop-unroll,basic-checkpoint"
            "--unroll" "1028"
            "--verbose"
            "--mem-setup-function" "benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(chacha20 PRIVATE
            "-opt" "ignore,checkpoint,span,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "--unroll" "1024"
            "--span" "100"
            "--verbose"
        )
    endif()
endif()

