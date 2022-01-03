public class TailRecursiveTest {
    static int sumCommon(int n) {
        if (n == 0) return n;
        return sumCommon(n-1) + n;
    }

    static int sumTail(int n, int sum) {
        if (n == 0) return sum;
        return sumTail(n-1, sum+n);
    }

    public static void main(String[] args) {
        System.out.println(sumCommon(10));
        int sum = 0;
        System.out.println(sumTail(10, sum));
    }

}
