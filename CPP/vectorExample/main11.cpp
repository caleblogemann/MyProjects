#include <vector>
#include <iostream>

class vectorWrapper{
    public:
        vectorWrapper(){
        };

        vectorWrapper(int a) : m_vector(a){
        };

        vectorWrapper(double a, double b) : m_vector({a, b}){
        };

        std::vector<double> m_vector;
};

// output steam std::vector<double>
// needs c++11
std::ostream& operator<<(std::ostream& s, const std::vector<double>& v) {
    s.put('[');
    char comma[3] = {'\0', ' ', '\0'};
    for (const auto& e : v) {
        s << comma << e;
        comma[0] = ',';
    }
    return s << ']';
}

int main(){

    // ways to initialize a vector
    // initializer list c++11
    std::vector<double> a = {1.0, 2.0, 1.5};
    // b = {1.0, 1.0, 1.0, 1.0, 1.0}
    std::vector<double> b(5, 1.0);
    std::cout << "b = " << b << std::endl;
    // copy constructor
    std::vector<double> c(a);
    std::cout << "c = " << c << std::endl;

    // copy assignment operator
    c = b;
    // c doesn't change when b is changed
    b[1] = 2.0;
    std::cout << "b = " << b << std::endl;
    std::cout << "c = " << c << std::endl;

    // does not automatically enlarge vector
    b[10] = 3.0;
    std::cout << "b = " << b << std::endl;

    // resize allows chaning of # of elements
    // fills extra with zeros
    b.resize(10);
    b[9] = 3.0;
    std::cout << "b = " << b << std::endl;

    vectorWrapper d;
    std::cout << "m_vector.size() = " << d.m_vector.size() << std::endl;
    std::cout << "m_vector = " << d.m_vector << std::endl;
    vectorWrapper e(3);
    std::cout << "m_vector.size() = " << e.m_vector.size() << std::endl;
    std::cout << "m_vector = " << e.m_vector << std::endl;
    vectorWrapper f(1.1, 2.2);
    std::cout << "m_vector.size() = " << f.m_vector.size() << std::endl;
    std::cout << "m_vector = " << f.m_vector << std::endl;

    return 1;
}
