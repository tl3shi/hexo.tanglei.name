int tailsum(int n, int sum) {
    if (n == 0) return sum;
    return tailsum(n-1, sum+n);
}
