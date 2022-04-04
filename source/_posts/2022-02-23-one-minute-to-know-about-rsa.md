---
title: 一分钟了解 RSA 算法是什么鬼？
layout: post
categories:
  - MyLife
tags:
  - 总结
  - MyLife
---

> 关于作者：程序猿石头(ID: tangleithu)，从十八县贫困农村一路逆袭上**清华**（[点这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），BAT某厂P7，是前大疆（无人机）技术主管。
>
> 本文首发于微信公众号，[原文链接](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247499787&idx=1&sn=b3d7c199fc656dff698e134dc03d877e&chksm=eb44c1efdc3348f9fb5e8a500d9db2afeb8db6feec924e6384b1376c20f2d94110b44566c4b7&token=1931883326&lang=zh_CN#rd)，转载请全文保留。后台回复关键字 “1024” 获取程序员大厂面试指南。

## 背景

大家好，我是石头哥。

RSA 算法大家肯定都听说过了，它是一种常见的非对称加密算法，常用来对一些在网络上传输的敏感信息进行加密。

但具体流程不知道大家清楚不？本文将概述 RSA 算法的流程以及一种意想不到的"旁门左道"的破解方式。

## RSA 算法流程 

具体算法流程如下：

1. 找到互质的两个数， `p` 和 `q`， 计算 `N = p*q`
2. 确定一个数 `e`， 使得 `e` 与 `(p-1)(q-1)` 互质， 此时公钥为 `(N, e)`， 告诉给对方
3. 确定私钥 `d`， 使得 `e*d-1`能够被`(p-1)(q-1)`整除
4. 消息传输方传输消息 `M`， 加密密文`C`为: $C = M^e \mod N$
5. 消息接受方通过收到密文消息 `C`， 解密消息 `M`: $M= C^d \mod N$

RSA算法依赖于欧拉定理，一个简化版本为大致为 `a` 和 `p` 互质，那么有， 

$ a^{p-1} \equiv 1 \mod p$， `a` 的 `p-1` 次方 对 `p` 取余为`1`，（`a` 的 `p-1`次方减去`1`可以整除 `p`）

欧拉定理的证明比较复杂，可以参考下文末的参考资料。

## 举个例子

`N = pq`， 取俩素数 `p=11, q = 3, N = p * q = 33`， 取 `e` 与 `(p-1)(q-1) = 20` 互质的数 `e = 3`， 然后通过 $ed \equiv 1 \mod (p-1)(q-1)$ 确定私钥， 
即取一个 `d` 使得 `3*d -1` 能 20 被整除， 假设取 `d=7` 或者`d=67`。 （`3*7-1=20` 当然能被20整除， `3*67-1=200` 也能被20整除）

因此 public key 为 `(N=33, e=3)`， private key 为 `d=7` 或者`d=67`。

假设加密消息`M=8`， 通过加密算法 $C = M^e \mod N$，得到密文 `C=8^3 % 33 = 17`。

再来看解密， 由$M= C^d \mod N$， 得到明文 `M = 17^7 % 33 = 8` 或者 `M=17^67 % 33=8`， 是不是很神奇? （这里`^` 表示多少次方，后文中的有的表示异或）

>来， 安利一个计算器的工具， `bc` 命令， 支持任意精度的计算， 其实 Mac简单的计算就可以通过前面介绍的 [Alfred](https://mp.weixin.qq.com/s?__biz=MzkzNTI1NjYxNg==&mid=2247483920&idx=1&sn=a739ba4173f029c7fe2f6bd4d08a5270&chksm=c2b1f557f5c67c417dacab347d1104446514be3e4531ffb4933be17adcbceebe1fc0c51af6fa&token=1375203675&lang=zh_CN#rd) 可以方便得完成。

![linux计算器](https://www.tanglei.name/resources/rsa-and-timing-attack/bc-calculate.png)


## RSA 破解

如果需要破解 RSA 的话，就是需要找到 `p` 和 `q`， 使得 `pq=33`， 如果知道了 `p` 和 `q` 就能通过公钥 `N` 和 `e` 反推出私钥 `d` 了。

当然上面所述的案例较简单，当 N 很大时，就特别困难了。大数分解在历史以来就一直是数学上的难题。

曾经有人花了五个月时间分解了这个数`39505874583265144526419767800614481996020776460304936454139376051579355626529450683609727842468219535093544305870490251995655335710209799226484977949442955603`(159位数)， RSA-155 (512 bits) [from wikipedia]。

这条路走不通， 就有人走了"旁门左道"了， Stanford 的几个研究者用了两个小时破解了 OpenSSL 0.9.7 的 1024-bit 的 RSA 私钥 (感兴趣的同学可以看他们的论文`Remote Timing Attacks are Practical`)，用到的方法就是后面提到的时序攻击(或译为"计时攻击")。

## 计时攻击(Timing Attack)

计时攻击是边信道攻击(或称"侧信道攻击"，Side Channel Attack，简称 SCA) 的一种， 主要是一种利用不同的输入会有不同的执行时间这个特点进行的。 

刚开始看到这个，我还是大为震惊的。凭直觉想，感觉要实际应用起来干扰项太多了，是不是可以直接忽略？

不过，看到上述论文有实际攻破成功的案例，以及各大编程语言纷纷补丁来看，这样做还是非常需要的，至少是“政治”正确的。

例如 JDK 1.6.0_17 中的Release Notes 中就提到了 
`MessageDigest.isEqual`中的 bug 的修复，如下图所示：

![MessageDigest.isEqual计时攻击](https://www.tanglei.name/resources/rsa-and-timing-attack/MessageDigest.isEqual.timing-attack.png)

关于这个话题，更多内容可以参考我之前写的这篇文章 —— [这 10 行比较字符串相等的代码给我整懵了，不信你也来看看](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247485939&idx=1&sn=cad3cf49aa345783a93ce5d9b631ba1d&chksm=eb470817dc308101c95aff74fa63d530f02bef50f91ba18d4ff25b8715933a404bd03ffc8b7b&token=44584916&lang=zh_CN#rd)


参考资料: 

- [Timing Attacks on RSA: Revealing Your Secrets through the Fourth Dimension](http://www.cs.sjsu.edu/faculty/stamp/students/article.html)
- [Remote Timing Attacks are Practical](http://crypto.stanford.edu/~dabo/papers/ssl-timing.pdf) 
- [RSA算法原理](http://www.ruanyifeng.com/blog/2013/07/rsa_algorithm_part_two.html)
- [费马小定理](https://zh.wikipedia.org/wiki/%E8%B4%B9%E9%A9%AC%E5%B0%8F%E5%AE%9A%E7%90%86)

## 后记

其他校招经验分享：

- [校招分享合集](https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzI3OTUzMzcwNw==&action=getalbum&album_id=1551696282304495619&scene=173&from_msgid=2247489734&from_itemidx=1&count=3&nolastread=1#wechat_redirect)
- [Google 工程师面试指南.pdf-免费下载](https://mp.weixin.qq.com/s/OGJhxM7FdeoIkAL2-uUI_Q)
- [清华计算机系王牌课程——《数据结构》课件及源码包下载](https://mp.weixin.qq.com/s/iRcyW1dEeCxleTfOTyr2Lw)
- [BAT大佬写的 1300 页 Leetcode刷题笔记，必须收藏！](https://mp.weixin.qq.com/s/7T9R9kFXke986vSoPNzC8g)

如果你觉得这文章对你有那么一点点收获，请不要犹豫点击文末名片关注我的公众号，如果你再能帮忙三连一发，我就当你给我赞赏了66.6元。


> 关于作者：程序猿石头(ID: tangleithu)，从十八县贫困农村一路逆袭上清华（[点击这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），目前在BAT某厂打工，是前大疆（无人机）技术主管。
>
> 欢迎扫码加入互联网大厂内推群 & 技术交流群，一起学习、共同进步。后台回复关键字 “**0**” 送阿里技术大礼包。