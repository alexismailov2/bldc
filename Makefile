##############################################################################
# Build global options
# NOTE: Can be overridden externally.
#

USE_LISPBM=1
CONFDIR=ChibiOSConfig/STM32
USE_LTO = no
USE_FPU = hard
USE_PROCESS_STACKSIZE = 0x800
USE_EXCEPTIONS_STACKSIZE = 0x800
USE_VERBOSE_COMPILE = yes

USE_LISPBM = 0 # TODO: Temporary turned off

# Compiler options here.
ifeq ($(USE_OPT),)
  # Original options from ChibiOS
  USE_OPT = -O2 -ggdb -fomit-frame-pointer -falign-functions=16
  # Additional options for the project
  USE_OPT += -std=gnu99 -D_GNU_SOURCE
  USE_OPT += -DBOARD_OTG_NOVBUSSENS $(build_args)
  USE_OPT += -fsingle-precision-constant -Wdouble-promotion -specs=nosys.specs
endif

# C specific options here (added to USE_OPT).
ifeq ($(USE_COPT),)
  USE_COPT = 
endif

# C++ specific options here (added to USE_OPT).
ifeq ($(USE_CPPOPT),)
  USE_CPPOPT = -fno-rtti
endif

# Enable this if you want the linker to remove unused code and data.
ifeq ($(USE_LINK_GC),)
  USE_LINK_GC = yes
endif

# Linker extra options here.
ifeq ($(USE_LDOPT),)
  USE_LDOPT = 
endif

# Enable this if you want link time optimizations (LTO).
ifeq ($(USE_LTO),)
  USE_LTO = yes
endif

# TODO: Hm wav deleted in updated ChibiOS.
# If enabled, this option allows to compile the application in THUMB mode.
#ifeq ($(USE_THUMB),)
#  USE_THUMB = yes
#endif

# Enable this if you want to see the full log while compiling.
ifeq ($(USE_VERBOSE_COMPILE),)
  USE_VERBOSE_COMPILE = no
endif

# If enabled, this option makes the build process faster by not compiling
# modules not used in the current configuration.
ifeq ($(USE_SMART_BUILD),)
  USE_SMART_BUILD = yes
endif

#
# Build global options
##############################################################################

##############################################################################
# Architecture or project specific options
#

# Stack size to be allocated to the Cortex-M process stack. This stack is
# the stack used by the main() thread.
ifeq ($(USE_PROCESS_STACKSIZE),)
  USE_PROCESS_STACKSIZE = 0x400
endif

# Stack size to the allocated to the Cortex-M main/exceptions stack. This
# stack is used for processing interrupts and exceptions.
ifeq ($(USE_EXCEPTIONS_STACKSIZE),)
  USE_EXCEPTIONS_STACKSIZE = 0x400
endif

# Enables the use of FPU (no, softfp, hard).
ifeq ($(USE_FPU),)
  USE_FPU = no
endif

# FPU-related options.
ifeq ($(USE_FPU_OPT),)
  USE_FPU_OPT = -mfloat-abi=$(USE_FPU) -mfpu=fpv4-sp-d16
endif

# TODO: Hm was deleted in new version of Chibios
# Enable this if you really want to use the STM FWLib.
#ifeq ($(USE_FWLIB),)
#  USE_FWLIB = yes
#endif

#
# Architecture or project specific options
##############################################################################

##############################################################################
# Project, target, sources and paths
#

# Define project name here
PROJECT = BLDC_4_ChibiOS

# Target settings.
MCU  = cortex-m4

# Imported source files and paths.
CHIBIOS  := ./ChibiOS
#CONFDIR  := ./ChibiOSConfig/STM32
CONFDIR  := ./ChibiOSConfig/PAC55xx
BUILDDIR := ./build
DEPDIR   := ./.dep

USE_OPT += -DPAC5532

# Licensing files.
include $(CHIBIOS)/os/license/license.mk
# Startup files.
#include $(CHIBIOS)/os/common/startup/ARMCMx/compilers/GCC/mk/startup_stm32f4xx.mk
include $(CHIBIOS)/os/common/startup/ARMCMx/compilers/GCC/mk/startup_pac55xx.mk
# HAL-OSAL files (optional).
include $(CHIBIOS)/os/hal/hal.mk
#include $(CHIBIOS)/os/hal/ports/STM32/STM32F4xx/platform.mk
include $(CHIBIOS)/os/hal/ports/PAC/PAC55xx/platform.mk
#include $(CONFDIR)/boards/default/board.mk
include $(CHIBIOS)/os/hal/boards/PAC5532EVK1/board.mk
include $(CHIBIOS)/os/hal/osal/rt-nil/osal.mk
# RTOS files (optional).
include $(CHIBIOS)/os/rt/rt.mk
include $(CHIBIOS)/os/common/ports/ARMv7-M/compilers/GCC/mk/port.mk
# Auto-build files in ./source recursively.
#include $(CHIBIOS)/tools/mk/autobuild.mk
# Other files (optional).
#include $(CHIBIOS)/test/lib/test.mk
#include $(CHIBIOS)/test/rt/rt_test.mk
#include $(CHIBIOS)/test/oslib/oslib_test.mk

