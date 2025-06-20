target_sources(basicmath PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c
                                 ${CMAKE_CURRENT_LIST_DIR}/cubic.c
                                 ${CMAKE_CURRENT_LIST_DIR}/isqrt.c
                                 ${CMAKE_CURRENT_LIST_DIR}/rad2deg.c)

# if (${ARCH} STREQUAL "riscv")

target_link_libraries(basicmath m c)

if (USE_ASCC)
    target_compile_options(basicmath PRIVATE
        "-opt ignore,checkpoint,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
        "--unroll 16"
        "--verbose"
        "--mem-setup-function benchmark_main"
    )
endif()
