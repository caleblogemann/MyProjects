#include <vector>
#include <string>

namespace vector_math {

    std::vector<double> add(
        const std::vector<double>& a,
        const std::vector<double>& b);

    std::vector<double> subtract(
        const std::vector<double>& a,
        const std::vector<double>& b);

    std::vector<double> scalar_multiply(
        const double c,
        const std::vector<double>& a);

    double dot(
        const std::vector<double>& a,
        const std::vector<double>& b);

    std::string str(
            const std::vector<double>& a,
            const std::string array_label);
};