# Other files
include hwconf/hwconf.mk
include applications/applications.mk
include nrf/nrf.mk
include libcanard/canard.mk
include imu/imu.mk
include lora/lora.mk
include lzo/lzo.mk
include blackmagic/blackmagic.mk

ifeq ($(USE_LISPBM),1)
  include lispBM/lispbm.mk
  USE_OPT += -DUSE_LISPBM
endif

# Define linker script file here
#LDSCRIPT= $(CHIBIOS)/os/common/startup/ARMCMx/compilers/GCC/ld/STM32F407xG.ld
LDSCRIPT= $(CHIBIOS)/os/common/startup/ARMCMx/compilers/GCC/ld/PAC5532.ld
#ld_eeprom_emu.ld

# C sources that can be compiled in ARM or THUMB mode depending on the global
# setting.
CSRC = $(ALLCSRC) \
       $(TESTSRC) \
       main.c

#CSRC = $(STARTUPSRC) \
#       $(KERNSRC) \
#       $(PORTSRC) \
#       $(OSALSRC) \
#       $(HALSRC) \
#       $(PLATFORMSRC) \
#       $(CHIBIOS)/os/hal/lib/streams/chprintf.c \
#       $(CHIBIOS)/os/various/syscalls.c \
#       board.c \
#       main.c \
#       comm_usb_serial.c \
#       irq_handlers.c \
#       buffer.c \
#       comm_usb.c \
#       crc.c \
#       digital_filter.c \
#       ledpwm.c \
#       mcpwm.c \
#       servo_dec.c \
#       utils.c \
#       servo_simple.c \
#       packet.c \
#       terminal.c \
#       conf_general.c \
#       eeprom.c \
#       commands.c \
#       timeout.c \
#       comm_can.c \
#       encoder.c \
#       flash_helper.c \
#       mc_interface.c \
#       mcpwm_foc.c \
#       gpdrive.c \
#       confgenerator.c \
#       timer.c \
#       i2c_bb.c \
#       spi_bb.c \
#       virtual_motor.c \
#       shutdown.c \
#       mempools.c \
#       worker.c \
#       bms.c \
#       events.c \
#       $(HWSRC) \
#       $(APPSRC) \
#       $(NRFSRC) \
#       $(CANARDSRC) \
#       $(IMUSRC) \
#       $(LORASRC) \
#       $(LZOSRC) \
#       $(BLACKMAGICSRC) \
#       qmlui/qmlui.c
       
ifeq ($(USE_LISPBM),1)
  CSRC += $(LISPBMSRC)
endif

# C++ sources that can be compiled in ARM or THUMB mode depending on the global
# setting.
CPPSRC = $(ALLCPPSRC)

# List ASM source files here.
ASMSRC = $(ALLASMSRC)

# List ASM with preprocessor source files here.
ASMXSRC = $(ALLXASMSRC)

# Inclusion directories.
INCDIR = $(CONFDIR) $(ALLINC) $(TESTINC)
#INCDIR = $(STARTUPINC) $(KERNINC) $(PORTINC) $(OSALINC) \
#         $(HALINC) $(PLATFORMINC) \
#         $(CHIBIOS)/os/various \
#         $(CHIBIOS)/os/hal/lib/streams \
#         mcconf \
#         appconf \
#         $(HWINC) \
#         $(APPINC) \
#         $(NRFINC) \
#         $(CANARDINC) \
#         $(IMUINC) \
#         $(LORAINC) \
#         $(LZOINC) \
#         $(BLACKMAGICINC) \
#         qmlui \
#         qmlui/hw \
#         qmlui/app

# Define C warning options here.
CWARN = -Wall -Wextra -Wundef -Wstrict-prototypes

# Define C++ warning options here.
CPPWARN = -Wall -Wextra -Wundef

ifeq ($(USE_LISPBM),1)
  INCDIR += $(LISPBMINC)
