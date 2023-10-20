cmake_minimum_required(VERSION 3.25)

if ({prefix}_GENERATE_INFO_HEADER)
	include(TargetInfoHeader)
	make_target_info_header(
		TARGET golxzn_{module}_{submodule}
		OUTPUT_PATH ${{prefix}_CODE_DIR}/headers/golxzn
		FILENAME {submodule}_about
		NAMESPACE golxzn::about
		PARAMETERS
			APP_NAME "golxzn.{module}.{submodule}"
			APP_VERSION "${PROJECT_VERSION}"
			APP_DESCRIPTION "${PROJECT_DESCRIPTION}"
	)
endif()

file(GLOB_RECURSE headers RELATIVE ${{prefix}_CODE_DIR} CONFIGURE_DEPENDS "*.hpp")
file(GLOB_RECURSE sources RELATIVE ${{prefix}_CODE_DIR} CONFIGURE_DEPENDS "*.cpp")

source_group(TREE ${{prefix}_CODE_DIR}/headers FILES ${headers})
source_group(TREE ${{prefix}_CODE_DIR}/sources FILES ${sources})

add_library(golxzn_{module}_{submodule} ${headers} ${sources})
add_library(golxzn::{module}::{submodule} ALIAS golxzn_{module}_{submodule})

target_include_directories(golxzn_{module}_{submodule} PUBLIC ${{prefix}_CODE_DIR}/headers)
target_compile_definitions(golxzn_{module}_{submodule} PUBLIC ${{prefix}_DEFINITIONS})
set_target_properties(golxzn_{module}_{submodule} PROPERTIES
	FOLDER "golxzn/{module}"
)
