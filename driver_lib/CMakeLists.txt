add_library(driver_lib STATIC
    driver/gpio.c
    driver/hw_timer.c
)

target_include_directories(driver_lib PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/include
)

target_link_libraries(driver_lib PUBLIC
    user_code
)
