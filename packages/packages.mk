#********************************************************************
# packages.mk for rocket-chip
#********************************************************************

ifneq (1,$(RULES))
package_deps = rocket-chip
chiselscripts_deps=
rocket-chip_deps=chiselscripts 
else # Rules
chiselscripts : $(chiselscripts_deps)
	$(Q)$(MAKE) PACKAGES_DIR=$(PACKAGES_DIR) PHASE2=true -C $(PACKAGES_DIR)/chiselscripts/scripts -f ivpm.mk build

rocket-chip : $(rocket-chip_deps)


endif

