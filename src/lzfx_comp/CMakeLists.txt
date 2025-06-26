target_sources(lzfx_comp PRIVATE ${CMAKE_CURRENT_LIST_DIR}/lzfx_compress_test.c
                                     ${CMAKE_CURRENT_LIST_DIR}/lzfx.c)

target_link_libraries(lzfx_comp c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(lzfx_comp PRIVATE
            "-opt" "checkpoint,simple-flat,outer-loop,simple-call,mem-loop-unroll,live-checkpoint"
            "--unroll" "2048"
            "--verbose"
            "--mem-setup-function" "benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(lzfx_comp PRIVATE
            "-opt" "ignore,checkpoint,span,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "--unroll" "1024"
            "--span" "100"
            "--verbose"
        )
    endif()
endif()

