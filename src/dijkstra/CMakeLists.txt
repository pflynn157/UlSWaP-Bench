target_sources(dijkstra PRIVATE ${CMAKE_CURRENT_LIST_DIR}/dijkstra.c)

target_link_libraries(dijkstra c)

if (USE_ASCC)
    target_compile_options(dijkstra PRIVATE
        "-opt ignore,checkpoint,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
        "--checkpoint-printf"
        "--unroll 128"
        "--verbose"
        "--mem-setup-function benchmark_main"
    )
endif()

