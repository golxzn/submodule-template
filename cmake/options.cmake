
set(USE_FOLDERS ON)
set(CMAKE_REQUIRED_QUIET ON)

list(APPEND CMAKE_MODULE_PATH
	${{prefix}_ROOT}/cmake
	${{prefix}_ROOT}/cmake/tools
)

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
	set({prefix}_IS_TOPLEVEL_PROJECT TRUE)
else()
	set({prefix}_IS_TOPLEVEL_PROJECT FALSE)
endif()

option({prefix}_BUILD_TEST           "Build {submodule}'s tests"    ${{prefix}_IS_TOPLEVEL_PROJECT})
option({prefix}_DEV_MODE             "Developer mode"              ${{prefix}_IS_TOPLEVEL_PROJECT})
option({prefix}_GENERATE_INFO_HEADER "Generate info header"        OFF)
option({prefix}_GENERATE_DOCS        "Generate MCSS documentation" OFF)
mark_as_advanced({prefix}_DEV_MODE {prefix}_GENERATE_INFO_HEADER {prefix}_GENERATE_DOCS)

include(GetSystemInfo)

get_system_info({prefix}_SYSTEM {prefix}_ARCH)

set({prefix}_OUT ${CMAKE_BINARY_DIR})
set({prefix}_CODE_DIR ${{prefix}_ROOT}/code  CACHE PATH "Code directory")
set({prefix}_TEST_DIR ${{prefix}_ROOT}/tests CACHE PATH "Tests directory")
set({prefix}_DOCS_DIR ${{prefix}_ROOT}/docs  CACHE PATH "Documentation directory")

# App info
set({prefix}_APP_AUTHOR         "Ruslan Golovinskii")

if (NOT CMAKE_CXX_STANDARD)
	set(CMAKE_CXX_STANDARD 20)
endif()

if(CMAKE_CXX_STANDARD LESS 20)
	message(FATAL_ERROR "CMAKE_CXX_STANDARD must be at least 20")
endif()

message(STATUS "-- -- -- -- -- -- -- {submodule} configuration -- -- -- -- -- -- -- --")
message(STATUS "System:                 ${{prefix}_SYSTEM} (${{prefix}_ARCH})")
message(STATUS "C++ Standard:           ${CMAKE_CXX_STANDARD}")
message(STATUS "C Standard:             ${CMAKE_C_STANDARD}")
message(STATUS "Compiler (ID):          ${CMAKE_CXX_COMPILER_ID} (${CMAKE_CXX_COMPILER_ID})")
message(STATUS "Root directory:         ${{prefix}_ROOT}")
message(STATUS "Build directory:        ${{prefix}_OUT}")
message(STATUS "Code directory:         ${{prefix}_CODE_DIR}")
message(STATUS "Top level:              ${{prefix}_IS_TOPLEVEL_PROJECT}")

if({prefix}_DEV_MODE)
	message(STATUS "Tests:                  ${{prefix}_BUILD_TEST}")
	message(STATUS "Generate info header:   ${{prefix}_GENERATE_INFO_HEADER}")
	message(STATUS "Generate documentation: ${{prefix}_GENERATE_DOCS}")
	message(STATUS "Documentation directory:${{prefix}_DOCS_DIR}")
endif()

message(STATUS "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --")

find_program(ccache_program ccache)
if (NOT ${ccache_program} MATCHES "NOTFOUND")
	set(CMAKE_C_COMPILER_LAUNCHER ccache)
	set(CMAKE_CXX_COMPILER_LAUNCHER ccache)
endif()
