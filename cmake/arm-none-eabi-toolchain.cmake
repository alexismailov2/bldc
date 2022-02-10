set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)

set(TOOLCHAIN_PATH "/opt/homebrew/bin" CACHE STRING "Set arm none eabi toolchain path")

set(CMAKE_PREFIX_PATH ${CMAKE_CURRENT_LIST_DIR})

## specify cross compilers and tools
set(CMAKE_C_COMPILER ${TOOLCHAIN_PATH}/arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PATH}/arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PATH}/arm-none-eabi-gcc)
set(CMAKE_AR ${TOOLCHAIN_PATH}/arm-none-eabi-ar)
set(CMAKE_OBJCOPY ${TOOLCHAIN_PATH}/arm-none-eabi-objcopy)
set(CMAKE_OBJDUMP ${TOOLCHAIN_PATH}/arm-none-eabi-objdump)
set(SIZE ${TOOLCHAIN_PATH}/arm-none-eabi-size)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)