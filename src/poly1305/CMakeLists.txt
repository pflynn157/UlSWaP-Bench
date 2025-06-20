target_sources(poly1305 PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c
                                ${CMAKE_CURRENT_LIST_DIR}/poly1305.c)

target_link_libraries(poly1305 c)

if (USE_ASCC)
    target_compile_options(poly1305 PRIVATE
        "-opt checkpoint,simple-flat,outer-loop,simple-call,mem-loop-unroll,basic-checkpoint"
        "--unroll 32"
        "--verbose"
        "--mem-setup-function benchmark_main"
    )
endif()

