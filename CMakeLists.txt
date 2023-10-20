cmake_minimum_required(VERSION 3.25)

set({prefix}_ROOT ${CMAKE_CURRENT_SOURCE_DIR})

project(golxzn.{module}.{submodule}
	VERSION 0.1.0
	DESCRIPTION "golxzn {submodule} submodule"
	LANGUAGES CXX
)

include(${{prefix}_ROOT}/cmake/options.cmake)
include(${{prefix}_ROOT}/cmake/definitions.cmake)

add_subdirectory(${{prefix}_CODE_DIR})

include(${{prefix}_ROOT}/cmake/dev-mode.cmake)
