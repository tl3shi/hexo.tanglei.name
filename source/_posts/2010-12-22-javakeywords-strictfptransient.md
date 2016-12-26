---
id: 150
title: java关键字strictfp,transient
date: 2010-12-22T15:25:36+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=150
duoshuo_thread_id:
  - 1351844048792453199
categories:
  - JAVA
tags:
  - Java
  - Java基础
---
前面已经整理了java中的不常见关键字native,volatile,就一气呵成，把另外两个也整一下。

**transient：这个关键字还比较简单，是变量修饰符。**

标记为transient的变量，在对象存储时，这些变量状态不会被持久化。当对象**序列化**的保存在存储器上时，不希望有些字段数据被保存，为了保证安全性，可以把这些字段声明为transient。

**strictfp：修饰类和方法，意思是FP(**float point**)-strict，精确浮点，符合IEEE-754规范的。**

当一个class或interface用strictfp声明，内部所有的float和double表达式都会成为strictfp的。Interface method不能被声明为strictfp的，class的可以。在Java虚拟机进行浮点运算时，如果没有指定strictfp关键字时，Java的编译器以及运行环境在对浮点运算的表达式是采取一种近似于我行我素的行为来完成这些操作，以致于得到的结果往往无法令你满意。而一旦使用了strictfp来声明一个类、接口或者方法时，那么所声明的范围内Java的编译器以及运行环境会完全依照浮点规范IEEE-754来执行。因此如果你想让你的浮点运算更加精确，而且不会因为不同的硬件平台所执行的结果不一致的话，那就请用关键字strictfp。想了解IEEE-754的，这给个维基百科的链接<http://zh.wikipedia.org/zh/IEEE_754>

关键字总算差不多了。
