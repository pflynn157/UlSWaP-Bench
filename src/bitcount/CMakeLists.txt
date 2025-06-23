target_sources(bitcount PRIVATE ${CMAKE_CURRENT_LIST_DIR}/bitcnt_1.c
                                ${CMAKE_CURRENT_LIST_DIR}/bitcnt_2.c
                                ${CMAKE_CURRENT_LIST_DIR}/bitcnt_3.c
                                ${CMAKE_CURRENT_LIST_DIR}/bitcnt_4.c
                                ${CMAKE_CURRENT_LIST_DIR}/main.c)

target_link_libraries(bitcount c)

if (USE_ASCC)
    target_compile_options(bitcount PRIVATE 
        "-opt ignore,checkpoint,span,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
        "--mem-setup-function benchmark_main"
        "--unroll 4096"
        "--span 100"
        "--verbose"
    )
endif()

