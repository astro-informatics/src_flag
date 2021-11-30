cmake_minimum_required(VERSION 3.15)
project(
  flag
  VERSION "1.0.0"
  DESCRIPTION "Fast Fourier-Laguerre transform on the ball"
  HOMEPAGE_URL "https://github.com/astro-informatics/flag"
  LANGUAGES C)

option(tests "Enable testing" ON)
option(conan_deps "Download ssht using conan" ON)
if(NOT WIN32)
  option(fPIC "Enable position independent code" ON)
endif()

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Debug")
endif()

include(CTest)
if(conan_deps OR CONAN_EDITABLE_MODE)
  include("${PROJECT_SOURCE_DIR}/cmake/conan_dependencies.cmake")
endif()
if(EXISTS "${PROJECT_BINARY_DIR}/conan_paths.cmake")
  include("${PROJECT_BINARY_DIR}/conan_paths.cmake")
elseif(EXISTS "${PROJECT_BINARY_DIR}/FindFFTW3.cmake")
  list(APPEND CMAKE_MODULE_PATH "${PROJECT_BINARY_DIR}")
else()
  list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
endif()
find_package(ssht REQUIRED)
if(ssht_FOUND AND NOT TARGET ssht::ssht)
  message(FATAL_ERROR "NOT FOUND ${SSHT_LIBRARIES}")
endif()
find_package(FFTW3 REQUIRED)
find_library(MATH_LIBRARY m)
find_package(GSL REQUIRED)

add_subdirectory(src/main/c)
if(tests)
  enable_testing()
  include("${PROJECT_SOURCE_DIR}/cmake/fetch_cmocka.cmake")
  add_subdirectory(src/test/c)
endif()

if(NOT SKBUILD)
  include("${PROJECT_SOURCE_DIR}/cmake/exporting.cmake")
else()
  find_package(PythonExtensions REQUIRED)
  find_package(Cython REQUIRED)
  find_package(NumPy REQUIRED)
  add_subdirectory(src/main/pyflag)
endif()

# only run documentation if this is not a sub-project
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  find_package(Doxygen)
  if(DOXYGEN_FOUND)
    set(DOXYGEN_OPTIMIZE_OUTPUT_FOR_C "YES")
    set(DOXYGEN_EXTRACT_ALL "YES")
    set(DOXYGEN_FILE_PATTERNS *.h *.c)
    doxygen_add_docs(docs src/main/c src/test/c include)
  endif()
endif()