endif

# TODO: It was deleted from new version of ChibiOS
#ifdef app_custom_mkfile
#include $(app_custom_mkfile)
#endif

#
# Project, target, sources and paths
##############################################################################

# TODO: looks like this section moved with new ChibiOS
###############################################################################
## Compiler settings
##
#
#MCU  = cortex-m4
#
##TRGT = arm-elf-
##TRGT = /home/benjamin/Nextcloud/appimage/gcc-arm-none-eabi-7-2018-q2-update/bin/arm-none-eabi-
#TRGT = arm-none-eabi-
#CC   = $(TRGT)gcc
#CPPC = $(TRGT)g++
## Enable loading with g++ only if you need C++ runtime support.
## NOTE: You can use C++ even without C++ support if you are careful. C++
##       runtime support makes code size explode.
#LD   = $(TRGT)gcc
##LD   = $(TRGT)g++
#CP   = $(TRGT)objcopy
#AS   = $(TRGT)gcc -x assembler-with-cpp
#AR   = $(TRGT)ar
#OD   = $(TRGT)objdump
#SZ   = $(TRGT)size
#HEX  = $(CP) -O ihex
#BIN  = $(CP) -O binary
#
## ARM-specific options here
#AOPT =
#
## THUMB-specific options here
#TOPT = -mthumb -DTHUMB
#
## Define C warning options here
#CWARN = -Wall -Wextra -Wundef -Wstrict-prototypes -Wshadow
#
## Define C++ warning options here
#CPPWARN = -Wall -Wextra -Wundef
#
##
## Compiler settings
###############################################################################

##############################################################################
# Start of user section
#

# List all user C define here, like -D_DEBUG=1
UDEFS =

# Define ASM defines here
UADEFS =

# List all user directories here
UINCDIR =

# List the user directory to look for the libraries here
ULIBDIR =

# List all user libraries here
ULIBS = -lm

#
# End of user section
##############################################################################

##############################################################################
# Common rules
#

RULESPATH = $(CHIBIOS)/os/common/startup/ARMCMx/compilers/GCC/mk
include $(RULESPATH)/arm-none-eabi.mk
include $(RULESPATH)/rules.mk

#
# Common rules
##############################################################################

##############################################################################
# Custom rules
#

# TODO: Builtin in new ChibiOS
#ifeq ($(USE_FWLIB),yes)
#  include $(CHIBIOS)/ext/stdperiph_stm32f4/stm32lib.mk
#  CSRC += $(STM32SRC)
#  INCDIR += $(STM32INC)
#  USE_OPT += -DUSE_STDPERIPH_DRIVER
#endif

#RULESPATH = $(CHIBIOS)/os/common/ports/ARMCMx/compilers/GCC
#include $(RULESPATH)/rules.mk

build/$(PROJECT).bin: build/$(PROJECT).elf 
	$(BIN) build/$(PROJECT).elf build/$(PROJECT).bin --gap-fill 0xFF

# Program
upload: build/$(PROJECT).bin
	openocd -f board/stm32f4discovery.cfg -c "reset_config trst_only combined" -c "program build/$(PROJECT).elf verify reset exit"

upload_only:
	openocd -f board/stm32f4discovery.cfg -c "reset_config trst_only combined" -c "program build/$(PROJECT).elf verify reset exit"

clear_option_bytes:
	openocd -f board/stm32f4discovery.cfg -c "init" -c "stm32f2x unlock 0" -c "mww 0x40023C08 0x08192A3B; mww 0x40023C08 0x4C5D6E7F; mww 0x40023C14 0x0fffaaed" -c "exit"

#program with olimex arm-usb-tiny-h and jtag-swd adapter board. needs openocd>=0.9
upload-olimex: build/$(PROJECT).bin
	openocd -f interface/ftdi/olimex-arm-usb-tiny-h.cfg -f interface/ftdi/olimex-arm-jtag-swd.cfg -c "set WORKAREASIZE 0x2000" -f target/stm32f4x.cfg -c "program build/$(PROJECT).elf verify reset"

upload-pi: build/$(PROJECT).bin
	openocd -f pi_stm32.cfg -c "reset_config trst_only combined" -c "program build/$(PROJECT).elf verify reset exit"

upload-pi-remote: build/$(PROJECT).elf
	./upload_remote_pi build/$(PROJECT).elf ted 10.42.0.199 22

debug-start:
	openocd -f stm32-bv_openocd.cfg

size: build/$(PROJECT).elf
	@$(SZ) $<

#
# Custom rules
##############################################################################
