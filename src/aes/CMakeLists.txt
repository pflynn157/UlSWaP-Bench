target_sources(aes PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c
                           ${CMAKE_CURRENT_LIST_DIR}/aes.c)

target_compile_options(aes PRIVATE -Wno-pointer-sign)

target_link_libraries(aes c)

if (USE_ASCC)
    target_compile_options(aes PRIVATE
        "-opt ignore,checkpoint,span,simple-flat,outer-loop,simple-call,mem-loop-unroll,live-checkpoint"
        "--verbose"
        "--unroll 2500"
        "--span 150"
        "--ignore-function InvCipher"
        "--mem-setup-function benchmark_main"
    )
endif()

