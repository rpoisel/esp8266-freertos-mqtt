INCLUDE(CMakeForceCompiler)

# Name of the target platform
SET(CMAKE_SYSTEM_NAME ESP8266)
SET(CMAKE_SYSTEM_VERSION 1)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/Modules")

# specify the cross compiler
IF(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
    SET(USER_HOME /home/rpoisel CACHE PATH "Path to the user home directory")
    SET(ESP_OPEN_SDK_BASE ${USER_HOME}/git/esp-open-sdk CACHE PATH "Path to esp-open-sdk")
    SET(ESPTOOL ${ESP_OPEN_SDK_BASE}/esptool/esptool.py CACHE PATH "Path to the directory containing esptool.py")
    SET(ESPTOOL_COM_PORT /dev/ttyUSB0 CACHE STRING "COM port to be used by esptool.py")
    SET(XTENSA_COMPILER_HOME ${ESP_OPEN_SDK_BASE}/xtensa-lx106-elf/bin CACHE PATH "Directory containing the xtensa toolchain binaries")
    SET(ESP8266_SDK_BASE ${USER_HOME}/git/ESP8266_RTOS_SDK CACHE PATH "Path to the ESP8266 SDK")
    CMAKE_FORCE_C_COMPILER(${XTENSA_COMPILER_HOME}/xtensa-lx106-elf-gcc GNU)
ELSE()
    MESSAGE(FATAL_ERROR Unsupported build platform.)
ENDIF()

SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -I${ESP8266_SDK_BASE}/include -I${ESP8266_SDK_BASE}/include/json -Os -D__ESP8266__ -std=c99 -pedantic -Wall -Wextra -Wpointer-arith -pipe -Wno-unused-parameter -Wno-unused-variable -Os -Wpointer-arith -Wundef -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals  -D__ets__ -DICACHE_FLASH -ffunction-sections -fdata-sections" CACHE STRING "Flags for the C compiler")
SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -T${ESP8266_SDK_BASE}/ld/eagle.app.v6.ld -nostdlib -Wl,--no-check-sections -u call_user_start -Wl,-static -Wl,--gc-sections" CACHE STRING "Linker flags for executables")

SET(BUILD_LINK_PREFIX "-Wl,--start-group")
SET(BUILD_LINK_SUFFIX "-Wl,--end-group")
