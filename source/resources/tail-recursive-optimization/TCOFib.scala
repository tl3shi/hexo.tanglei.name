object TOCFib{

  def factorialHelper(acc: Long, n: Long): Long = {
    return if (n == 1) acc else factorialHelper(acc * n, n-1)
  }

   def factorialTailRecursive(n: Long): Long = {
    return factorialHelper(1, n)
  }

   def main(args: Array[String]) {
      println(factorialTailRecursive(4))
   }

}
