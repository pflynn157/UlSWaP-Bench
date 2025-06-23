target_sources(sensor_fusion PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c)

target_link_libraries(sensor_fusion c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(sensor_fusion PRIVATE 
            "-opt ignore,checkpoint,span,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
            "--mem-setup-function benchmark_main"
            "--unroll 128"
            "--verbose"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(sensor_fusion PRIVATE 
            "-opt ignore,checkpoint,span,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "--mem-setup-function benchmark_main"
            "--ignore-function c6h6_model_predict"
            "--unroll 128"
            "--verbose"
        )
    endif()
endif()

