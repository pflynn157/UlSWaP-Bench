target_sources(sensor_fusion PRIVATE ${CMAKE_CURRENT_LIST_DIR}/main.c)

target_link_libraries(sensor_fusion c)
