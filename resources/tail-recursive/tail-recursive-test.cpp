#include <iostream>
using namespace std;

int sumCommon(int n) {
    if (n <= 1) return n;
    return sumCommon(n-1) + n;
}

int sumTailRecursive(int n, int sum) {
    if (n <= 1) return sum+n;
    return sumTailRecursive(n-1, sum+n);
}

int main() {
    cout << sumCommon(10) << endl;
    int sum = 0;
    cout << sumTailRecursive(10, sum) << endl;
    return 0;
}

