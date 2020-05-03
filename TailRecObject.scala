object TailRecObject {

   def tailSum(n: Int, sum: Int): Int = {
        if (n == 0) return sum;
        return tailSum(n-1, n+sum);
    }

   def main(args: Array[String]) {
      println(tailSum(100, 0))
      println(tailSum(1000000, 0))
   }

}
