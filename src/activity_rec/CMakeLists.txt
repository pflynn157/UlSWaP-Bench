target_sources(activity_rec PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c)

target_link_libraries(activity_rec c m)

if (USE_ASCC)
    target_compile_options(activity_rec PRIVATE
        "-opt ignore,checkpoint,simple-flat,idempotent,outer-loop,simple-call,mem-loop-unroll,basic-checkpoint"
        "--unroll 512"
        "--ignore-function record_stats"
       "--ignore-function featurize"
       "--verbose"
       "--mem-setup-function benchmark_main"
    )
endif()
