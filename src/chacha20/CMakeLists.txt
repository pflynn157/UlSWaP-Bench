target_sources(chacha20 PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c)

target_link_libraries(chacha20 c)

if (USE_ASCC)
    target_compile_options(chacha20 PRIVATE
        "-opt checkpoint,simple-flat,outer-loop,simple-call,simple-loop-unroll,mem-loop-unroll,basic-checkpoint"
        "--unroll 1028"
        "--verbose"
        "--mem-setup-function benchmark_main"
    )
endif()

