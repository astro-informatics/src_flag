get_filename_component(Flag_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
message(STATUS "Linking to flag package in ${Flag_CMAKE_DIR}")
if(NOT TARGET flag AND EXISTS "${Flag_CMAKE_DIR}/FlagTargets.cmake")
  include("${Flag_CMAKE_DIR}/FlagTargets.cmake")
endif()

set(Flag_INCLUDE_DIRS "@ALL_INCLUDE_DIRS@")
set(Flag_LIBRARIES flag)
