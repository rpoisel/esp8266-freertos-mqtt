project("ESP8266-FreeRTOS-MQTT" C)
cmake_minimum_required(VERSION 3.0)

add_subdirectory(external)
add_subdirectory(driver_lib)

add_subdirectory(user)

set_property(TARGET USER_CODE
    PROPERTY INTERFACE_LINK_LIBRARIES
    paho_mqtt
    driver_lib
    user_lib
)
