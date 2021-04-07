# Exports flag so other packages can access it
export(TARGETS flag FILE "${PROJECT_BINARY_DIR}/FlagTargets.cmake")

# Avoids creating an entry in the cmake registry.
if(NOT NOEXPORT)
  export(PACKAGE flag)
endif()

# First in binary dir
set(ALL_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}")
configure_File(cmake/FlagConfig.in.cmake
  "${PROJECT_BINARY_DIR}/FlagConfig.cmake" @ONLY
)
configure_File(cmake/FlagConfigVersion.in.cmake
  "${PROJECT_BINARY_DIR}/FlagConfigVersion.cmake" @ONLY
)

# Then for installation tree
file(RELATIVE_PATH REL_INCLUDE_DIR
    "${CMAKE_INSTALL_PREFIX}/share/cmake/flag"
    "${CMAKE_INSTALL_PREFIX}/include/flag"
)
set(ALL_INCLUDE_DIRS "\${Flag_CMAKE_DIR}/${REL_INCLUDE_DIR}")
configure_file(cmake/FlagConfig.in.cmake
  "${PROJECT_BINARY_DIR}/CMakeFiles/FlagConfig.cmake" @ONLY
)

# Finally install all files
install(FILES
  "${PROJECT_BINARY_DIR}/CMakeFiles/FlagConfig.cmake"
  "${PROJECT_BINARY_DIR}/FlagConfigVersion.cmake"
    DESTINATION share/cmake/flag
    COMPONENT dev
)

install(EXPORT FlagTargets DESTINATION share/cmake/flag COMPONENT dev)
