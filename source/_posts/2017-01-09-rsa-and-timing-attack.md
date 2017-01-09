---
title: RSA算法流程和计时攻击
layout: post
categories: 
  - 学到老
tags: 
  - 网络安全
  - 经验技巧
---

RSA 算法一种常见的非对称加密算法, 常用来对一些在网络上传输的敏感信息进行加密, 本文将概述RSA算法的流程以及一种意想不到的"旁门左道"的攻击方式. 

## RSA 

RSA 算法流程如下, 

1. 找到互质的两个数, `p` 和 `q`, 计算 `N = p*q`
1. 确定一个数 `e`, 使得 `e` 与 `(p-1)(q-1)` 互质, 此时公钥为 `(N, e)`, 告诉给对方
2. 确定私钥 `d`, 使得 `e*d-1`能够被`(p-1)(q-1)`整除
3. 消息传输方传输消息 `M`, 加密密文`C`为: $C = M^e \mod N$
4. 消息接受方通过收到密文消息 `C`, 解密消息 `M`: $M= C^d \mod N$

RSA算法依赖于欧拉定理, 一个简化版本为大致为 `a` 和 `p` 互质, 那么有, 
 
$ a^{p-1} \equiv 1 \mod p$, `a` 的 `p-1` 次方 对 `p` 取余为`1`, (`a` 的 `p-1`次方减去`1`可以整除 `p`).

欧拉定理的证明比较复杂，本来有一个绝妙的证明方式的, 但由于微信公众号字数有限, 这里就省略了(什么? 这跟费马有什么关系? 实在要看的可以看文末参考资料)

举个例子

`N = pq`, 取俩素数 `p=11, q = 3, N = p * q = 33`, 取 `e` 与 `(p-1)(q-1) = 20` 互质的数 `e = 3`, 然后通过 $ed \equiv 1 \mod (p-1)(q-1)$ 确定私钥, 
即取一个 `d` 使得 `3*d -1` 能 20 被整除, 假设取 `d=7` 或者`d=67`. (`3*7-1=20` 当然能被20整除, `3*67-1=200` 也能被20整除)

因此 public key 为 `(N=33, e=3)`, private key 为 `d=7` 或者`d=67`, 
假设加密消息`M=8`, 
通过加密算法 $C = M^e \mod N$ 
得到密文 `C=8^3 % 33 = 17`

再来看解密, 由$M= C^d \mod N$, 得到明文 `M = 17^7 % 33 = 8` 或者 `M=17^67 % 33=8`, 是不是很神奇? (这里`^` 表示多少次方, 后文中的有的表示异或)

