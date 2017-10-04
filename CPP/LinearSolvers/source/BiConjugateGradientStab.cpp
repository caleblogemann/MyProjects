#include "BiConjugateGradientStab.h"
#include "LinearSolver.h"
#include "vector_math.h"
#include <math.h>
#include <iostream>

BiConjugateGradientStab::BiConjugateGradientStab(
        const int t_max_iterations,
        const double t_tolerance) 
    : LinearSolver(t_max_iterations, t_tolerance){}

void BiConjugateGradientStab::solve(multByAFunc multByA,
    const std::vector<double>& b,
    std::vector<double>& x)
{
    bool printCheck = false;
    const int n = b.size();

    std::vector Ax = new DblArray(l, m, n);
    multByA(x, Ax);

    std::vector<double> r = math::SubtractVectors(b, Ax);

    std::vector<double> rhat(r);
    double rhonew;
    double rhoold = 1;
    double alpha = 1;
    double omega = 1;
    double beta;

    DblArray* v = new DblArray(l, m, n);
    v->setall(0.0);
    DblArray* p = new DblArray(l, m, n);
    p->setall(0.0);

    DblArray* h = new DblArray(l, m, n);
    DblArray* s = new DblArray(l, m, n);
    DblArray* t = new DblArray(l, m, n);

    DblArray* res = new DblArray(l, m, n);

        int iter = 0;
        while (iter < m_max_iterations){
            iter++;
            if (printCheck){
                printf("omega = %e\n", omega);
                printf("rhonew = %e\n", rhonew);
                printf("rhoold = %e\n", rhoold);
            }
            rhonew = dog_math::dot(rhat, r);

            beta = (rhonew/rhoold)*(alpha/omega);

            if (printCheck){
                std::cout << r->str("r");
                std::cout << v->str("v");
                printf("beta = %e\n", beta);
                printf("omega = %e\n", omega);
            }
            // p  = r + beta*(p - omega*v)
            for (int i = 1; i <= l; i++) {
                for (int j = 1; j <= m; j++) {
                    for (int k = 1; k <= n; k++) {
                        p->set(i, j, k, r->get(i, j, k) + beta*(p->get(i, j, k) - omega*v->get(i, j, k)));
                    }
                }
            }

            // v = Ap
            if (printCheck){
                printf("v = Ap\n");
                std::cout << "p = q\n";
                std::cout << p->str("p");
            }
            multByA(p, v, num_stage, appData, dgParams, dgMesh, dgBasis, dgRiemann, time, smax, dt);
            if (printCheck){
                std::cout << v->str("v");
            }

            double rhatv = dog_math::dot(rhat, v);
            if (printCheck){
                std::cout << "rhatv = " << rhatv << std::endl;
                std::cout << "rhonew = " << rhonew << std::endl;
            }

            // if p == 0, then Ap = v = 0, so alpha is undefined, 
            // if p == 0, then probably exact solution is already found
            if (fabs(rhatv) > constants::EPSILON){
                alpha = rhonew/rhatv;
            } else {
                if (printCheck){
                    std::cout << "rhat dotted with v is very small\n";
                    std::cout << "rhatv = " << rhatv << std::endl;
                }
                alpha = 0.0;
            }
            if(printCheck){
                printf("alpha = %f\n", alpha);
            }
            rhoold = rhonew;

            // h = x + alpha*p
            for (int i = 1; i <= l; i++) {
                for (int j = 1; j <= m; j++) {
                    for (int k = 1; k <= n; k++) {
                        h->set(i, j, k, x->get(i, j, k) + alpha*p->get(i, j, k));
                    }
                }
            }

            // Ax = Ah
            if (printCheck) {
                std::cout << "h = q\n";
                std::cout << h->str("h");
            }
            multByA(h, Ax, num_stage, appData, dgParams, dgMesh, dgBasis, dgRiemann, time, smax, dt);
            dog_math::SubtractVectors(b, Ax, res);
            if (printCheck) {
                printf("residual = %e\n", sqrt(dog_math::dot(res,res)));
            }
            if (sqrt(dog_math::dot(res, res)) < m_tolerance){
                // copy h into x and end
                for (int i = 1; i <= l; i++) {
                    for (int j = 1; j <= m; j++) {
                        for (int k = 1; k <= n; k++) {
                            x->set(i, j, k, h->get(i, j, k));
                        }
                    }
                }
                break;
            }

            // s = r - alpha*v
            for (int i = 1; i <= l; i++) {
                for (int j = 1; j <= m; j++) {
                    for (int k = 1; k <= n; k++) {
                        s->set(i, j, k, r->get(i, j, k) - alpha*v->get(i, j, k));
                    }
                }
            }

            if(printCheck){
                std::cout << "s = q\n";
                std::cout << s->str("s");
            }

            // t = As
            multByA(s, t, num_stage, appData, dgParams, dgMesh, dgBasis, dgRiemann, time, smax, dt);
            if(printCheck){
                std::cout << t->str("t");
            }
            
            // omega = <t,s>/<t,t>
            double tt = dog_math::dot(t, t);
            if (fabs(tt) > constants::EPSILON) {
                omega = dog_math::dot(t, s)/tt;
            } else {
                if (printCheck) {
                    std::cout << "The vector t is too small possibly causing omega to be NaN\n";;
                    std::cout << "Setting omega to 1 instead\n";
                }
                omega = 1.0;
            }

            if (printCheck) {
                printf("omega = %e\n", omega);
            }

            // x = h + omega*s
            for (int i = 1; i <= l; i++) {
                for (int j = 1; j <= m; j++) {
                    for (int k = 1; k <= n; k++) {
                        x->set(i, j, k, h->get(i, j, k) + omega*s->get(i, j, k));
                    }
                }
            }
            if(printCheck){
                std::cout << x->str("x");
                std::cout << x->str("q = x");
            }

            // if x is accurate enough quite
            multByA(x, Ax, num_stage, appData, dgParams, dgMesh, dgBasis, dgRiemann, time, smax, dt);
            if(printCheck){
                std::cout << Ax->str("Ax");
            }
            dog_math::SubtractVectors(b, Ax, r);
            if(printCheck){
                printf("residual = %e\n", sqrt(dog_math::dot(res,res)));
            }
            if (sqrt(dog_math::dot(res, res)) < m_tolerance){
                break;
            }

            if(printCheck){
                std::cout << r->str("r");
            }
        }
        if (iter == m_max_iterations){
            printf("WARNING: BiCGSTAB did not converge in the allowed iterations.\n"
                    "Max Iterations = %d\n"
                    "Residual = %e\n", m_max_iterations, sqrt(dog_math::dot(res,res)));
        }
    }
}
