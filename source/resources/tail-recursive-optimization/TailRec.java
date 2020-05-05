public class TailRec {


    public static int tailSum(int n, int sum) {
        if (n == 0) return sum;
        return tailSum(n-1, n+sum);
    }

    public static void main(String[] args) {
        System.out.println(tailSum(100, 0));
        System.out.println(tailSum(100000, 0));
    }
}
