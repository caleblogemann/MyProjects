#include <iostream>
    using std::cerr;
    using std::cout;
    using std::endl;

#include "ToDo.h"

#define EXPECT_EQUAL(test, expect) equality_test(test, expect, \
                                                 #test, #expect, \
                                                 __FILE__, __LINE__)

template <typename T1, typename T2>
int equality_test(const T1 testValue,
                  const T2 expectedValue,
                  const char* testName,
                  const char* expectedName,
                  const char* fileName,
                  const int lineNumber);

int main (int , char**) {
    int result = 0;

    ToDo list;

    list.addTask("Write Code");
    list.addTask("Compile");
    list.addTask("Test");

    result |= EXPECT_EQUAL(list.size(), size_t(3));
    result |= EXPECT_EQUAL(list.getTask(0), "Write Code");
    result |= EXPECT_EQUAL(list.getTask(1), "Compile");
    result |= EXPECT_EQUAL(list.getTask(2), "Test");

    if (result == 0){
        cout << "Tests Passed" << endl;
    }

    return result;
}

template <typename T1, typename T2>
int equality_test(
        const T1 testValue,
        const T2 expectedValue,
        const char* testName,
        const char* expectedName,
        const char* fileName,
        const int lineNumber
)
{
    if (testValue != expectedValue) {
        cerr << fileName << ":" << lineNumber << ": "
            << "Expected " << testName << " "
            << "to equal" << expectedName << " (" << expectedValue << ") "
            << "but it was (" << testValue << ")" << endl;

        return 1;
    } else {
        return 0;
    }
}
