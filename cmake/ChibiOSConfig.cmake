project(ChibiOS C CXX ASM)

set(ChibiOS_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/ChibiOS" CACHE STRING "Set ChibiOS sources path.")
set(ChibiOS_CONTRIB_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/ChibiOS-Contrib" CACHE STRING "Set ChibiOS sources path.")

set(USE_OPT                  "-O2 -ggdb -fomit-frame-pointer -falign-functions=16" CACHE STRING "Set ChibiOS compiling options.")
set(USE_COPT                 ""                                                    CACHE STRING "Set ChibiOS C specific compiling options.")
set(USE_CPPOPT               "-fno-rtti"                                           CACHE STRING "Set ChibiOS C++ specific compiling options.")
set(USE_LDOPT                ""                                                    CACHE STRING "Linker extra options here.")
set(USE_PROCESS_STACKSIZE    "0x400"                                               CACHE STRING "Stack size to be allocated to the Cortex-M process stack.")
set(USE_EXCEPTIONS_STACKSIZE "0x400"                                               CACHE STRING "Stack size to the allocated to the Cortex-M main/exceptions stack.")
set(USE_FPU                  "hard"                                                CACHE STRING "Enables the use of FPU (no, softfp, hard).")
set(USE_FPU_OPT              "-mfloat-abi=${USE_FPU} -mfpu=fpv4-sp-d16"            CACHE STRING "FPU-related options.")
set(MCU                      "cortex-m4"                                           CACHE STRING "Set mcu type.")

option(USE_LINK_GC           "Enable this if you want the linker to remove unused code and data." ON)
option(USE_LTO               "Enable this if you want link time optimizations (LTO)."             ON)
option(USE_VERBOSE_COMPILE   "Enable this if you want to see the full log while compiling."       ON)
option(USE_SMART_BUILD       "If enabled, this option makes the build process faster by not
                              compiling modules not used in the current configuration."           OFF)

set(CHIBIOS ${ChibiOS_ROOT})
set(CHIBIOS_CONTRIB ${ChibiOS_CONTRIB_ROOT})

set(CMAKE_VERBOSE_MAKEFILE ${USE_VERBOSE_COMPILE})

add_definitions(
        -DPAC5532
        -DFALSE=0
        -DTRUE=1
        -DHAL_USE_SERIAL=FALSE
        -DHAL_USE_ST=TRUE
        -DHAL_USE_PAL=TRUE
        #-DHAL_USE_PWM=FALSE
        -DCH_CFG_ST_TIMEDELTA=0 #2
)

# Licensing files.
include(${CHIBIOS}/os/license/license.cmake)
# Startup files.
#include(${CHIBIOS}/os/common/startup/ARMCMx/compilers/GCC/mk/startup_stm32f4xx.cmake)
include(${CHIBIOS}/os/common/startup/ARMCMx/compilers/GCC/mk/startup_pac55xx.cmake)
# HAL-OSAL files (optional).
include(${CHIBIOS}/os/hal/hal.cmake)
#include(${CHIBIOS}/os/hal/ports/STM32/STM32F4xx/platform.cmake)
include(${CHIBIOS}/os/hal/ports/PAC/PAC55xx/platform.cmake)
#include(${CHIBIOS}/os/hal/boards/ST_STM32F4_DISCOVERY/board.cmake)
include(${CHIBIOS}/os/hal/boards/PAC5532EVK1/board.cmake)
include(${CHIBIOS}/os/hal/osal/rt-nil/osal.cmake)
# RTOS files (optional).
include(${CHIBIOS}/os/rt/rt.cmake)
include(${CHIBIOS}/os/common/ports/ARMv7-M/compilers/GCC/mk/port.cmake)
# Auto-build files in ./source recursively.
#include(${CHIBIOS}/tools/mk/autobuild.cmake)
# Other files (optional).
#include(${CHIBIOS}/test/lib/test.cmake)
#include(${CHIBIOS}/test/rt/rt_test.cmake)
#include(${CHIBIOS}/test/oslib/oslib_test.cmake)

# List ASM with preprocessor source files here.
#set(ASMXSRC ${ALLXASMSRC})

# Inclusion directories.
#set(INCDIR ${CONFDIR} ${ALLINC} ${TESTINC})

# Define C warning options here.
set(CWARN "-Wall -Wextra -Wundef -Wstrict-prototypes")

# Define C++ warning options here.
set(CPPWARN "-Wall -Wextra -Wundef")

set(STARTUPLD "${CHIBIOS}/os/common/startup/ARMCMx/compilers/GCC/ld")
#set(LDSCRIPT "${STARTUPLD}/STM32F407xG.ld")
set(LDSCRIPT "${STARTUPLD}/PAC5532.ld")

set(BUILDDIR ${PROJECT_BINARY_DIR})
set(PROJECT ${PROJECT_NAME})

include("${CHIBIOS}/os/common/startup/ARMCMx/compilers/GCC/mk/rules.cmake")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CFLAGS} ")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} ${ASFLAGS} ")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CPPFLAGS} ")
set(CMAKE_EXE_LINKER_FLAGS ${LDFLAGS})

message(STATUS "CFLAGS=${CFLAGS}")
message(STATUS "ASFLAGS=${ASFLAGS}")
message(STATUS "CPPFLAGS=${CPPFLAGS}")
message(STATUS "LDFLAGS=${LDFLAGS}")

