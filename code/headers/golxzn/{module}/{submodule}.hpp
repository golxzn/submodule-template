#pragma once

#include <string>

namespace golxzn::{module} {

std::string get_module_name() noexcept;
std::string get_submodule_name() noexcept;
std::string get_full_name() noexcept;

} // namespace golxzn::{module}

namespace gxzn = golxzn;
