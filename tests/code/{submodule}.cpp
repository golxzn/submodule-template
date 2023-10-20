
#include <catch2/catch_test_macros.hpp>
#include <catch2/benchmark/catch_benchmark.hpp>

#include <golxzn/{module}/{submodule}.hpp>

TEST_CASE("Module names test", "[test][{module}][{submodule}][names]") {
	REQUIRE(gxzn::{module}::get_module_name() == "{module}");
	REQUIRE(gxzn::{module}::get_submodule_name() == "{submodule}");
	REQUIRE(gxzn::{module}::get_full_name() == "{module}::{submodule}");
}
