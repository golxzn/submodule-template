
set({prefix}_DEFINITIONS)

if({prefix}_DEFINITIONS_INIT)
	set({prefix}_DEFINITIONS ${{prefix}_DEFINITIONS_INIT})
endif()

string(TOUPPER ${CMAKE_BUILD_TYPE} upper_build_type)
if({prefix}_DEFINITIONS_${upper_build_type})
	list(APPEND {prefix}_DEFINITIONS ${{prefix}_DEFINITIONS_${upper_build_type}})
endif()
unset(upper_build_type)

if({prefix}_SYSTEM)
	string(TOUPPER ${{prefix}_SYSTEM} upper_system)
	list(APPEND {prefix}_DEFINITIONS {prefix}_SYSTEM_NAME="${{prefix}_SYSTEM}")
	list(APPEND {prefix}_DEFINITIONS {prefix}_${upper_system}=1)
endif()

unset(__me_suffixes)
