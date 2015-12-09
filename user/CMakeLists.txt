link_directories(
    ${ESP8266_SDK_BASE}/lib
)

add_executable(firmware
    user_main.c
)

target_include_directories(firmware PRIVATE
    $<TARGET_PROPERTY:ESP8266_SDK_HDR,INTERFACE_INCLUDE_DIRECTORIES>
    $<TARGET_PROPERTY:DRIVER_LIB_HDR,INTERFACE_INCLUDE_DIRECTORIES>
    $<TARGET_PROPERTY:PAHO_MQTT_HDR,INTERFACE_INCLUDE_DIRECTORIES>
    )

target_link_libraries(firmware
    ${BUILD_LINK_PREFIX}
    driver_lib
    paho_mqtt
    minic
    gcc
    hal
    pp
    phy
    net80211
    lwip
    wpa
    main
    crypto
    freertos
    lwip
    ${BUILD_LINK_SUFFIX}
)

SET(FW_FILE_1 ${CMAKE_CURRENT_BINARY_DIR}/0x00000.bin)
SET(FW_FILE_2 ${CMAKE_CURRENT_BINARY_DIR}/0x40000.bin)

add_custom_command(
    TARGET firmware
    POST_BUILD
    COMMAND export PATH=$ENV{PATH}:${ESP8266_XTENSA_COMPILER_HOME}
    COMMAND ${ESP8266_ESPTOOL} elf2image -o ${CMAKE_CURRENT_BINARY_DIR}/ firmware${CMAKE_EXECUTABLE_SUFFIX}
    BYPRODUCTS ${FW_FILE_1} ${FW_FILE_2}
)

add_custom_target(
    flash
    COMMAND export PATH=$ENV{PATH}:${ESP8266_XTENSA_COMPILER_HOME}
    COMMAND ${ESP8266_ESPTOOL} --port ${ESP8266_ESPTOOL_COM_PORT} write_flash 0x00000 ${FW_FILE_1} 0x40000 ${FW_FILE_2}
    DEPENDS ${FW_FILE_1} ${FW_FILE_2}
)
