include(ESP8266-Deployment)

link_directories(
    ${ESP8266_SDK_BASE}/lib
)

add_executable(firmware
    user_main.c
)

target_include_directories(firmware PRIVATE
    $<TARGET_PROPERTY:ESP8266_SDK,INTERFACE_INCLUDE_DIRECTORIES>
    $<TARGET_PROPERTY:DRIVER_LIB_HDR,INTERFACE_INCLUDE_DIRECTORIES>
    $<TARGET_PROPERTY:PAHO_MQTT_HDR,INTERFACE_INCLUDE_DIRECTORIES>
    )

target_link_libraries(firmware
    ${BUILD_LINK_PREFIX}
    driver_lib
    paho_mqtt
    $<TARGET_PROPERTY:ESP8266_SDK,INTERFACE_LINK_LIBRARIES>
    ${BUILD_LINK_SUFFIX}
)

create_deployment_rules(firmware)
