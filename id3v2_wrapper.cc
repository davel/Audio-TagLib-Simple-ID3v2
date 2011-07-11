#include <iostream>

extern "C" {
    void hello();
}

void hello() {
    std::cout << "Hello world!";
}
