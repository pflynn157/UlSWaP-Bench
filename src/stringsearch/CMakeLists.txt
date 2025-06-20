target_sources(stringsearch PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c)

target_link_libraries(stringsearch c)

if (USE_ASCC)
    target_compile_options(stringsearch PRIVATE
        "-opt ignore,checkpoint,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
        "--unroll 16"
        "--verbose"
        "--ignore-function init_search"
        "--ignore-function strsearch"
        "--mem-setup-function benchmark_main"
    )
endif()

