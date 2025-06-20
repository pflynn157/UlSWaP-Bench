target_sources(susan_edges PRIVATE ${CMAKE_CURRENT_LIST_DIR}/susan.c)

target_compile_options(susan_edges PRIVATE -Wno-array-bounds)

target_link_libraries(susan_edges c m)

if (USE_ASCC)
    target_compile_options(susan_edges PRIVATE
        "-opt checkpoint,simple-flat,outer-loop,simple-call,idempotent,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
        "--unroll 64"
        "--verbose"
        "--mem-setup-function benchmark_main"
    )
endif()

