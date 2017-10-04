#include "MultiGrid.h"
#include <vector>
#include <iostream>
#include "vector_math.h"
#include "math.h"

MultiGrid::MultiGrid(
        const int t_max_iterations,
        const double t_tolerance,
        matrixMultiplyFunc t_multByA,
        matrixMultiplyFunc t_multByDInverse,
        matrixMultiplyFunc t_multByLPlusU,
        matrixMultiplyFunc t_multByU,
        matrixMultiplyFunc t_multByDMinusLInverse)
    : 
        LinearSolver(t_max_iterations, t_tolerance, t_multByA),
        m_multByDInverse(t_multByDInverse),
        m_multByLPlusU(t_multByLPlusU),
        m_multByU(t_multByU),
        m_multByDMinusLInverse(t_multByDMinusLInverse),
        m_cycling_parameter(1),
        m_jacobi_weight(0.66666666666666667)
{
}

MultiGrid::MultiGrid(
        const int t_max_iterations,
        const double t_tolerance,
        matrixMultiplyFunc t_multByA,
        matrixMultiplyFunc t_multByDInverse,
        matrixMultiplyFunc t_multByLPlusU,
        matrixMultiplyFunc t_multByU,
        matrixMultiplyFunc t_multByDMinusLInverse,
        const int t_cycling_parameter)
    :  
        LinearSolver(t_max_iterations, t_tolerance, t_multByA),
        m_multByDInverse(t_multByDInverse),
        m_multByLPlusU(t_multByLPlusU),
        m_multByU(t_multByU),
        m_multByDMinusLInverse(t_multByDMinusLInverse),
        m_cycling_parameter(t_cycling_parameter),
        m_jacobi_weight(0.66666666666666667)
{
}

MultiGrid::MultiGrid(
        const int t_max_iterations,
        const double t_tolerance,
        matrixMultiplyFunc t_multByA,
        matrixMultiplyFunc t_multByDInverse,
        matrixMultiplyFunc t_multByLPlusU,
        matrixMultiplyFunc t_multByU,
        matrixMultiplyFunc t_multByDMinusLInverse,
        const double t_jacobi_weight)
    : 
        LinearSolver(t_max_iterations, t_tolerance, t_multByA),
        m_multByDInverse(t_multByDInverse),
        m_multByLPlusU(t_multByLPlusU),
        m_multByU(t_multByU),
        m_multByDMinusLInverse(t_multByDMinusLInverse),
        m_cycling_parameter(1),
        m_jacobi_weight(t_jacobi_weight)
{
}

MultiGrid::MultiGrid(
        const int t_max_iterations,
        const double t_tolerance,
        matrixMultiplyFunc t_multByA,
        matrixMultiplyFunc t_multByDInverse,
        matrixMultiplyFunc t_multByLPlusU,
        matrixMultiplyFunc t_multByU,
        matrixMultiplyFunc t_multByDMinusLInverse,
        const int t_cycling_parameter,
        const double t_jacobi_weight)
    : 
        LinearSolver(t_max_iterations, t_tolerance, t_multByA),
        m_multByDInverse(t_multByDInverse),
        m_multByLPlusU(t_multByLPlusU),
        m_multByU(t_multByU),
        m_multByDMinusLInverse(t_multByDMinusLInverse),
        m_cycling_parameter(t_cycling_parameter),
        m_jacobi_weight(t_jacobi_weight)
{
}

void MultiGrid::solve(const std::vector<double>& b,
        std::vector<double>& x)
{
    const int n = b.size();
    // check that n is power of 2
    if ((n & (n - 1)) != 0) {
        std::cerr << "Error the length of the vectors must be a power of 2" << std::endl;
    }

    x = MultiGrid::full_multi_grid(b);
}

