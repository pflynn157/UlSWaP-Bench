target_sources(lzfx_decomp PRIVATE ${CMAKE_CURRENT_LIST_DIR}/lzfx_decomp_test.c
                                       ${CMAKE_CURRENT_LIST_DIR}/lzfx.c)

target_link_libraries(lzfx_decomp c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(lzfx_decomp PRIVATE
            "-opt checkpoint,simple-flat,outer-loop,idempotent,simple-call,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
            "--unroll 4096"
            "--verbose"
            "--mem-setup-function benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(lzfx_decomp PRIVATE
            "-opt ignore,checkpoint,span,outer-loop,simple-call,mem-loop-unroll,arm-checkpoint"
            "--unroll 1024"
            "--span 100"
            "--verbose"
        )
    endif()
endif()

