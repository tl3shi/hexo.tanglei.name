---
id: 124
title: java native例子
date: 2010-12-21T15:33:37+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=124
duoshuo_thread_id:
  - 1351844048792453309
enable_highlight:
  - '<link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css"><script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script><script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>'
categories:
  - 课程学习
tags:
  - Java
---
研究了下 Java native 方法的例子，供需要的同学看看。 

首先看下什么是 Native method，参考了下http://www.80&#215;86.cn/article.asp?id=1448上的文章：

> Simply put, a native method is the Java interface to non-Java code. It is Java&#8217;s link to the &#8220;outside world.&#8221; More specifically, a native method is a Java method whose implementation is provided by non-Java code, most likely C。

大概意思就是说 native 方法是通过java调用其他 非java的代码。

> in your Java class, you mark the methods you wish to implement outside of Java with the native method modifier-much like you would use the public or static modifiers. Then, rather than supplying the method&#8217;s body, you simply place a semicolon in its place.The only thing special about this declaration is that the keyword native is used as a modifier. Every other Java method modifier can be used along with native, except abstract.

说的是native关键字跟其他什么public static修饰符一样也可以用来修饰方法，但除了abstract。

> This is logical, because the native modifier implies that an implementation exists, and the abstract modifier insists that there is no implementation. Your native methods can be static methods, thus not requiring the creation of an object (or instance of a class).

这是合理的，因为native暗示这些方法是有实现体的，只不过这些实现体是非java的，但是abstract却显然的指明这些方法无实现体。呵呵。我就不翻译原文了。有兴趣的看看原文去吧。

再查了些资料，就写了如下的代码。这个代码又是helloworld。唉，继续helloworld吧。用java去调用一个用C实现的方法。

```java
/**
* project_name：nativeTest
*  Description:
*  Copyright: Copyright (c) 2010 by 程序员升级打怪.
**/
package com.i3zhai.www;

/**
*  Title: NativeHelloWorld.java
*  Description:测试java关键字中native的方法
* @author ： 程序员升级打怪
* @date：2010-12-21 下午10:23:24
* @version 1.0
*/
public class NativeHelloWorld {
    /**
    * 程序员升级打怪
    * 下午10:27:23
    * Discription: 构造方法，加载dll文件
    * 或者用static 引入dll文件也可以，总之就是要在
    * 程序用到的时候之前把dll加载进来
    */
    public NativeHelloWorld() {
        System.loadLibrary("hello");
    }

    /**
    * 程序员升级打怪
    * 下午10:28:24
    * Discription:声明一个native的方法
    * 因为是native的 只是声明，实现由另外的诸如C语言去实现
    */
    public native void nativeHello();

    /**
    * 程序员升级打怪
    * 下午10:28:59
    * Discription:在此类中去调用C语言中实现的方法
    */
    public void sayHello() {
        nativeHello(); //调用方法
    }
}
```

上面已经写好了注释了。刚开始的时候，我直接用了eclipse，但发现后来dll文件容易找不到(eclipse估计估计还得哪里配置下吧)。于是就改为控制台下。

首先用javac命令 编译出class文件，没有编译错误就会产生class文件。

然后执行javah命令。看 javah 的用法。直接控制台下就能看到


```
R:\native>javah

用法：javah [选项] <类>

其中 [选项] 包括：

-help 输出此帮助消息并退出

-classpath <路径> 用于装入类的路径

-bootclasspath <路径> 用于装入引导类的路径

-d <目录> 输出目录

-o <文件> 输出文件（只能使用 -d 或 -o 中的一个）

-jni 生成 JNI样式的头文件（默认）

-version 输出版本信息

-verbose 启用详细输出

-force 始终写入输出文件

```


直接用javah NativeHelloWorld 就会生成一个.h的文件。如下所示：

```C
/* DO NOT EDIT THIS FILE - it is machine generated */
#include
/* Header for class NativeHelloWorld */

#ifndef _Included_NativeHelloWorld
#define _Included_NativeHelloWorld
#ifdef __cplusplus
extern "C" {
#endif
/*
* Class:     NativeHelloWorld
* Method:    nativeHello
* Signature: ()V
*/
JNIEXPORT void JNICALL Java_NativeHelloWorld_nativeHello
(JNIEnv * xx, jobject xxx);

#ifdef __cplusplus
}
#endif
#endif
```


然后在写`hello.c` 文件如下所示：


```C
#include "NativeHelloWorld.h"
JNIEXPORT void JNICALL Java_NativeHelloWorld_nativeHello
(JNIEnv * xx, jobject xxx)
{
printf("helloWorld,I am printing in the C ");
}
```

接下来要做的就是要生成dll文件，这个dll文件就是在类NativeHelloWorld中要load的参数名字。

生成dll文件可以用VC6.0之类的工具。期间在build的时候可能会遇到问题。就是上面的方法签名的地方需要加上参数。如上面的XX,xxx。这个是后来加上去的，不是javah之后就有的.

在build的时候，跟着错误信息就知道了，还会用到其他的dll文件。这个文件到jdk安装目录下search下就OK了。有jni.h,其中jni.h又会用到jni_md.h。直接copy过来到VC的工作路径下。然后就能在debug目录里面找到dll文件了。

此时，已经差不多了。再写个Test就OK了。

```java
/**
* Title: NativeHelloWorld.java
* Description:测试java关键字中native的方法
* @author ：程序员升级打怪
* @date：2010-12-21 下午10:23:24
* @version 1.0
*/
public class Test {
    /**
    * 程序员升级打怪
    * 下午10:23:24
    * Discription:
    *@param args
    */
    public static void main(String[] args) {
        NativeHelloWorld nat = new NativeHelloWorld();
        nat.sayHello();
    }
}

```

再在控制台下执行javac Test.java java Test就能看到结果了。

[<img class="size-full wp-image-125 aligncenter" title="native" src="/wp-content/uploads/2010/12/native1.png" alt=""  />](/wp-content/uploads/2010/12/native1.png)

[](/wp-content/uploads/2010/12/native.zip)

[文章例子中的源代码SRC下载](/wp-content/uploads/2010/12/native.zip)