#********************************************************************
# packages.mk for rocket-chip
#********************************************************************

ifneq (1,$(RULES))
package_deps = rocket-chip
chiselscripts_deps=
chiselscripts_clean_deps=
rocket-chip_deps=chiselscripts 
rocket-chip_clean_deps=clean_chiselscripts 
else # Rules
chiselscripts : $(chiselscripts_deps)

clean_chiselscripts : $(chiselscripts_clean_deps)

rocket-chip : $(rocket-chip_deps)

clean_rocket-chip : $(rocket-chip_clean_deps)


endif

