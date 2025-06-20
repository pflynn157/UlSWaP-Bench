target_sources(susan_smooth PRIVATE ${CMAKE_CURRENT_LIST_DIR}/susan.c)

target_compile_options(susan_smooth PRIVATE -Wno-array-bounds)

target_link_libraries(susan_smooth c m)

if (USE_ASCC)
    target_compile_options(susan_smooth PRIVATE
        "-opt ignore,checkpoint,simple-flat,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,basic-checkpoint"
        "--unroll 128"
        "--verbose"
        "--mem-setup-function benchmark_main"
    )
endif()

