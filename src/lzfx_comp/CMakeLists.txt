target_sources(lzfx_comp PRIVATE ${CMAKE_CURRENT_LIST_DIR}/lzfx_compress_test.c
                                     ${CMAKE_CURRENT_LIST_DIR}/lzfx.c)

target_link_libraries(lzfx_comp c)

if (USE_ASCC)
    target_compile_options(lzfx_comp PRIVATE
        "-opt checkpoint,simple-flat,outer-loop,simple-call,mem-loop-unroll,live-checkpoint"
        "--unroll 2048"
        "--verbose"
        "--mem-setup-function benchmark_main"
    )
endif()

