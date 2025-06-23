target_sources(adpcm_encode PRIVATE ${CMAKE_CURRENT_LIST_DIR}/adpcm_encode_test.c
                                    ${CMAKE_CURRENT_LIST_DIR}/adpcm-lib.c)

if(NOT CMAKE_C_COMPILER MATCHES "clang")
    target_compile_options(adpcm_encode PRIVATE -Wno-stringop-truncation)
endif()

target_link_libraries(adpcm_encode c m)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(adpcm_encode PRIVATE
            "-opt ignore,checkpoint,simple-flat,simple-call,outer-loop,simple-loop-unroll,live-checkpoint"
            "--verbose"
            "--unroll 1024"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(adpcm_encode PRIVATE
            "-opt ignore,checkpoint,simple-call,outer-loop,mem-loop-unroll,arm-checkpoint"
            "--unroll 1024"
            "--verbose"
        )
    endif()
endif()

