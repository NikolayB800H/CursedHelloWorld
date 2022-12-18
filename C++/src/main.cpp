#include <iostream>

extern "C" {
    char *get_hello_world(void);
    void free_hello_world(char *result);
}

int main() {
    char *str = get_hello_world();
    std::cout << str << std::endl;
    free_hello_world(str);
}
