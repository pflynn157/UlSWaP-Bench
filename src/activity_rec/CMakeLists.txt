target_sources(activity_rec PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c)

target_link_libraries(activity_rec c m)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(activity_rec PRIVATE
            "-opt ignore,checkpoint,simple-flat,idempotent,outer-loop,simple-call,mem-loop-unroll,basic-checkpoint"
            "--unroll 512"
            "--ignore-function record_stats"
            "--ignore-function featurize"
            "--verbose"
            "--mem-setup-function benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(activity_rec PRIVATE
            "-opt ignore,checkpoint,outer-loop,simple-call,mem-loop-unroll,arm-checkpoint"
            "--ignore-function record_stats"
            "--unroll 512"
            "--verbose"
        )
    endif()
endif()
