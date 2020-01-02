#include "childClassA.h"
#include "parentParam.h"
#include <iostream>

void childClassA::method(parentParam* pp){
    std::cout << "Child Class A method" << std::endl;
}
