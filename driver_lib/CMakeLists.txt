add_library(DRIVER_LIB_HDR INTERFACE)
set_property(TARGET DRIVER_LIB_HDR
    PROPERTY INTERFACE_INCLUDE_DIRECTORIES
    ${CMAKE_CURRENT_LIST_DIR}/include
    )

add_library(driver_lib STATIC
    driver/gpio.c
    driver/hw_timer.c
)

target_include_directories(driver_lib PRIVATE
    $<TARGET_PROPERTY:ESP8266_SDK,INTERFACE_INCLUDE_DIRECTORIES>
    $<TARGET_PROPERTY:DRIVER_LIB_HDR,INTERFACE_INCLUDE_DIRECTORIES>
    )

