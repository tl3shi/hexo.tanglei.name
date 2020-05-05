#include <iostream>

using namespace std;

int sum(int n) {
    if (n <= 1) return n;
    return n + sum(n-1);
}

int tailsum(int n, int sum) {
    if (n == 0) return sum;
    return tailsum(n-1, sum+n);
}

int main() {

    std::cout << sum(100) << std::endl;
    std::cout << sum(1000000) << std::endl;
    //std::cout << tailsum(1000000, 0) << std::endl;
    return 0;
}
