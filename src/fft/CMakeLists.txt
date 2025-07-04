target_sources(fft PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c
                           ${CMAKE_CURRENT_LIST_DIR}/fftmisc.c
                           ${CMAKE_CURRENT_LIST_DIR}/fourierf.c)

target_link_libraries(fft c m)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(fft PRIVATE
           "-opt" "ignore,checkpoint,simple-flat,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
           "--verbose"
           "--unroll" "4096"
           "SHELL:--ignore-function NumberOfBitsNeeded"
           "SHELL:--ignore-function CheckPointer"
           "SHELL:--ignore-function IsPowerOfTwo"
           "SHELL:--ignore-function ReverseBits"
           "SHELL:--ignore-function Index_to_frequency"
           "--mem-setup-function" "benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(fft PRIVATE
            "-opt" "ignore,checkpoint,span,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "SHELL:--ignore-function my_srand"
            "SHELL:--ignore-function my_rand"
            "--unroll" "512"
            "--span" "50"
            "--verbose"
        )
    endif()
endif()

