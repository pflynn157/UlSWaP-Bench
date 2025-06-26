target_sources(image_class PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c
                                  ${CMAKE_CURRENT_LIST_DIR}/tm_layers.c
                                  ${CMAKE_CURRENT_LIST_DIR}/tm_model.c
                                  ${CMAKE_CURRENT_LIST_DIR}/tm_stat.c
                                )

target_link_libraries(image_class c m)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(image_class PRIVATE 
            "-opt" "ignore,checkpoint,span,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
            "--mem-setup-function" "benchmark_main"
            "--unroll" "128"
            "--verbose"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(image_class PRIVATE 
            "-opt" "ignore,checkpoint,span,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "--mem-setup-function" "benchmark_main"
            "--unroll" "128"
            "--verbose"
        )
    endif()
endif()


