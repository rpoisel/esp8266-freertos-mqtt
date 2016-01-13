file(GLOB USER_CODE_SRC
    ${CMAKE_CURRENT_LIST_DIR}/*.c
)

add_library(user_code STATIC
    ${USER_CODE_SRC}
)

target_include_directories(user_code PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}
)

target_link_libraries(user_code PUBLIC
    ESP8266_SDK
    paho_mqtt
    driver_lib
)
