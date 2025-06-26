target_sources(mp3_encode PRIVATE ${CMAKE_CURRENT_LIST_DIR}/shine_mp3.c
                                  ${CMAKE_CURRENT_LIST_DIR}/mp3_encode_test.c)

target_link_libraries(mp3_encode c m)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(mp3_encode PRIVATE
            "-opt" "ignore,checkpoint,simple-flat,simple-call,outer-loop,mem-loop-unroll,basic-checkpoint"
            "--unroll" "1028"
            "SHELL:--ignore-function count_bit.part.0"
            "SHELL:--ignore-function shine_window_filter_subband"
            "--verbose"
            "--mem-setup-function" "benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(mp3_encode PRIVATE
            "-opt" "ignore,checkpoint,simple-call,outer-loop,arm-checkpoint"
            "--ignore-function" "shine_mdct_sub"
            "--verbose"
        )
    endif()
endif()

