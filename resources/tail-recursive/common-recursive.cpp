int sumCommon(int n) {
    if (n <= 1) return n;
    return sumCommon(n-1) + n;
}
