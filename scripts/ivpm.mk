
ROCKET_CHIP_SCRIPTS_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
ROCKET_CHIP_DIR := $(abspath $(ROCKET_CHIP_SCRIPTS_DIR)/..)
PACKAGES_DIR ?= $(ROCKET_CHIP_DIR)/packages
LIB_DIR = $(ROCKET_CHIP_DIR)/lib

# Must support dual modes: 
# - build dependencies if this project is the active one
# - rely on the upper-level makefile to resolve dependencies if we're not
-include $(PACKAGES_DIR)/packages.mk
include $(ROCKET_CHIP_DIR)/etc/ivpm.info

# include $(CHISELLIB_DIR)/src/chisellib.mk
include $(PACKAGES_DIR)/chiselscripts/mkfiles/chiselscripts.mk
include $(ROCKET_CHIP_DIR)/mkfiles/rocket_chip.mk

SV_BFMS_SRC := \
  $(wildcard $(SV_BFMS_DIR)/src/sv_bfms/axi4/*.scala) \
  $(wildcard $(SV_BFMS_DIR)/src/sv_bfms/axi4/qvip/*.scala) \
  $(wildcard $(SV_BFMS_DIR)/src/sv_bfms/generic_sram_line_en_master/*.scala) \
  $(wildcard $(SV_BFMS_DIR)/src/sv_bfms/uart/*.scala) 

RULES := 1

ifeq (true,$(PHASE2))
build : $(ROCKET_CHIP_JAR))
else
build : $(rocket-chip_deps)
	$(MAKE) -f $(ROCKET_CHIP_SCRIPTS_DIR)/ivpm.mk PHASE2=true build
endif

$(ROCKET_CHIP_JAR) : $(ROCKET_CHIP_SRC) $(ROCKET_CHIP_DEPS)
	$(Q)if test ! -d `dirname $@`; then mkdir -p `dirname $@`; fi
	$(Q)$(DO_CHISELC) 
	$(Q)touch $@

release : build
	$(Q)rm -rf $(CHISELLIB_DIR)/build
	$(Q)mkdir -p $(CHISELLIB_DIR)/build/chisellib
	$(Q)cp -r \
          $(CHISELLIB_DIR)/lib \
          $(CHISELLIB_DIR)/etc \
          $(CHISELLIB_DIR)/build/chisellib
	$(Q)cd $(CHISELLIB_DIR)/build ; \
		tar czf chisellib-$(version).tar.gz chisellib
	$(Q)rm -rf $(CHISELLIB_DIR)/build/chisellib

include $(ROCKET_CHIP_DIR)/mkfiles/rocket_chip.mk
include $(PACKAGES_DIR)/chiselscripts/mkfiles/chiselscripts.mk
-include $(PACKAGES_DIR)/packages.mk

