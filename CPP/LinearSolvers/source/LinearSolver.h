#ifndef _LINEARSOLVER_H_
#define _LINEARSOLVER_H_

#include <vector>
// ----------------------------------------------------------------------------
// LinearSolver.h defines the LinearSolver Class
// The LinearSolver Class is an abstract parent class whose children
// solver linear systems.
// ----------------------------------------------------------------------------
class LinearSolver{

    public:
        typedef std::vector<double> (* matrixMultiplyFunc)(const std::vector<double>& q);

        // constructor
        LinearSolver(
                matrixMultiplyFunc t_multByA)
            :
                m_max_iterations(100),
                m_tolerance(1e-10),
                m_multByA(t_multByA)
        {
        }

        LinearSolver(
                const double t_tolerance, 
                matrixMultiplyFunc t_multByA)
            :
                m_max_iterations(100),
                m_tolerance(t_tolerance),
                m_multByA(t_multByA)
        {
        }

        LinearSolver(
                const int t_max_iterations, 
                matrixMultiplyFunc t_multByA)
            :
                m_max_iterations(t_max_iterations),
                m_tolerance(1e-10),
                m_multByA(t_multByA)
        {
        }

        LinearSolver(
                const int t_max_iterations, 
                const double t_tolerance, 
                matrixMultiplyFunc t_multByA)
            :
                m_max_iterations(t_max_iterations),
                m_tolerance(t_tolerance),
                m_multByA(t_multByA)
        {
        }

        virtual void solve(const std::vector<double>& b,
            std::vector<double>& x) = 0;

        // getters and setters
        int get_max_iterations(){
            return m_max_iterations;
        }

        void set_max_iterations(int t_max_iterations){
            m_max_iterations = t_max_iterations;
        }

        double get_tolerance(){
            return m_tolerance;
        }

        void set_tolerance(const double t_tolerance){
            m_tolerance = t_tolerance;
        }

        matrixMultiplyFunc get_multByA(){
            return m_multByA;
        }

        void set_multByA(const matrixMultiplyFunc t_multByA){
            m_multByA = t_multByA;
        }

    protected:
        int m_max_iterations;
        double m_tolerance;
        matrixMultiplyFunc m_multByA;
};

#endif
