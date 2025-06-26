target_sources(patricia PRIVATE ${CMAKE_CURRENT_LIST_DIR}/patricia.c
                                ${CMAKE_CURRENT_LIST_DIR}/patricia_test.c)

target_compile_options(patricia PRIVATE -foptimize-sibling-calls)

target_link_libraries(patricia c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(patricia PRIVATE
            "-opt" "checkpoint,simple-flat,idempotent,outer-loop,simple-call,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
            "--unroll" "512"
            "--verbose"
            "--mem-setup-function" "benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(patricia PRIVATE
            "-opt" "ignore,checkpoint,span,outer-loop,simple-call,mem-loop-unroll,arm-checkpoint"
            "--unroll" "1024"
            "--span" "50"
            "--verbose"
        )
    endif()
endif()

