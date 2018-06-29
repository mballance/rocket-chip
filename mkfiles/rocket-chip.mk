
ROCKET_CHIP_MKFILES_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
ROCKET_CHIP_DIR := $(abspath $(ROCKET_CHIP_MKFILES_DIR)/..)


ifneq (1,$(RULES))

HARDFLOAT_JAR  = $(ROCKET_CHIP_DIR)/lib/hardfloat.jar
ROCKET_CHIP_JAR  = $(ROCKET_CHIP_DIR)/lib/rocket-chip.jar
ROCKET_CHIP_MACROS_JAR  = $(ROCKET_CHIP_DIR)/lib/rocket-chip-macros.jar

else # Rules

endif

