---
id: 1392
title: 通过构造Hash冲突实现PHP/Java等语言的拒绝服务攻击
date: 2012-01-03T23:58:26+00:00
author: tanglei
layout: post
duoshuo_thread_id:
  - 1351844048792453140
enable_highlight:
  - |
    <link rel="stylesheet" href="../wp-content/blogresources/highlightconfig/highlight.default.min.css">
    <script src="../wp-content/blogresources/highlightconfig/jquery-2.1.4.min.js"></script>
    <script src="../wp-content/blogresources/highlightconfig/enable_highlight.js"></script>
categories:
  - 工作那些事儿
tags:
  - DDOS
  - Java
  - PHP
  - 网络安全
---
前几天看到公司php群谈到这篇博文[通过构造Hash冲突实现各种语言的拒绝服务攻击](http://www.laruence.com/2011/12/29/2412.html),说的是在PHP中，使用hash来存储k-v数据, 包括常用的来自用户的POST数据, 攻击者可以通过构造请求头, 并伴随POST大量的特殊的”k”值(根据每个语言的Hash算法不同而定制), 使得语言底层保存POST数据的Hash表因为”冲突”(碰撞)而退化成链表. 这样一来, 如果数据量足够大, 那么就可以使得语言在计算, 查找, 插入的时候, 造成大量的CPU占用, 从而实现拒绝服务攻击. 举个例子：如下代码中：
  
```php
$size = pow(2, 16); // 16 is just an example, could also be 15 or 17
$startTime = microtime(true);
$array = array();
for ($key = 0, $maxKey = ($size &#8211; 1) * $size; $key <= $maxKey; $key += $size) {
    $array[$key] = 0; 
} 
$endTime = microtime(true); 
echo 'Inserting ', $size, ' evil elements took ', $endTime - $startTime, ' seconds', "\n";
$startTime = microtime(true);
$array = array();
for ($key = 0, $maxKey = $size - 1; $key <= $maxKey; ++$key) { 
    $array[$key] = 0;
} 
$endTime = microtime(true);
echo 'Inserting ', $size, ' good elements took ', $endTime - $startTime, ' seconds', "\n";
//http://www.laruence.com/2011/12/30/2435.html 
```
  
运行结果如下：
  
<a href="http://s1123.photobucket.com/albums/l549/tl3shi/?action=view&current=php_hash_collision.jpg" target="_blank"><img src="http://i1123.photobucket.com/albums/l549/tl3shi/php_hash_collision.jpg" border="0" alt="Photobucket" /></a>
  

  
这招太厉害了，拼接一个POST请求，用很小的成本就能搞垮服务器。因为当hashtable退化成线性的链表了，每插入一个元素就需要遍历全部元素。
  
有同事构造了一个400K的攻击文件试了一下国内某网站XX，XX的邮箱登录CGI多用了一分钟来处理构造的请求，可以认为攻击有效。前者是对照组，plain.txt是同样尺寸的正常数据，后者是构造的攻击数据，400K，3.2W个键值.如图示
  
<a href="http://s1123.photobucket.com/albums/l549/tl3shi/?action=view&current=php-ddos-hash-collision1.jpg" target="_blank"><img src="http://i1123.photobucket.com/albums/l549/tl3shi/php-ddos-hash-collision1.jpg" border="0" alt="Photobucket" /></a>

当然，发现这个漏洞后，PHP5.4是通过增加一个限制来尽量避免被此类攻击影响: &#8211; max\_input\_vars &#8211; specifies how many GET/POST/COOKIE input variables may be accepted. default value 1000.设置一个允许最大的的k-v个数。

Laruence说其他语言的比如java也中招了。有待达人给例子解释下。不过我试了试，java的数组本身大小支持不了多大，况且在用数组时已经先知道了array的size了。另外，java中servlet接受post等请求是用hashmap来保存的。我自己测试了下，通过类似的方法put(K,V);一个K是普通的，另一个K就是按照以上类似方法产生的。结果K的个数在Math.pow(2D, 19D);以及Math.pow(2D, 20D);时，乱序的K时间更少，Math.pow(2D, 18D)时，乱序的会用时多。(这两种情况每跑一遍结果都是这样)。更大的值就报OutOfMemoryError了。更小的值就差不多了(实测时用时多少两种方法不定)。求解释……
  
测试代码如下：

```java
public static void testHashmap() {
    HashMap<Long, String> map = new HashMap<Long,String>();
    HashMap<Long, String> map2 = new HashMap<Long,String>();
    double size = Math.pow(2D, 20D);
    long startTime = Calendar.getInstance().getTimeInMillis();
    long index = 0L ;
    for(long i = 0L ; i < size; i++) {
       map.put(i, "0");
       index++;
    } 
    long endTime = Calendar.getInstance().getTimeInMillis();
    System.out.println(index + " values, test 1 : " + (endTime-startTime));
    System.out.println("\---\---\---\---\---\---\---\---\---\---\---\---\----");
    startTime = Calendar.getInstance().getTimeInMillis();
    index = 0L ;
    for(Long i = 0L ; i < (size-1)*size; i+=size) { 
        map2.put(i, "0");
        index++;
    } 
    endTime = Calendar.getInstance().getTimeInMillis();
    System.out.println(index + " values ,test 2 : " + (endTime-startTime));
} 
```
