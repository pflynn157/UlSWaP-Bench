target_sources(aes PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c
                           ${CMAKE_CURRENT_LIST_DIR}/aes.c)

target_compile_options(aes PRIVATE -Wno-pointer-sign)

target_link_libraries(aes c)

if (USE_ASCC)
    target_compile_options(aes PRIVATE
        "-opt ignore,checkpoint,simple-flat,simple-call,outer-loop,simple-loop-unroll,mem-loop-unroll,basic-checkpoint"
        "--verbose"
        "--unroll 1024"
        "--ignore-function InvCipher"
        "--mem-setup-function benchmark_main"
    )
endif()

