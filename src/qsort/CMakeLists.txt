target_sources(qsort PRIVATE ${CMAKE_CURRENT_LIST_DIR}/qsort.c)

target_link_libraries(qsort c m)

if (USE_ASCC)
    target_compile_options(qsort PRIVATE 
        "-opt ignore,checkpoint,span,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
        "--mem-setup-function benchmark_main"
        "--unroll 128"
        "--verbose"
    )
endif()

