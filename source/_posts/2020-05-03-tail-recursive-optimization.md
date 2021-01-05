---
title: 大家都知道递归，尾递归呢？什么又是尾递归优化？
layout: post
categories: 
  - 经验技巧 
tags: 
  - 经验技巧
  - 递归
---

今天，我们来聊聊递归函数。为啥突然想到递归？其实就从电影名字《恐怖游轮》《盗梦空间》想到了。

## 递归是啥

递归函数大家肯定写过，学校上课的时候，估计最开始的例子就是斐波拉契数列了吧。例如： 

```java
int Fibonacci(n) {
	if (n < 2) return n;
	return Fibonacci(n - 1) + Fibonacci(n - 2);
}
```

递归函数简而言之就是在一个函数中，又“递归”调用自己。在写递归函数的时候，需要注意的地方就是递归函数的结束条件。用递归函数确实能简化很多算法的实现，比如常见的二叉树遍历等。但往往在写递归函数的时候，最容易出现的问题就是所谓的“栈溢出”。

为什么会有“栈溢出”呢？因为函数调用的过程，都要借助“栈”这种存储结构来保存运行时的一些状态，比如函数调用过程中的变量拷贝，函数调用的地址等等。而“栈”往往存储空间是有限的，当超过其存储空间后，就会抛出著名的异常/错误“StackOverflowError”。

我们以一个简单的加法为例，例如：

```cpp
int sum(int n) {
    if (n <= 1) return n;
    return n + sum(n-1);
}
```

```cpp
std::cout << sum(100) << std::endl;
std::cout << sum(1000000) << std::endl;
```

很简答，编译运行后，比较小的数字，能得到正确的答案，当数字扩大后，就会直接发生“segmentation fault”。 

```cpp
(python2.7) ➜  hexo.tanglei.name git:(master) ✗ ./a.out
5050
[1]    78159 segmentation fault  ./a.out
```

## 尾递归又是啥？

我得知这个概念，最开始还是因为很多年前一次面试，面试官问我“你知道什么是尾递归吗？”，我以为是“伪”递归，难道是假的递归？？？当初我也是懵逼状态（当初面试官忍住没笑也是厉害了）。从“尾”字可看出来即若函数在尾巴的地方递归调用自己。上面的例子写成尾递归，就变成了如下：

```cpp
int tailsum(int n, int sum) {
    if (n == 0) return sum;
    return tailsum(n-1, sum+n);
}
```

可以试试结果，计算从 1 加到 1000000，仍然是 `segmentation fault`。为什么呢？ 因为这种写法，本质上还是有多层的函数嵌套调用，中间仍然有压栈、出栈等占用了存储空间（只不过能比前面的方法会省部分空间）。 

## 尾递归优化

当你给编译选项开了优化之后，见证奇迹的时刻到了，居然能算出正确结果。如图所示： 

![](https://www.tanglei.name/resources/tail-recursive-optimization/tailrec-cpp.jpg)

原因就是因为编译器帮助做了尾递归优化，可以打开汇编代码看看（这里就不展示 C++的了）。后面我用大家比较熟悉的 JVM based 语言 Scala 来阐述这个优化过程。(好像 Java 的编译器没做这方面的优化，至少我实验我本地 JDK8 是没有的，不清楚最新版本的有木有)（scala 本身提供了一个注解帮助编译器强制校验是否能够进行尾递归优化`@tailrec`）

```scala
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
```


结果如下所示，默认情况下 `scalac` 做了尾递归优化，能够正确计算出结果，当通过 `-g:notailcalls` 编译参数去掉尾递归优化后，就发生了 `Exception in thread "main" java.lang.StackOverflowError`了。

![](https://www.tanglei.name/resources/tail-recursive-optimization/tailrec-scala.jpg)


我们来看看生成的字节码有什么不同。 

![包含尾递归优化的字节码](https://www.tanglei.name/resources/tail-recursive-optimization/tailrec-scala-opti.jpg)

![不包含尾递归优化的字节码](https://www.tanglei.name/resources/tail-recursive-optimization/tailrec-scala-no-opti.jpg)

从上面可以看出，尾递归优化后，变成循环了（前面的 C++ 类似）。

好了，尾递归咱们就了解到这里。个人看法，我们知道有“尾递归”这个点就好了，有时候我们写递归就是为了方便，代码可读性好，如果确实是出于性能考虑，我们可以自己用迭代的方式去实现，不依赖于具体的编译器实现。当然对于像 scala 这样，有一些语法糖能够帮助校验和验证，也是一个不错的选择。但递归转迭代的能力，我们能具备岂不更好。
下次想聊什么话题吗？欢迎留言。老规矩，如果有帮助（对你身边的其他人有帮助也行呀，一点帮助也没有也不会看到这里了，哈哈，莫要白嫖），写篇文章真心不容易，希望亲多多帮忙“在看”，转发分享支持。
