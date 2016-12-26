---
title: 一个关于map和foreach的bug
layout: post
categories:
  - 工作那些事儿
  - Scala
tags:
  - Scala
  - Work
  - Bug
---

之前在工作中有一个需求是这样的, 提供一个接口, 接口描述为`` def process(data: List[Object]): Boolean ``, 即接收一个List的Object, 返回一个布尔值表示操作的结果是否成功, 该操作为将传递的参数进行封装, 然后提交给远程server进行处理。刚开始的实现如下(简化处理):

```scala
def process(data: List[Object]): Boolean = {
  val params = constructParams(data)
  val response = httpRequest(url, params)
  logger.info(s"process count: ${data.size}, response: ${response}") 
  true
}
```

上线后代码运行良好, 某天看到了一些request timeout的exception, 最后定位为data的size太大, 导致server在给定的timeout limit时间内处理不过来, 因此最后决定将data进行slide一下分批进行处理. 因此update后的代码如下: 

```scala
def process(data: List[Object]): Boolean = {
  data.sliding(batchCount, batchCount).map(bat => {
    val params = constructParams(bat)
    val response = httpRequest(url, params)
    logger.info(s"process batchCount: ${bat.size}, response: ${response}") 
  })
  true
}
```

然后代码review后merge并上线了, 结果问题来了, 不知道为何发现所有的请求都失效了. 
一直没发现问题在哪, 还曾YY到因为这个function反正最后都返回true, 中间的map过程就直接优化了. 简直就是太天真了.

看了本文标题可能知道最后fix的方案了, 将`map`改为`foreach`即可.
看看`sliding`方法的签名`` def sliding(size: Int, step: Int): Iterator[Repr]``
它返回的是一个迭代器, 迭代器内部再进行map仍然返回一个迭代器, 其中的map中的实现后面并没有去进行evaluate, 当后面再对元素进行操作的时候, 才会去执行内部的代码.
类似懒加载(延迟加载)的形式. 而foreach是针对每个元素进行操作, 从字面上也能够理解两个方法的异同, 
二者的方法签名如下:

```scala
def map[B](f: (A) ⇒ B): Iterable[B]
// Builds a new collection by applying a function to all elements of this iterable collection.

def foreach(f: (A) ⇒ Unit): Unit
// Applies a function f to all elements of this iterable collection.
```

下面的给出了示例代码.

```scala
scala> (1 to 6).sliding(2, 2).map({ x =>
     |       x.foreach(v => print(s"${v} "))
     |     })
res0: Iterator[Unit] = non-empty iterator

scala> (1 to 6).sliding(2, 2).foreach({ x =>
     |       x.foreach(v => print(s"${v} "))
     |     })
1 2 3 4 5 6

scala> val x = (1 to 6).sliding(2, 2).map({ x =>
     |       x.foreach(v => print(s"${v} "))
     |     })
x: Iterator[Unit] = non-empty iterator
//再对x进行遍历时才会输出(执行上面map中的代码块)
scala> x.foreach(_+"")
1 2 3 4 5 6

//再举个例子, 跟本文上面提到的"bug"相似
scala> (1 to 6).toIterator.map(v => {
     | print(s"$v ")
     | s"-$v"
     | })
res20: Iterator[String] = non-empty iterator

scala> (1 to 6).toIterator.map(v => {
     | print(s"$v ")
     | s"-$v"
     | }).foreach(println)
1 -1
2 -2
3 -3
4 -4
5 -5
6 -6
```

[scala puzzler](http://scalapuzzlers.com/#pzzlr-006)上有一道关于迭代器(或者跟返回值相关)类似的坑人题目, 如下:

```scala
def sumSizes(collections: Iterable[TraversableOnce[_]]): Int = {
    collections.map(_.size).sum
}

sumSizes(List(Set(1, 2), List(3, 4))) //1
sumSizes(Set(List(1, 2), Set(3, 4))) //2
```

上面1的答案是啥? 很显然是`2+2=4`, 那么2的结果呢? 也是4吧?!
如果也是4就不用在这里说了, 因为`collections.map(_.size)`中返回的结果跟collections的类型有关, 这里是传入的是set, 因此返回的结果也是set, 所以内部list和set的size都是2, 即返回了`set(2, 2) = set(2)`, 因此最后sum的结果也是2了.

后面有空再整理学习下scala puzzler的相关问题. 
