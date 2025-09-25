target_sources(qsort PRIVATE ${CMAKE_CURRENT_LIST_DIR}/qsort.c)

target_link_libraries(qsort c m)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(qsort PRIVATE 
            "-opt" "ignore,checkpoint,span,riscv-ra,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
            "--mem-setup-function" "benchmark_main"
            "--unroll" "128"
            "--verbose"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(qsort PRIVATE 
            "-opt" "ignore,checkpoint,span,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "--mem-setup-function" "benchmark_main"
            "--unroll" "128"
            "--verbose"
        )
    endif()
endif()

