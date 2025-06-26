target_sources(crc PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c
                           ${CMAKE_CURRENT_LIST_DIR}/crc.c)

target_link_libraries(crc c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(crc PRIVATE 
            "-opt" "ignore,checkpoint,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
            "--mem-setup-function" "benchmark_main"
            "--unroll" "16"
            "--verbose"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(crc PRIVATE
            "-opt" "ignore,checkpoint,span,simple-call,outer-loop,simple-loop-unroll,arm-checkpoint"
            "--verbose"
            "--unroll" "64"
            "--span" "50"
        )
    endif()
endif()

