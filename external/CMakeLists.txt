set(ESP8266_SDK_VARIANT "RTOS")
set(ESP8266_SDK_VERSION "1.3.0")

add_subdirectory(esp8266-cmake/main)
add_subdirectory(esp8266-cmake/sdk)

set(PAHO_MQTT_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/ESP-RTOS-Paho)

file(GLOB PAHO_MQTT_SRC
    ${PAHO_MQTT_SOURCE_DIR}/paho/*.c
)

add_library(paho_mqtt STATIC
    ${PAHO_MQTT_SRC}
    ${PAHO_MQTT_SOURCE_DIR}/user/dmsg.c
    ${PAHO_MQTT_SOURCE_DIR}/user/xmit.c
    ${PAHO_MQTT_SOURCE_DIR}/driver/uart.c
)

target_include_directories(paho_mqtt PUBLIC
    ${PAHO_MQTT_SOURCE_DIR}/paho
    ${PAHO_MQTT_SOURCE_DIR}/include
)

target_link_libraries(paho_mqtt PUBLIC
    user_code
)
