#include <stdlib.h>
#include "LinearSolver.h"
#include "ConjugateGradient.h"
#include "BiConjugateGradientStab.h"
#include "MultiGrid.h"

class LinearSolverFactory{

    public:
        static LinearSolver* createLinearSolver(const std::string& solver_type){
            LinearSolver* linearSolver;
            if (solver_type == "ConjugateGradient") {
                ConjugateGradient* cg()
            } else if (solver_type == "BiConjugateGradientStab") {
                
            } else if (solver_type == "MultiGrid") {
                
            } else {
                
            }
        }
}
