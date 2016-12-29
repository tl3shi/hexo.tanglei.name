---
id: 144
title: java关键字volatile
date: 2010-12-22T14:58:50+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=144
duoshuo_thread_id:
  - 1351844048792453389
categories:
  - 课程学习
tags:
  - Java
---
前面讲过了native了。继续看看volatile关键字吧。参考了下<http://www.javamex.com/tutorials/synchronization_volatile.shtml>上面的文章。

_It&#8217;s probably fair to say that on the whole, the <tt>volatile</tt> keyword in Java is poorly documented, poorly understood, and rarely used. To make matters worse, its formal definition actually changed as of Java 5. Essentially, <tt>volatile</tt> is used to indicate that a variable&#8217;s value will be modified by different threads.__Declaring a volatile Java variable means:__The value of this variable will never be cached thread-locally: **all reads and writes will go straight to &#8220;main memory&#8221;;**__Access to the variable acts as though it is enclosed in a synchronized block, synchronized on itself._

**volatile关键字就是提示VM：对于这个成员变量不能保存它的私有拷贝，而应直接与共享成员变量交互。**

在当前的Java内存模型下，线程可以把变量保存在本地内存（比如机器的寄存器）中，而不是直接在主存中进行读写。这就可能造成一个线程在主存中修改了一个变量的值，而另外一个线程还继续使用它在寄存器中的变量值的拷贝，造成数据的不一致。
  
要解决这个问题，只需要像在本程序中的这样，把该变量声明为volatile（不稳定的）即可，这就指示JVM，这个变量是不稳定的，每次使用它都到主存中进行读取。一般说来，多任务环境下各任务间共享的标志都应该加volatile修饰。
  
Volatile修饰的成员变量在每次被线程访问时，都强迫从共享内存中重读该成员变量的值。而且，当成员变量发生变化时，强迫线程将变化值回写到共享内存。这样在任何时刻，两个不同的线程总是看到某个成员变量的同一个值。

但是Volatile一般情况下不能代替sychronized，因为volatile不能保证操作的原子性，**即使只是i++，实际上也是由多个原子操作组成：read i; inc; write i，假如多个线程同时执行i++，volatile只能保证他们操作的i是同一块内存，但依然可能出现写入脏数据的情况**。**在使用volatile关键字时要慎重，并不是只要简单类型变量使用volatile修饰，对这个变量的所有操作都是原来操作，当变量的值由自身的上一个决定时，如n=n+1、n++ 等，volatile关键字将失效，只有当变量的值和自身上一个值无关时对该变量的操作才是原子级别的，如n = m + 1，这个就是原级别的。**

下面看看Volatile和sychronized的区别

<table border="1">
  <tr valign="top">
    <th>
      Characteristic
    </th>
    
    <th>
      Synchronized
    </th>
    
    <th>
      Volatile
    </th>
  </tr>
  
  <tr>
    <td>
      Type of variable
    </td>
    
    <td>
      Object
    </td>
    
    <td>
      Object or primitive
    </td>
  </tr>
  
  <tr>
    <td>
      <tt>Null</tt> allowed?
    </td>
    
    <td>
      No
    </td>
    
    <td>
      Yes
    </td>
  </tr>
  
  <tr>
    <td>
      Can block?
    </td>
    
    <td>
      Yes
    </td>
    
    <td>
      No
    </td>
  </tr>
  
  <tr>
    <td>
      All cached<br /> variables synchronized on access?
    </td>
    
    <td>
      Yes
    </td>
    
    <td>
      From Java 5 onwards
    </td>
  </tr>
  
  <tr>
    <td>
      When synchronization happens
    </td>
    
    <td>
      When you explicitly enter/exit a <tt>synchronized</tt> block
    </td>
    
    <td>
      Whenever a volatile variable is accessed.
    </td>
  </tr>
  
  <tr>
    <td>
      Can be used to combined several operations into an atomic operation?
    </td>
    
    <td>
      Yes
    </td>
    
    <td>
      Pre-Java 5, no. Atomic get-set of<br /> volatiles possible in Java 5.
    </td>
  </tr><caption>Difference between synchronized and
  
  <br /> volatile</p> </caption>
</table>

具体看看效果可以参考下javaeye上的那篇文章<http://sakyone.javaeye.com/blog/668091>。我也试了下代码了。就不贴出来了。

另外这篇文章也对volatile作了很详细的介绍，深入了解可以参考下<http://www.ibm.com/developerworks/cn/java/j-jtp06197.html>。

总结出来关键之处就在于：

  1. **volatile关键字就是提示VM：对于这个成员变量不能保存它的私有拷贝，而应直接与共享成员变量交互。【all reads and writes will go straight to &#8220;main memory&#8221;】**
  2. **理解为什么volatile不能保证操作的原子性。[上面黑体字部分]**
