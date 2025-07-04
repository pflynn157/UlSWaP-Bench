target_sources(susan_smooth PRIVATE ${CMAKE_CURRENT_LIST_DIR}/susan.c)

target_compile_options(susan_smooth PRIVATE -Wno-array-bounds)

target_link_libraries(susan_smooth c m)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(susan_smooth PRIVATE
            "-opt" "ignore,checkpoint,simple-flat,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,basic-checkpoint"
            "--unroll" "128"
            "--verbose"
            "--mem-setup-function" "benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(susan_smooth PRIVATE
            "-opt" "ignore,checkpoint,span,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "--unroll" "1028"
            "SHELL:-if fgetc2"
            "SHELL:-if getint"
            "SHELL:-if get_image"
            "SHELL:-if int_to_uint8_t"
            "SHELL:-if setup_brightness_lut"
            "SHELL:-if median"
            "--span" "50"
            "--verbose"
        )
    endif()
endif()

