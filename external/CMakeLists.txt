set(PAHO_MQTT_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/ESP-RTOS-Paho)

add_library(PAHO_MQTT_HDR INTERFACE)
set_property(TARGET PAHO_MQTT_HDR
    PROPERTY INTERFACE_INCLUDE_DIRECTORIES
    ${PAHO_MQTT_SOURCE_DIR}/paho
    ${PAHO_MQTT_SOURCE_DIR}/include
    )

add_library(paho_mqtt STATIC
    ${PAHO_MQTT_SOURCE_DIR}/paho/MQTTClient.c
    ${PAHO_MQTT_SOURCE_DIR}/paho/MQTTConnectClient.c
    ${PAHO_MQTT_SOURCE_DIR}/paho/MQTTDeserializePublish.c
    ${PAHO_MQTT_SOURCE_DIR}/paho/MQTTESP8266.c
    ${PAHO_MQTT_SOURCE_DIR}/paho/MQTTPacket.c
    ${PAHO_MQTT_SOURCE_DIR}/paho/MQTTSerializePublish.c
    ${PAHO_MQTT_SOURCE_DIR}/paho/MQTTSubscribeClient.c
    ${PAHO_MQTT_SOURCE_DIR}/paho/MQTTUnsubscribeClient.c
    ${PAHO_MQTT_SOURCE_DIR}/user/dmsg.c
    ${PAHO_MQTT_SOURCE_DIR}/user/xmit.c
    ${PAHO_MQTT_SOURCE_DIR}/driver/uart.c
)

target_include_directories(paho_mqtt PRIVATE
    $<TARGET_PROPERTY:ESP8266_SDK_HDR,INTERFACE_INCLUDE_DIRECTORIES>
    $<TARGET_PROPERTY:PAHO_MQTT_HDR,INTERFACE_INCLUDE_DIRECTORIES>
    )

