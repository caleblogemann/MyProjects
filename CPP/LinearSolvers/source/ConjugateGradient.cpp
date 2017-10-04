#include "ConjugateGradient.h"
#include "LinearSolver.h"
#include "vector_math.h"
#include <math.h>
#include <iostream>

ConjugateGradient::ConjugateGradient(const int t_max_iterations,
        const double t_tolerance,
        matrixMultiplyFunc t_multByA) : 
        LinearSolver(t_max_iterations, t_tolerance, t_multByA)
{
}

void ConjugateGradient::solve(const std::vector<double>& b,
    std::vector<double>& x)
{
    int n = b.size();

    std::vector<double> Ax = m_multByA(x);
    // residual
    std::vector<double> r = vector_math::subtract(b, Ax);

    double rsold = vector_math::dot(r,r);

    std::vector<double> p(r);
    std::vector<double> Ap;

    int iter = 0;
    while (iter < m_max_iterations)
    {
        iter++;
        Ap = m_multByA(p);
        double pAp = vector_math::dot(p, Ap);
        double alpha = rsold/pAp;

        for (int i = 0; i < n; i++) {
            x[i] = x[i] + alpha*p[i];
            r[i] = r[i] - alpha*Ap[i];
        }

        double rsnew = vector_math::dot(r, r);
        if (sqrt(rsnew) < m_tolerance){
            rsold = rsnew;
            break;
        } else {
            for (int i = 0; i < n; i++) {
                p[i] = r[i] + (rsnew/rsold)*p[i];
            }
            rsold = rsnew;
        }
    }
    if (iter == m_max_iterations){
        printf("WARNING: Conjugate Gradient did not converge in the allowed iterations.\n"
                "Max Iterations = %d\n", m_max_iterations);
    }
}
