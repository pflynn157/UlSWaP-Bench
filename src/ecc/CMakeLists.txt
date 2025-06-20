target_sources(ecc PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c
                           ${CMAKE_CURRENT_LIST_DIR}/ecdh.c)

target_compile_options(ecc PRIVATE -DECC_CURVE=NIST_B233)

target_link_libraries(ecc c)

if (USE_ASCC)
    target_compile_options(ecc PRIVATE
        "-opt ignore,checkpoint,simple-flat,simple-call,outer-loop,mem-loop-unroll,live-checkpoint"
        "--unroll 4096"
        "--ignore-function gf2point_is_zero"
        "--verbose"
        "--mem-setup-function benchmark_main"
    )
endif()

