target_sources(crc PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c
                           ${CMAKE_CURRENT_LIST_DIR}/crc.c)

target_link_libraries(crc c)

if (USE_ASCC)
    message(STATUS "Using ASCC")
    set(ASCC_FLAGS
    "-opt;ignore,checkpoint,simple-flat,idempotent,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,live-checkpoint;--unroll;16;--verbose"
    )
    set(ARCH_FLAGS "${ARCH_FLAGS};${ASCC_FLAGS}" PARENT_SCOPE)
endif()

