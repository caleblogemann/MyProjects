#ifndef _MULTIGRID_H_
#define _MULTIGRID_H_

#include "LinearSolver.h"
#include <vector>

// ----------------------------------------------------------------------------
// MultiGrid.h implements a multi grid solver for a linear system
// such as A*x = f or A*sol = rhs
// see A Multigrid Tutorial 2nd Edition by Briggs, Henson, and McCormick for 
// details
// ----------------------------------------------------------------------------
class MultiGrid: public LinearSolver {
    public:
        MultiGrid(const int t_max_iterations,
                const double t_tolerance,
                matrixMultiplyFunc t_multByA,
                matrixMultiplyFunc t_multByDInverse,
                matrixMultiplyFunc t_multByLPlusU,
                matrixMultiplyFunc t_multByU,
                matrixMultiplyFunc t_multByDMinusLInverse);

        MultiGrid(const int t_max_iterations,
                const double t_tolerance,
                matrixMultiplyFunc t_multByA,
                matrixMultiplyFunc t_multByDInverse,
                matrixMultiplyFunc t_multByLPlusU,
                matrixMultiplyFunc t_multByU,
                matrixMultiplyFunc t_multByDMinusLInverse,
                const int t_cycling_parameter);

        MultiGrid(const int t_max_iterations,
                const double t_tolerance,
                matrixMultiplyFunc t_multByA,
                matrixMultiplyFunc t_multByDInverse,
                matrixMultiplyFunc t_multByLPlusU,
                matrixMultiplyFunc t_multByU,
                matrixMultiplyFunc t_multByDMinusLInverse,
                const double t_jacobi_weight);

        MultiGrid(const int t_max_iterations,
                const double t_tolerance,
                matrixMultiplyFunc t_multByA,
                matrixMultiplyFunc t_multByDInverse,
                matrixMultiplyFunc t_multByLPlusU,
                matrixMultiplyFunc t_multByU,
                matrixMultiplyFunc t_multByDMinusLInverse,
                const int t_cycling_parameter,
                const double t_jacobi_weight);

        void solve(const std::vector<double>& rhs,
            std::vector<double>& sol);

        struct grid {
            std::vector<double> rhs;
            std::vector<double> sol;
        };

        // getters and setters
        int get_cycling_parameter(){
            return m_cycling_parameter;
        }

        void set_cycling_parameter(const int t_cycling_parameter){
            m_cycling_parameter = t_cycling_parameter;
        }

        double get_jacobi_weight(){
            return m_jacobi_weight;
        }

        void set_jacobi_weight(const double t_jacobi_weight){
            m_jacobi_weight = t_jacobi_weight;
        }

        matrixMultiplyFunc get_multByDInverser(){
            return m_multByDInverse;
        }

        void set_multByDInverse(const matrixMultiplyFunc t_multByDInverse){
            m_multByDInverse = t_multByDInverse;
        }

        matrixMultiplyFunc get_multByLPlusU(){
            return m_multByLPlusU;
        }

        void set_multByA(const matrixMultiplyFunc t_multByLPlusU){
            m_multByLPlusU = t_multByLPlusU;
        }

    // private functions
    private:
        std::vector<double> v_cycle(const grid& g);
        std::vector<double> full_multi_grid(const std::vector<double>& rhs);
        std::vector<double> interpolate(const std::vector<double>& x);
        std::vector<double> restrict(const std::vector<double>& x);
        std::vector<double> relax(const std::vector<double>& sol, 
                const std::vector<double>& rhs);
        std::vector<double> jacobi_relaxation(const std::vector<double>& sol,
                const std::vector<double>& rhs);
        std::vector<double> weighted_jacobi_relaxation(
                const std::vector<double>& sol,
                const std::vector<double>& rhs);
        std::vector<double> gauss_seidel_relaxation(
                const std::vector<double>& sol,
                const std::vector<double>& rhs);

    private:
        matrixMultiplyFunc m_multByDInverse;
        matrixMultiplyFunc m_multByLPlusU;
        matrixMultiplyFunc m_multByU;
        matrixMultiplyFunc m_multByDMinusLInverse;
        int m_cycling_parameter;
        double m_jacobi_weight;
};

#endif
