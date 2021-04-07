cmake_minimum_required(VERSION 3.12)
project(
  flag
  VERSION "0.0.1"
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

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
if(conan_deps)
  include("conan_dependencies")
  set(SSHT_TARGET CONAN_PKG::ssht)
else()
  find_package(Ssht REQUIRED)
  set(SSHT_TARGET ssht)
endif()
find_package(GSL REQUIRED)

add_subdirectory(src/main/c)
if(tests)
  enable_testing()
  include("fetch_cmocka")
  add_subdirectory(src/test/c)
endif()

if(NOT SKBUILD)
  include("exporting")
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
