target_sources(stringsearch PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c)

target_link_libraries(stringsearch c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(stringsearch PRIVATE
            "-opt" "ignore,checkpoint,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
            "--unroll" "1000"
            "--verbose"
            "SHELL:--ignore-function init_search"
            "SHELL:--ignore-function strsearch"
            "--mem-setup-function" "benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(stringsearch PRIVATE
            "-opt" "ignore,checkpoint,simple-call,outer-loop,simple-loop-unroll,arm-checkpoint"
            "--verbose"
            "--unroll" "64"
            "SHELL:--ignore-function init_search"
            "SHELL:--ignore-function strsearch"
        )
    endif()
endif()

