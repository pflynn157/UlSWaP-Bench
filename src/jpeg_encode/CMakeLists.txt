target_sources(jpeg_encode PRIVATE  ${CMAKE_CURRENT_LIST_DIR}/buf.c
                                    ${CMAKE_CURRENT_LIST_DIR}/conf.c
                                    ${CMAKE_CURRENT_LIST_DIR}/enc.c
                                    ${CMAKE_CURRENT_LIST_DIR}/huff.c
                                    ${CMAKE_CURRENT_LIST_DIR}/jpeg_encode_test.c)

target_compile_options(jpeg_encode PRIVATE -Wno-shift-negative-value)

# Uncomment the following line when using a new input image in order to determine the output buffer size
# target_compile_definitions(jpeg_encode PRIVATE NEW_INPUT_IMAGE=1)

target_link_libraries(jpeg_encode c)

if (USE_ASCC)
    if (ASCC_ARCH STREQUAL "RISCV")
        target_compile_options(jpeg_encode PRIVATE
            "-opt ignore,checkpoint,simple-flat,outer-loop,simple-call,simple-loop-unroll,mem-loop-unroll,live-checkpoint"
            "--verbose"
            "--unroll 128"
            "--ignore-function jpec_buffer_write_byte"
            "--mem-setup-function benchmark_main"
        )
    elseif (ASCC_ARCH STREQUAL "ARM")
        target_compile_options(jpeg_encode PRIVATE
            "-opt ignore,checkpoint,span,arm-checkpoint"
            "--unroll 128"
            "--span 50"
            "--ignore-function jpec_enc_run"
            "--verbose"
        )
    endif()
endif()

