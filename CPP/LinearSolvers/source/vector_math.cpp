#include "vector_math.h"
#include <vector>
#include <iostream>
#include <sstream>
#include <iomanip>

std::vector<double> vector_math::add(
    const std::vector<double>& a,
    const std::vector<double>& b)
{
    int n = a.size();
    std::vector<double> result(n);
    for (int i = 0; i < n; i++) {
        result[i] = a[i] + b[i];
    }
    return result;
}

std::vector<double> vector_math::subtract(
    const std::vector<double>& a,
    const std::vector<double>& b)
{
    int n = a.size();
    std::vector<double> result(n);
    for (int i = 0; i < n; i++) {
        result[i] = a[i] - b[i];
    }
    return result;
}

std::vector<double> vector_math::scalar_multiply(
    const double c,
    const std::vector<double>& a)
{
    int n = a.size();
    std::vector<double> result(n);
    for (int i = 0; i < n; i++) {
        result[i] = c*a[i];
    }
    return result;
}

double vector_math::dot(
    const std::vector<double>& a,
    const std::vector<double>& b)
{
    int n = a.size();
    double result = 0;
    for (int i = 0; i < n; i++) {
        result += a[i]*b[i];
    }
    return result;
}

std::string vector_math::str(
        const std::vector<double>& a,
        const std::string array_label)
{
    int n = a.size();
    std::ostringstream result;
    for (int i = 0; i < n; i++) {
        result << array_label << "[" << i << "] = " << std::setprecision(20) << a[i] << std::endl;
    }
    return result.str();
}
