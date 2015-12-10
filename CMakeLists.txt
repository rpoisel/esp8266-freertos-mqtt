project("ESP8266-FreeRTOS-MQTT" C)
cmake_minimum_required(VERSION 3.0)

add_subdirectory(external)
add_subdirectory(driver_lib)

add_subdirectory(user)

