#include <vector>
#include <string>
#include <sstream>
#include <iostream>

class vectorWrapper{
    public:
        vectorWrapper(){
        };

        vectorWrapper(int a) : m_vector(a){
        };

        //vectorWrapper(double a, double b) : m_vector({a, b}){
        //};

        std::vector<double> m_vector;
};

std::string str(std::vector<double> a){
    std::ostringstream result;
    result << "[";
    for (int i = 0; i < a.size(); i++){
        result << a[i];
        if (i < a.size() - 1){
            result << ", ";
        }
    }
    result << "]";

    return result.str();
}

int main(){
    // ways to initialize a vector
    // initializer list c++11
    //std::vector<double> a = {1.0, 2.0, 1.5};
    std::vector<double> a;
    a.push_back(1.0);
    a.push_back(2.0);
    a.push_back(1.5);
    //std::vector<double> a2({1.0, 2.0, 1.5});
    // b = {1.0, 1.0, 1.0, 1.0, 1.0}
    std::vector<double> b(5, 1.0);
    std::cout << "b = " << str(b) << std::endl;
    // copy constructor
    std::vector<double> c(a);
    std::cout << "c = " << str(c) << std::endl;

    // initialize with negative length
    // throws runtime error 
    //std::vector<double> test(-2);

    // copy assignment operator
    c = b;
    // c doesn't change when b is changed
    b[1] = 2.0;
    std::cout << "b = " << str(b) << std::endl;
    std::cout << "c = " << str(c) << std::endl;

    // does not automatically enlarge vector
    b[10] = 3.0;
    std::cout << "b = " << str(b) << std::endl;

    // resize allows chaning of # of elements
    // fills extra with zeros
    b.resize(10);
    b[9] = 3.0;
    std::cout << "b = " << str(b) << std::endl;

    vectorWrapper d;
    std::cout << "m_vector.size() = " << d.m_vector.size() << std::endl;
    std::cout << "m_vector = " << str(d.m_vector) << std::endl;
    vectorWrapper e(3);
    std::cout << "m_vector.size() = " << e.m_vector.size() << std::endl;
    std::cout << "m_vector = " << str(e.m_vector) << std::endl;
    //vectorWrapper f(1.1, 2.2);
    //std::cout << "m_vector.size() = " << f.m_vector.size() << std::endl;
    //std::cout << "m_vector = " << str(f.m_vector) << std::endl;

    return 1;
}
