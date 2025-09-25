target_sources(susan_edges PRIVATE ${CMAKE_CURRENT_LIST_DIR}/susan.c)

target_compile_options(susan_edges PRIVATE -Wno-array-bounds)

target_link_libraries(susan_edges c m)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(susan_edges PRIVATE
            "-opt" "checkpoint,riscv-ra,outer-loop,simple-call,idempotent,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
            "--unroll" "64"
            "--verbose"
            "--mem-setup-function" "benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(susan_edges PRIVATE
            "-opt" "ignore,checkpoint,span,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "--unroll" "512"
            "--span" "50"
            "--verbose"
        )
    endif()
endif()

