#ifndef _CONJUGATEGRADIENT_H_
#define _CONJUGATEGRADIENT_H_

#include "LinearSolver.h"

class ConjugateGradient: public LinearSolver {
    public:
        ConjugateGradient(const int t_max_iterations,
                const double t_tolerance,
                matrixMultiplyFunc t_multByA);

        void solve(const std::vector<double>& b,
             std::vector<double>& x);
};

#endif
