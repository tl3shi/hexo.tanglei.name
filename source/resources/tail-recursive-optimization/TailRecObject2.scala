object TailRecObject2 {

   def tailSum(n: Int, sum: Int): Int = {
     var nTemp = n
     var sumTemp = sum
     while (true) {
       if (nTemp == 0) return sumTemp
       sumTemp = nTemp + sumTemp
       nTemp = nTemp - 1
     }
     return 0
   }

   def main(args: Array[String]) {
      println(tailSum(100, 0))
      println(tailSum(1000000, 0))
   }

}
