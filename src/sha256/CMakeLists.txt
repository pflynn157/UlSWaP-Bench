target_sources(sha256 PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c
                              ${CMAKE_CURRENT_LIST_DIR}/sha256.c)

target_link_libraries(sha256 c)

if (USE_ASCC)
    target_compile_options(sha256 PRIVATE
        "-opt checkpoint,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,live-checkpoint"
        "--unroll 8"
        "--verbose"
    )
endif()

