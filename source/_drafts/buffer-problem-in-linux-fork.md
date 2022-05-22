---
title: 找到了 Linux fork 的 Bug ？
layout: post
categories:
  - MyLife
tags:
  - 总结
  - MyLife

---

> 关于程序员石头(ID: tangleithu)：从十八县贫困农村一路逆袭上**清华**（[点这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），BAT某厂P7，是前大疆（无人机）技术主管。
>
> 本文首发于微信公众号，[原文链接]()，转载请全文保留。后台回复关键字 “1024” 获取程序员大厂面试指南。

## 背景 

大家好，我是石头哥。 

今天的文章估计你也会踩到坑里，信不信？

来看这段代码？

![image-20220521122602936](/Users/tanglei/github/hexo.tanglei.name/resources/buffer-problem-in-linux-fork/image-20220521122602936.png)

很简短的一段代码，对吧？

[我很多年前就知道了](https://mp.weixin.qq.com/s?__biz=MzkzNTI1NjYxNg==&mid=2247484094&idx=1&sn=7a694cb5034bc188675985d227d79563&chksm=c2b1f5f9f5c67ceff86c78ca8889dfe85f595b83590ae903f3fe34e5bcf08c7f9a8fac223bc1&scene=21#wechat_redirect)， `fork()` 函数是用来创建子进程的，一次调用，两次返回。在子进程中返回的`pid=0`，父进程中返回的是子进程的实际的pid，子进程是从fork()之后执行的。

那么问题来了，`Hello, 程序员石头` 打印几次？

思考几秒钟~ 🤔

## 答案

既然，子进程是从`fork` 后开始执行的，自然`Hello, 程序员石头` 只会打印一次，对吧。 

当然，既然在这样问题，答案可能就是“反常”的，如下图：

![](/resources/buffer-problem-in-linux-fork/gcc-double-print-hello-tangleithu.gif)

居然打印了 2 次！是不是很神奇？

难道第 8 行的代码执行了两遍？不会是 fork 有 bug 吧？应该不可能，不过你有啥简便的方法能证伪么？

## 继续探究

我们再改一下代码的第 8 行，加个`\n`，再看看？

![image-20220521222157189](/Users/tanglei/github/hexo.tanglei.name/resources/buffer-problem-in-linux-fork/image-20220521222157189.png)



结果只打印了一次了。

![](/Users/tanglei/github/hexo.tanglei.name/resources/buffer-problem-in-linux-fork/gcc-single-print-hello-tangleithu.gif)

当然，因为一个`\n` 的不同，导致结果的不同。你大概应该能猜到了，应该是缓冲区的问题。

`fork()` 函数创建子进程时，操作系统会在进程表中为该进程建立新的表项，子进程与父进程共享代码段，但数据空间是相互独立的。

`fork` 出来的子进程数据空间的内容是父进程的完整拷贝，执行上下文（包括程序计数器）也完全相同。因此，子进程会接着父进程执行的地方继续执行。

默认情况下 `printf `其实是将内容输出到标准输出流，fork后，子进程其实也一样，但因为标准输出流（stdout）在指向终端（terminal）时是行缓存，即遇到换行符`\n`时会强制刷新缓存。

比如，我们再改改代码，去掉 `\n`，强制 flush 标准输出。

![image-20220521224423747](/Users/tanglei/github/hexo.tanglei.name/resources/buffer-problem-in-linux-fork/image-20220521224423747.png)

也会得到一样的答案（只打印1次），演示过程如下图：

![主动 flush，只打印一次](/Users/tanglei/github/hexo.tanglei.name/resources/buffer-problem-in-linux-fork/flush-single-print.gif)

## 行缓存，全缓存

其实，在 标准C 中的缓存除了有行缓存外，还有全缓存，当然还有不缓存。

- 行缓存：即每行（遇到换行符`\n`）刷缓存一下，刷缓存就是把缓存内容写出去。
- 全缓存：当缓存满时才会刷缓存内容；

当然当程序结束时，exit 或从 main 函数 return，或者强制 fflush，都会刷缓存。

我们再回到行缓存，第 8 行还是用`\n`，即：

```cpp
printf("%s, pid=%d\n", str, getpid());
```

我们再看看，假设用管道会怎样？输出到文件又会怎样？

![试试管道或文件](/Users/tanglei/github/hexo.tanglei.name/resources/buffer-problem-in-linux-fork/test-pipe-and-file.jpg)

神奇的地方来了吧， 用管道或输出到文件，即使加上 `\n` 也仍然会输出 2 遍。

因为用管道或者重定向到文件，其实都是属于上面的“全缓存”，即程序最终结束的时候，才刷缓存，因此子进程也有一份。完整的演示内容如下：

![试试管道或文件](/Users/tanglei/github/hexo.tanglei.name/resources/buffer-problem-in-linux-fork/test-pipe-and-file.gif)

好了，今天文章就到这里，很基础但却容易忽视，刻意花了不少时间做了动图，还请大家多多分享支持。


## 总结

其实，今天的内容在经典书籍 ——《UNIX环境高级编程》中就有实例讲解了这个例子，如下图所示：

![APUE Demo](/Users/tanglei/github/hexo.tanglei.name/resources/buffer-problem-in-linux-fork/APUE-demo.png)

经典书籍还是应该多读读。确实，不管上层应用、各种技术框架千变万化，底层基础技术始终就是哪些内容啊。

后面的文字，其实是模板每次带上的，一方面为了引流，另外一个方面，确实如果能帮助到读者，就再好不过了。记住我说的，如果有心进大厂，搞头文末资料，基本问题不会太大。

看到这里，真心希望你能帮忙点赞、分享支持一下，😝这将是我持续输出优质文章的最强动力！

我是石头哥，咱们下期再见！

推荐阅读：

- [Google 工程师面试指南.pdf-免费下载](https://mp.weixin.qq.com/s/OGJhxM7FdeoIkAL2-uUI_Q)
- [清华计算机系王牌课程——《数据结构》课件及源码包下载](https://mp.weixin.qq.com/s/iRcyW1dEeCxleTfOTyr2Lw)
- [BAT大佬写的 1300 页 Leetcode刷题笔记，必须收藏！](https://mp.weixin.qq.com/s/7T9R9kFXke986vSoPNzC8g)

> 关于程序员石头(ID: tangleithu)，从十八县贫困农村一路逆袭上清华（[点击这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），目前在BAT某厂打工，是前大疆（无人机）技术主管。
>
> 欢迎扫码加入互联网大厂内推群 & 技术交流群，一起学习、共同进步。后台回复关键字 “**0**” 送阿里技术大礼包。