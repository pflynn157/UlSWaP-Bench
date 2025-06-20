target_sources(crc PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c
                           ${CMAKE_CURRENT_LIST_DIR}/crc.c)

target_link_libraries(crc c)

if (USE_ASCC)
    message(STATUS "Using ASCC")
    target_compile_options(crc PRIVATE 
        "-opt ignore,checkpoint,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
        "--mem-setup-function benchmark_main"
        "--unroll 16"
        "--verbose"
    )
endif()

