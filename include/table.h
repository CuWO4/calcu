#ifndef TABLE_H__
#define TABLE_H__

#include <map>
#include <string>
#include <functional>

extern const std::map<std::string, double> symbol_table;
extern const std::map<std::string, std::function<double(double)>> ufunc_table;
extern const std::map<std::string, std::function<double(double, double)>> bfunc_table;

#endif