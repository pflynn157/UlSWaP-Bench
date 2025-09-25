target_sources(susan_corners PRIVATE ${CMAKE_CURRENT_LIST_DIR}/susan.c)

target_compile_options(susan_corners PRIVATE -Wno-array-bounds)

target_link_libraries(susan_corners c m)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(susan_corners PRIVATE
            "-opt" "checkpoint,riscv-ra,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,basic-checkpoint"
            "--unroll" "128"
            "--verbose"
            "--mem-setup-function" "benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(susan_corners PRIVATE
            "-opt" "ignore,checkpoint,span,outer-loop,simple-call,mem-loop-unroll,arm-checkpoint"
            "--unroll" "1024"
            "--span" "50"
            "--verbose"
        )
    endif()
endif()

