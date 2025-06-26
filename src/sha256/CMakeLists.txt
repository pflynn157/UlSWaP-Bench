target_sources(sha256 PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c
                              ${CMAKE_CURRENT_LIST_DIR}/sha256.c)

target_link_libraries(sha256 c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(sha256 PRIVATE
            "-opt" "checkpoint,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,live-checkpoint"
            "--unroll" "8"
            "--verbose"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(sha256 PRIVATE
            "-opt" "ignore,checkpoint,span,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "--verbose"
            "--unroll" "256"
            "--span" "100"
        )
    endif()
endif()

