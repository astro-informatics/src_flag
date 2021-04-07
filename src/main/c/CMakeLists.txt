# add_library(flag STATIC flag_core.c flag_sampling.c flag_spherlaguerre.c)
add_library(flag STATIC flag_core.c flag_sampling.c flag_spherbessel.c flag_spherlaguerre.c)
target_link_libraries(flag PUBLIC ${SSHT_TARGET} GSL::gsl GSL::gslcblas)
target_include_directories(
  flag
  PUBLIC $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
         $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>
         $<INSTALL_INTERFACE:include>)
set_target_properties(flag PROPERTIES C_STANDARD 99 ARCHIVE_OUTPUT_DIRECTORY
                                                   ${PROJECT_BINARY_DIR}/lib)
configure_file(${PROJECT_SOURCE_DIR}/include/flag_version.in.h
               ${PROJECT_BINARY_DIR}/include/flag_version.h)

if(fPIC)
  set_target_properties(flag PROPERTIES POSITION_INDEPENDENT_CODE TRUE)
endif()

if(NOT SKBUILD)
  install(
    TARGETS flag
    EXPORT FlagTargets
    ARCHIVE DESTINATION lib
    PUBLIC_HEADER)

  install(
    FILES ${PROJECT_SOURCE_DIR}/include/flag.h
          ${PROJECT_SOURCE_DIR}/include/flag_core.h
          ${PROJECT_SOURCE_DIR}/include/flag_sampling.h
          ${PROJECT_SOURCE_DIR}/include/flag_spherbessel.h
          ${PROJECT_SOURCE_DIR}/include/flag_spherlaguerre.h
          ${PROJECT_SOURCE_DIR}/include/flag_types.h
    DESTINATION include/flag)
endif()
