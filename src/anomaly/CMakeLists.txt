target_sources(anomaly PRIVATE  ${CMAKE_CURRENT_LIST_DIR}/main.c
                                ${CMAKE_CURRENT_LIST_DIR}/svm.c)

target_link_libraries(anomaly c m)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(anomaly PRIVATE 
            "-opt" "ignore,checkpoint,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
            "--mem-setup-function" "benchmark_main"
            "--unroll" "4096"
            "--verbose"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(anomaly PRIVATE
            "-opt" "ignore,checkpoint,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "--mem-setup-function" "benchmark_main"
            "--unroll" "4096"
            "--verbose"
        )
    endif()
endif()

