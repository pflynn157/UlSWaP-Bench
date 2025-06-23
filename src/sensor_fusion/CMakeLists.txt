target_sources(sensor_fusion PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c)

target_link_libraries(sensor_fusion c)

if (USE_ASCC)
    target_compile_options(sensor_fusion PRIVATE 
        "-opt ignore,checkpoint,span,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
        "--mem-setup-function benchmark_main"
        "--unroll 128"
        "--verbose"
    )
endif()

