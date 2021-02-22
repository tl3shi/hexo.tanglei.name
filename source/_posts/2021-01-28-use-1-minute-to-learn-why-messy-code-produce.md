---
title: 1 分钟带你从 "�" 到 "锟斤拷"
layout: post
categories:
  - 经验技巧
tags:
  - 经验技巧
  - 程序员
---

> 关于作者：程序猿石头(ID: tangleithu)，现任阿里巴巴技术专家，清华学渣，前大疆后端 Leader。欢迎关注，交流和指导！
>
> 本文首发于微信公众号，[原文链接](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247491549&idx=1&sn=4eaf30256876f69342a98f47efb4015d&chksm=eb471e39dc30972fd886bbb68410421a03057d31bb109bd9296568bbeab29e0fcdf726456d1e#rd)，转载请全文保留。后台回复关键字 “1024” 获取程序员大厂面试指南。



![](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611463887247-image.png)

以一首七言绝句作为开篇：

手持两把锟斤拷

口中疾呼烫烫烫

脚踏千朵屯屯屯

笑看万物锘锘锘

## � 为何物？ 

在上次石头哥发的这篇文章中 —— [你可能也会掉进这个简单的 String 的坑](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&amp;mid=2247490188&amp;idx=1&amp;sn=19c2259724a855cdfac48855a870368d&amp;chksm=eb471b68dc30927eb17b1e5a999eebe808084a9f3aa64d3041f73dd3a8327ccc1d84353cf51f&token=1271081609&lang=zh_CN#rd)，讲述了因字符编码问题而连续踩坑的经历，文中有一个神奇的字符 “�”。

其实，这个 “�” 真是无处不在，比如大名鼎鼎的微信：

![微信中的�](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611463202818-image.png)

再比如，封面图中，单价22元的“锟斤拷锟斤拷”，再随便百度一把：

![随处可见的�](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611472402627-image.png)

要弄清这个问题，还得先从编码谈起。

因为在计算机的眼里，都是二进制，具体用哪些二进制数字表示哪个符号，这就是编码。不要把编码想象得太复杂，其实就是一个很简单的 mapping。

比如大家所熟知的 ASCII 编码，规定了
二进制的`0100 0001`，也就是十进制的`65`，代表的含义就是大写字母 `A`。

![ASCII 编码](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611468002769-image.png)

`�` 也是一种编码字符，就跟上面的 `A` 一样一样的，它是 UNICODE 编码方式中的一个特殊的字符，也就是 0xFFFD(65533)，语义是一个占位符(REPLACEMENT CHARACTER)，用来表达未知的，自己不认识的东西。

比如[上篇文章中的实验截图](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&amp;mid=2247490188&amp;idx=1&amp;sn=19c2259724a855cdfac48855a870368d&amp;chksm=eb471b68dc30927eb17b1e5a999eebe808084a9f3aa64d3041f73dd3a8327ccc1d84353cf51f&token=1271081609&lang=zh_CN#rd)的，红色部分圈出来的对应的字符，UTF-8 编码都不认识，所以按照 UNICODE 的定义，我就只好用统一的一个占位符 —— `0xFFFD(65533)` 来表示。

![](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611463348065-image.png)

## 为什么会出现“锟斤拷”？

我们接着上篇的例子来看， 如下图所示，仍然从 “程序猿石头” 对应二进制编码截取部分：

![](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611469093824-image.png)

如上图所示，第 18 行的字节数组 `new byte[] {-25, -119, -25, -116}`，`UTF-8` 恰好都不认识，因此只能用占位符替换。

![��](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611468920220-image.png)

这种情况，在编码转换过程中确实也比较常见，如果双方没沟通清楚，确实很容易出现互相不认识的情况。

在中文系统中，常见的字符编码是 GBK，这个时候，因为大家没提前商量清楚，我就默认按照 GBK 给你编码看看。

![](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611469240061-image.png)

![“锟斤拷”在此](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611469539054-image.png)

惊不惊喜意不意外……

其实是因为，`�` 用 `UTF-8` 编码后变成了 `0xEFBFBD`（就是上面的字节数组 `[-17, -65, -67]`），两个连起来就是 `0xEFBFBDEFBFBD`，也就是上面的字节数组`[-17, -65, -67, -17, -65, -67]`。

而 GBK 编码依然采用双字节编码方案，因此上面的 6 字节 `0xEFBFBDEFBFBD`，就被拆成了 3 个 2 字节字符即 `0xEFBF, 0xBDEF, 0xBFBD` 对应 GBK 编码里面就是：锟（0xEFBF），斤（0xBDEF），拷（0xBFBD）

<![0xEFBF](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611471892966-image.png),![0xBDEF](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611471932522-image.png),![0xBFBD](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611471809691-image.png)

现在，你知道了吗？

留个作业题：开篇的七言绝句，你知道另外的梗是来自哪里吗？欢迎留言讨论。

最近看到一份来自阿里巴巴开源的学习资料，涵盖了大前端、客户端、服务端、算法等多个技术领域，全书内容⻚数1600+，现在分享给大家，后台回复“阿里2020” 即可获取。

<![image](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611473548828-image.png),![image](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611473689783-image.png),![image](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-24/1611473625970-image.png)



> 关于作者：程序猿石头(ID: tangleithu)，现任阿里巴巴技术专家，清华学渣，前大疆后端 Leader，欢迎关注，交流和指导！
>
> 欢迎扫码加入互联网大厂内推群 & 技术交流群，一起学习、共同进步。后台回复关键字 “**0**” 送阿里技术大礼包。

