#include "include/table.h"

#include <cmath>

const std::map<std::string, double> symbol_table = {
  { "pi", 3.14159265358979323846264338327950288419716939937510 },
  { "e", 2.71828182845904523536028747135266249775724709369995 },
};

#define WRAP_U(func_name) ([](double x) { return (func_name) (x); })

const std::map<std::string, std::function<double(double)>> ufunc_table = {
  { "exp", WRAP_U(std::exp) },
  { "ln", WRAP_U(std::log) },
  { "lg", WRAP_U(std::log10) },
  { "sqrt", WRAP_U(std::sqrt) },
  { "sin", WRAP_U(std::sin) },
  { "cos", WRAP_U(std::cos) },
  { "tan", WRAP_U(std::tan) },
  { "csc", [](double x) { return 1 / std::sin(x); } },
  { "sec", [](double x) { return 1 / std::cos(x); } },
  { "cot", [](double x) { return 1 / std::tan(x); } },
  { "asin", WRAP_U(std::asin) },
  { "acos", WRAP_U(std::acos) },
  { "atan", WRAP_U(std::atan) },
  { "sinh", WRAP_U(std::sinh) },
  { "cosh", WRAP_U(std::cosh) },
  { "tanh", WRAP_U(std::tanh) },
  { "asinh", WRAP_U(std::asinh) },
  { "acosh", WRAP_U(std::acosh) },
  { "atanh", WRAP_U(std::atanh) },
};

#define WRAP_B(func_name) ([](double x, double y) { return (func_name) (x, y); })

const std::map<std::string, std::function<double(double, double)>> bfunc_table = {
  { "max", WRAP_B(std::max) },
  { "min", WRAP_B(std::min) },
  { "log", [](double x, double y) { return std::log(x) / std::log(y); } },
};
