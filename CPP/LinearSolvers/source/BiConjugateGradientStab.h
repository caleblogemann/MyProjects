#ifndef _BICGSTAB_H_
#define _BICGSTAB_H_
#include "LinearSolver.h"

class BiConjugateGradientStab: public LinearSolver {

    public:
        BiConjugateGradient(const int t_max_iterations,
                const double t_tolerance);

        void solve(multByAFunc multByA,
            const std::vector<double>& b,
             std::vector<double>& x);
};
#endif