std::vector<double> MultiGrid::v_cycle(const MultiGrid::grid& g)
{
    std::cout << "V-Cycle" << std::endl;
    //std::cout << vector_math::str(g.sol, "sol");
    //std::cout << vector_math::str(g.rhs, "rhs");
    int n = g.sol.size();
    int n_copy = n;
    int k = 0;
    while(n_copy >>= 1){
        ++k;
    }
    //std::cout << "k = " << k << std::endl;

    std::vector<MultiGrid::grid> Grid(k+1);
    Grid[0] = g;

    for (int i = 1; i < k+1; i++) {
        std::vector<double> temp(static_cast<int>(pow(0.5, i)*n), 0.0);
        Grid[i].sol = temp;
    }

    std::vector<double> residual;
    std::vector<double> temp;

    for (int i = 0; i <= k-1; i++) {
        Grid[i].sol = MultiGrid::relax(Grid[i].sol, Grid[i].rhs);
        //std::cout << vector_math::str(Grid[i].sol, "sol");
        temp = m_multByA(Grid[i].sol);
        //std::cout << vector_math::str(temp, "Asol");
        residual = vector_math::subtract(Grid[i].rhs, temp);
        //std::cout << vector_math::str(residual, "res");

        Grid[i+1].rhs = MultiGrid::restrict(residual);
    }

    //std::cout << vector_math::str(Grid[k].sol, "sol");
    //std::cout << vector_math::str(Grid[k].rhs, "rhs");
    std::vector<double> sol = MultiGrid::relax(Grid[k].sol, Grid[k].rhs);
    //std::cout << vector_math::str(sol, "sol");
    Grid[k].sol = sol;

    for (int i = k-1; i >= 0; i--) {
        temp = MultiGrid::interpolate(Grid[i+1].sol);
        //std::cout << vector_math::str(temp, "err");
        Grid[i].sol = vector_math::add(Grid[i].sol, temp);
        //std::cout << vector_math::str(Grid[i].sol, "sol");
        //std::cout << vector_math::str(Grid[i].rhs, "rhs");
        Grid[i].sol = MultiGrid::relax(Grid[i].sol, Grid[i].rhs);
        //std::cout << vector_math::str(Grid[i].sol, "sol");
    }

    return Grid[0].sol;
}

std::vector<double> MultiGrid::full_multi_grid(const std::vector<double>& rhs){
    std::cout << "Full Multi Grid" << std::endl;
    // given size n find k such that 2^k = n
    int n = rhs.size();
    int n_copy = n;
    int k = 0;
    while(n_copy >>= 1){
        ++k;
    }

    std::vector< std::vector<double> > rhs_list;
    rhs_list.push_back(rhs);
    for (int i = 1; i <= k; i++) {
        rhs_list.push_back(MultiGrid::restrict(rhs_list[i-1]));
    }

    std::vector<double> sol(1,0.0);

    MultiGrid::grid g;
    g.sol = sol;
    for (int i = 0; i <= k; i++) {
        g.rhs = rhs_list[k-i];
        for (int j = 0; j < m_cycling_parameter; j++) {
            sol = v_cycle(g);
            g.sol = sol;
        }
        if (i < k) {
            g.sol = MultiGrid::interpolate(g.sol);
        }
    }

    return sol;
}

std::vector<double> MultiGrid::interpolate(const std::vector<double>& x){
    std::cout << "Interpolating"  << std::endl;
    int n = x.size();
    std::vector<double> result;
    for (int i = 0; i < n; i++) {
        result.push_back(x[i]);
        result.push_back(x[i]);
    }
    return result;
}

std::vector<double> MultiGrid::restrict(const std::vector<double>& x){
    std::cout << "Restricting"  << std::endl;
    int n = x.size();
    std::vector<double> result;
    for (int i = 0; i < n/2; i++) {
        result.push_back((x[2*i] + x[2*i + 1]));
    }
    return result;
}

std::vector<double> MultiGrid::relax(
        const std::vector<double>& sol,
        const std::vector<double>& rhs){
    std::cout << "Relaxing"  << std::endl;
    std::vector<double> result = MultiGrid::gauss_seidel_relaxation(sol, rhs);
    return result; 
}

std::vector<double> MultiGrid::jacobi_relaxation(
        const std::vector<double>& sol,
        const std::vector<double>& rhs){
    std::vector<double> result(sol);
    for (int i = 0; i < m_max_iterations; i++) {
        result = m_multByLPlusU(result);
        result = vector_math::add(result, rhs);
        result = m_multByDInverse(result);
    }
    return result;
}

std::vector<double> MultiGrid::weighted_jacobi_relaxation(
        const std::vector<double>& sol,
        const std::vector<double>& rhs){
    int n = sol.size();
    std::vector<double> temp;
    std::vector<double> residual;
    std::vector<double> result(sol);
    //std::cout << vector_math::str(result, "result");
    for (int i = 0; i < m_max_iterations; i++) {
        temp = m_multByA(result);
        //std::cout << vector_math::str(temp, "Asol");
        residual = vector_math::subtract(rhs, temp);
        //std::cout << vector_math::str(residual, "residual");
        temp = m_multByDInverse(residual);
        //std::cout << vector_math::str(temp, "DInverseRes");
        temp = vector_math::scalar_multiply(m_jacobi_weight, temp);
        result = vector_math::add(result, temp);
        //std::cout << vector_math::str(result, "result");
    }
    return result;
}

std::vector<double> MultiGrid::gauss_seidel_relaxation(
        const std::vector<double>& sol,
        const std::vector<double>& rhs){
    int n = sol.size();
    std::vector<double> temp;
    std::vector<double> result(sol);
    for (int i = 0; i < m_max_iterations; i++) {
        temp = m_multByU(result);
        temp = vector_math::add(temp, rhs);
        result = m_multByDMinusLInverse(temp);
    }
    return result;
}
