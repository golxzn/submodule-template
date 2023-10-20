
if(NOT {prefix}_DEV_MODE)
	return()
endif()

if({prefix}_BUILD_TEST)
	enable_testing()
	add_subdirectory(${{prefix}_TEST_DIR})
endif()

if({prefix}_GENERATE_DOCS)
	include(${{prefix}_ROOT}/cmake/automatics/docs.cmake)
endif()
