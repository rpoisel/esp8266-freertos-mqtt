include(ESP8266-Deployment)

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

create_deployment_rules(firmware 0x00000.bin 0x01010.bin 0x00000 0x01010)
