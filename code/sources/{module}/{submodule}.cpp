#include "golxzn/{module}/{submodule}.hpp"

namespace golxzn::{module} {

std::string get_module_name() noexcept {
	return "{module}";
}
std::string get_submodule_name() noexcept {
	return "{submodule}";
}
std::string get_full_name() noexcept {
	return "{module}::{submodule}";
}

} // namespace golxzn::{module}
