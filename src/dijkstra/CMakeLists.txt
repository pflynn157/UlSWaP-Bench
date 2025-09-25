target_sources(dijkstra PRIVATE ${CMAKE_CURRENT_LIST_DIR}/dijkstra.c)

target_link_libraries(dijkstra c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(dijkstra PRIVATE
            "-opt" "ignore,checkpoint,riscv-ra,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
            "--checkpoint-printf"
            "--unroll" "128"
            "--verbose"
            "--mem-setup-function" "benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(dijkstra PRIVATE
            "-opt" "ignore,checkpoint,span,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "--verbose"
            "--unroll" "256"
            "--span" "50"
        )
    endif()
endif()

