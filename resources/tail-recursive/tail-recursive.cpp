int sumTailRecursive(int n, int sum) {
    if (n <= 1) return sum+n;
    return sumTailRecursive(n-1, sum+n);
}

