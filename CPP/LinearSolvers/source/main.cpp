#include "LinearSolver.h"
#include "ConjugateGradient.h"
#include "MultiGrid.h"
#include "vector_math.h"
#include <math.h>

#include <iostream>
#define CATCH_CONFIG_MAIN
#include "catch.hpp"

const double a = 0.0;
const double b = 1.0;

std::vector<double> multByA(const std::vector<double>& x){
    std::vector<double> Ax;
    Ax.push_back(4*x[0] + x[1]);
    Ax.push_back(x[0] + 3*x[1]);
    return Ax;
}

std::vector<double> diffusion_multByA(const std::vector<double>& x){
    int n = x.size();
    double h = (b - a)/n;
    std::vector<double> result(n);
    if (n > 1){
        result[0] = ((2.0 + h*h)*x[0] - x[1]);
        for (int i = 1; i < n-1; i++) {
            result[i] = (-x[i-1] + (2.0 + h*h)*x[i] - x[i+1]);
        }
        result[n-1] = (-x[n-2] + (2.0 + h*h)*x[n-1]);
    } else {
        result[0] = (2.0 + h*h)*x[0];
    }
    return result;
}

std::vector<double> diffusion_multByDInverse(const std::vector<double>& x){
    int n = x.size();
    double h = (b - a)/n;
    std::vector<double> result(n);
    for (int i = 0; i < n; i++) {
        result[i] = x[i]/(2.0 + h*h);
    }
    return result;
}

std::vector<double> diffusion_multByLPlusU(const std::vector<double>& x){
    int n = x.size();
    std::vector<double> result(n);
    if (n > 1) {
        result[0] = x[1];
        for (int i = 1; i < n-1; i++) {
            result[i] = x[i-1] + x[i+1];
        }
        result[n-1] = x[n-2];
    } else {
        result[0] = 0;
    }
    return result;
}

std::vector<double> diffusion_multByU(const std::vector<double>& x){
    int n = x.size();
    std::vector<double> result(n);
    if (n > 1) {
        result[0] = x[1];
        for (int i = 1; i < n-1; i++) {
            result[i] = x[i+1];
        }
    } else {
        result[0] = 0;
    }
    return result;
}

std::vector<double> diffusion_multByDMinusLInverse(const std::vector<double>& x){
    int n = x.size();
    double h = (b - a)/n;
    std::vector<double> result(n);
    // (2 + h^2)result[0] = x[0]
    result[0] = x[0]/(2.0 + h*h);
    for (int i = 1; i < n; i++) {
        // -result[i - 1] + (2 + h^2)result[i] = x[i]
        result[i] = (x[i] + result[i-1])/(2.0 + h*h);
    }
    return result;
}

std::vector<double> diffusion_rhs(const int n){
    double a = 0.0;
    double b = 1.0;
    double h = (b - a)/n;

    std::vector<double> result(n);
    for (int i = 0; i < n; i++) {
        result[i] = h*h/(2.0*M_PI)*(cos(2.0*M_PI*(double(i) + 1.0)*h) - cos(2.0*M_PI*double(i)*h));
    }
    return result;
}

TEST_CASE("Conjugate Gradient", "[cg]"){
    double tolerance = 1e-10;
    int max_iterations = 10;
    LinearSolver::matrixMultiplyFunc mA = &multByA;

    ConjugateGradient cg(max_iterations, tolerance, mA);
    std::vector<double> b;
    b.push_back(1);
    b.push_back(2);
    std::vector<double> x;
    x.push_back(2);
    x.push_back(1);
    cg.solve(b, x);

    REQUIRE(std::abs(x[0] - 1.0/11.0) < tolerance);
    REQUIRE(std::abs(x[1] - 7.0/11.0) < tolerance);
}

//TEST_CASE("BiConjugateGradientStab", "[bicgstab]"){
    //double tolerance = 1e-10;
    //int max_iterations = 100;
    //ConjugateGradient cg(max_iterations, tolerance);

    //LinearSolver::multByAFunc mA = &multByA;
    //std::vector<double> b;
    //b.push_back(1);
    //b.push_back(2);
    //std::vector<double> x;
    //x.push_back(2);
    //x.push_back(1);
//}

TEST_CASE("MultiGrid", "[mg]"){
    double tolerance = 1e-10;
    int max_iterations = 3;

    LinearSolver::matrixMultiplyFunc mA = &diffusion_multByA;
    LinearSolver::matrixMultiplyFunc mDInverse = &diffusion_multByDInverse;
    LinearSolver::matrixMultiplyFunc mLPlusU = &diffusion_multByLPlusU;
    LinearSolver::matrixMultiplyFunc mU = &diffusion_multByU;
    LinearSolver::matrixMultiplyFunc mDMinusLInverse = &diffusion_multByDMinusLInverse;

    MultiGrid mg(max_iterations, tolerance, mA,  mDInverse, mLPlusU, mU, mDMinusLInverse);

    int n = 32;
    std::vector<double> rhs = diffusion_rhs(n);
    //std::cout << vector_math::str(rhs, "rhs");
    std::vector<double> sol(n,1.0);

    mg.solve(rhs, sol);
    std::cout << vector_math::str(sol, "sol");

}