(来, 安利一个计算器的工具, `bc` 命令, 支持任意精度的计算, 其实 Mac简单的计算就可以通过前面介绍的 [Alfred](https://www.tanglei.name/blog/app-in-mac-preface.html) 可以方便得完成)

![linux计算器](/resources/rsa-and-timing-attack/bc-calculate.png)


## RSA 破解

如果需要破解 RSA 的话, 就是需要找到 `p` 和 `q`, 使得 `pq=33`, 如果知道了 `p` 和 `q` 就能通过公钥 `N` 和 `e` 反推出私钥 `d` 了. 然而大数分解在历史以来就一直是数学上的难题. 
当然上面所述的案例较简单, 当 N 很大时, 就特别困难了. 曾经有人花了五个月时间分解了这个数`39505874583265144526419767800614481996020776460304936454139376051579355626529450683609727842468219535093544305870490251995655335710209799226484977949442955603`(159位数), RSA-155 (512 bits) [from wikipedia].

这条路走不通, 就有人走了"旁门左道"了, Stanford 的几个研究者用了两个小时破解了 OpenSSL 0.9.7 的 1024-bit 的 RSA 私钥 (感兴趣的同学可以看他们的论文*Remote Timing Attacks are Practical*), 
用到的方法就是后面提到的时序攻击(或译为"计时攻击"), 主要思想是因为在进行加密时所进行的模指数运算是一个bit一个bit进行的, 而bit为1所花的运算比bit为0的运算要多很多(耗时久)，
因此可以通过得到大量消息与其加密时间, 然后基于统计的方法就可以大致反推出私钥的内容.

## 计时攻击(Timing Attack)

计时攻击是边信道攻击(或称"侧信道攻击", Side Channel Attack, 简称SCA) 的一种, 主要是一种利用不同的输入会有不同的执行时间这个特点. 
举个具体的例子, 这个来自playframewok 里用来验证cookie(session)中的数据是否合法(包含签名的验证), 也是我写这篇文章的由来.

```scala
def safeEquals(a: String, b: String) = {
  if (a.length != b.length) {
    false
  } else {
    var equal = 0
    for (i <- Array.range(0, a.length)) {
      equal |= a(i) ^ b(i)
    }
    equal == 0
  }
}
```

刚开始看到这段源码感觉挺奇怪的, 这个函数的功能是比较两个字符串是否相等, 首先长度不等肯定不等, 立即返回这个是可以理解的, 
可是后面的代码得发挥下想象力了, 当然这个逻辑还是好懂: 通过异或操作`1^1=0, 1^0=1, 0^0=0`, 如果每一 bit 都相等的话, 两个字符串肯定相等, 最后的`equal`肯定为0, 否则为1. 
但从效率角度上讲, 不是应该只要中途发现某一位的结果为1了就可以立即返回 false 了吗? (如下所示) 

```scala
for (i <- Array.range(0, a.length)) {
  if (a(i) ^ b(i) != 0) // or a(i) != b[i]
    return false
}
```

结合方法名称 `safeEquals` 可能知道些眉目, 与安全有关, 延迟计算等提高效率的手段见过不少, 但这种延迟返回的还是很少见.
这种手段可以让调用 `safeEquals("abcdefghijklmn", "xbcdefghijklmn")` 和调用 `safeEquals("abcdefghijklmn", "abcdefghijklmn")` 的所耗费的时间一样, 
防止通过大量的改变输入并通过统计运行时间来暴力破解出要比较的字符串, 这里其实都忽略了对比较字符串长度的attack问题. 

举个例子, 假设某个用户设置了密码为 `password`, 通过从a到z(实际范围可能更广)不断枚举第一位, 最终统计发现 `p0000000` 的运行时间比其他从任意`a~z`的都短, 
这样就能猜测出用户密码的第一位很可能是`p`, 然后再不断一位一位迭代下去最终破解出用户的密码. 如果密码通过hash加密后也能通过这种攻击方式得到hash后的密文. 

当然, 从理论角度上讲这个确实容易理解, 如上文所提到的学术界已经有论文发表指出用这种计时攻击的方法破解了 OpenSSL 0.9.7 的RSA加密算法了.
然而在实际中是否存在这样的攻击问题呢? 
因为好像通过统计运行时间总感觉不太靠谱, 这个运行时间对环境太敏感了, 比如网络, 内存, CPU负载等等都会影响. 
尽管如此, 各个软件的实现也都采用了这种 `safeEquals` 的方法.

`JDK 1.6.0_17` 中的[Release Notes](http://www.oracle.com/technetwork/java/javase/6u17-141447.html)中就提到了`MessageDigest.isEqual` 中的bug的修复

|BugId  | Category  |  Subcategory | Description |
|----|----|----|----|
|6863503 |java |   classes_security    | SECURITY: MessageDigest.isEqual introduces timing attack vulnerabilities|

这次变更的diff详细信息[来源](http://hg.openjdk.java.net/jdk6/jdk6/jdk/rev/562da0baf70b)为: 

![MessageDigest.isEqual计时攻击](/resources/rsa-and-timing-attack/MessageDigest.isEqual.timing-attack.png)

为了防止(特别是与签名/密码验证等相关的操作)被 **timing attack**, 目前各大语言都提供了响应的安全比较函数, 例如 "世界上最好的编程语言" -- php中的: 

```php
// Compares two strings using the same time whether they're equal or not.
// This function should be used to mitigate timing attacks; for instance, when testing crypt() password hashes.
bool hash_equals ( string $known_string , string $user_string )

//This function is safe against timing attacks.
boolean password_verify ( string $password , string $hash )
```

各种语言版本的实现方式都与上面的版本差不多, 将两个字符串每一位取出来异或(`^`)并用或(`|`)保存, 最后通过判断结果是否为0来确定两个字符串是否相等. 

参考资料: 

- [Timing Attacks on RSA: Revealing Your Secrets through the Fourth Dimension](http://www.cs.sjsu.edu/faculty/stamp/students/article.html)
- [Remote Timing Attacks are Practical](http://crypto.stanford.edu/~dabo/papers/ssl-timing.pdf) 
- [RSA算法原理](http://www.ruanyifeng.com/blog/2013/07/rsa_algorithm_part_two.html)
- [费马小定理](https://zh.wikipedia.org/wiki/%E8%B4%B9%E9%A9%AC%E5%B0%8F%E5%AE%9A%E7%90%86)


p.s 如果你觉得这文章对你有那么一点点收获, 请不要犹豫扫描下面二维码关注我的公众号, 如果你再能帮忙转发一下就更好了. 么么哒.

<script type="text/javascript"
 src="//cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
 </script>

<script type="text/javascript">
MathJax.Hub.Config({
  tex2jax: {
    inlineMath: [['$','$'], ['\\(','\\)']],
    skipTags: ['script', 'noscript', 'style', 'textarea', 'pre'],
    processEscapes: true
  }
});
 </script>