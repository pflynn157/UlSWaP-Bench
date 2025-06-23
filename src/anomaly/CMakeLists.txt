target_sources(anomaly PRIVATE  ${CMAKE_CURRENT_LIST_DIR}/main.c
                                ${CMAKE_CURRENT_LIST_DIR}/svm.c)

target_link_libraries(anomaly c m)

if (USE_ASCC)
    message(STATUS "Using ASCC")
    target_compile_options(anomaly PRIVATE 
        "-opt ignore,checkpoint,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
        "--mem-setup-function benchmark_main"
        "--unroll 4096"
        "--verbose"
    )
endif()

