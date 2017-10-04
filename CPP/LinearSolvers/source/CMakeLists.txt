cmake_minimum_required(VERSION 3.9 FATAL_ERROR)

project("LinearSolvers")

enable_testing()

add_executable(main main.cpp
    ConjugateGradient.cpp
    MultiGrid.cpp
    vector_math.cpp)

add_test(LinearSolversTest main)

