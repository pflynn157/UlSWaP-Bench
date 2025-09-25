target_sources(crc_slow PRIVATE ${CMAKE_CURRENT_LIST_DIR}/crc.c)

target_link_libraries(crc_slow c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        #target_compile_options(crc PRIVATE
        #    "-opt" "checkpoint,riscv-ra,live-checkpoint"
        #)
        target_compile_options(crc_slow PRIVATE 
            "-opt" "ignore,checkpoint,riscv-ra,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
            "--mem-setup-function" "benchmark_main"
            "--unroll" "2000"
            "--verbose"
            #"SHELL:--ignore-function print_hexstring"
            #"SHELL:--ignore-function hexstring"
            #"SHELL:--ignore-function hexstrings"
            #"SHELL:--ignore-function printf_checksum"
            #"SHELL:--ignore-function reduce_double_precision"
            #"SHELL:--ignore-function is_unsupported_modifier"
            #"SHELL:--ignore-function is_modifier"
            #"SHELL:--ignore-function add_to_checksum"
            #"SHELL:--ignore-function get_benchmark_checksum"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(crc_slow PRIVATE
            "-opt" "ignore,checkpoint,span,simple-call,outer-loop,simple-loop-unroll,arm-checkpoint"
            "--verbose"
            "--unroll" "64"
            "--span" "50"
        )
    endif()
endif()

