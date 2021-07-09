---
title: 公司搞了 Web 安全测评，挂了
layout: post
categories:
  - MyLife
tags:
  - 总结
  - MyLife
---

> 关于作者：程序猿石头(ID: tangleithu)，从十八县贫困农村一路逆袭上**清华**（[点这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），BAT某厂P7，是前大疆（无人机）技术主管。
>
> 本文首发于微信公众号，[原文链接](https://mp.weixin.qq.com/s/xZupdbSqaPSpwE4fnHMqew)，转载请全文保留。后台回复关键字 “1024” 获取程序员大厂面试指南。



![安全考试不合格](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-28/1624893065686-%E5%AE%89%E5%85%A8%E8%80%83%E8%AF%95%E4%B8%8D%E5%90%88%E6%A0%BC.png)

## 背景

大家好，我是石头哥。

前几天偶然翻了翻之前的笔记，发现当年做过一个 Web 安全的测评。

>我摊牌了，实际上是不知道写啥大家感兴趣的内容，所以刻意翻了翻之前的笔记 o(╥﹏╥)o ，小伙伴们有想了解的话题可以告诉我哦。

![Web安全测评结果](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-24/1624544506884-image.png)

上图是测评结果。作为一个后端程序猿（特别是做 Web 后端服务），对一些常见的 Web安全漏洞，必须要了如指掌。

不然，写了个有安全漏洞的接口，放在互联网上，后果不堪设想呀。比如，之前我们团队就有个安全漏洞的接口，直接被攻破（还好是被公司安全扫描组件扫出来）导致丢失了服务器控制权 —— [一行代码引来的安全漏洞就让我们丢失了整个服务器的控制权
](https://mp.weixin.qq.com/s/84Gg4PcJeDyPTS-IjF89gA)

![漏洞演示](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-24/1624545860737-%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20210624224349.gif)

各种常见的安全漏洞分析和原理，大家肯定也多多少少从网上看到不少了。

今天，我们强调实战，毕竟，实践出真知，不要“纸上谈兵”。也许虽然你知道大概原理，到实战就嗝屁了。

实战才会更有意思。石头哥曾经为了学习实战，就去给各大网站报过漏洞（传说中的白帽子），还领过不少奖励呢。

## 常见安全漏洞

比如前文提到的：

- 跨站脚本：XSS（Cross-Site Scripting），又分为存储型、反射型等等。
- 跨站请求伪造：XSRF/CSRF（Cross-site request forgery），也被称为：one click attack/session riding。攻击者盗用了你的身份，以你的名义发送恶意请求。
- SQL注入：这个不用多说了。
- 文件上传：比如限制的上传文件类型不严格，导致带来风险。比如结合路径遍历（或文件包含）漏洞，可能活脱脱提供一个webshell功能。
- 路径遍历：对用户请求某个路径没限制，可以任意拼接服务器本地文件，导致泄露文件信息等（比如某些重要的数据库配置文件等）。
- 越权访问：比如未授权访问其他用户信息。
- 信息泄露：举个例子，比如常见的 web后台异常信息输出，把数据库表结构等都泄露了。再比如，一些业务数据，例如常见的用户id可能是递增的数字，就可能轻易暴露用户数据或提供爬虫暴力遍历信息。
- 命令执行：前文提到的[一行代码引来的安全漏洞就让我们丢失了整个服务器的控制权
](https://mp.weixin.qq.com/s/84Gg4PcJeDyPTS-IjF89gA) 其实就是一种，用户输入任意命令，可以直接在服务器上执行。
- 社会工程学：这个就是安全意识了，比如你曾经是否把生日等等作为密码？
- 业务漏洞：这个也比较常见，比如常见的注册登录，是否有限流？是否可能导致“撞库”泄露信息。

以上就是一些最常见基本的安全漏洞，我认为每个后端程序员，特别是搞 Web后端的，都应该有所了解。最好通过实战的方式，加深理解。

这不，石头哥刻意去找了类似可供大家进行实战的项目。

## 实战 

DVWA 就是其中一个，官方地址是：https://dvwa.co.uk/。

DVWA，全程 “Damn Vulnerable Web Application” ，是一个 PHP/MySQL 技术栈的 Web 应用。这个应用囊括了各种安全漏洞，供开发者进行实战，且还有不同的安全级别。

大家注意，测试时，最好在本地开虚拟机或者断网测试，不要用线上（比如云服务）进行测试，不然可能会被各种安全漏洞扫描的爬虫给抓住。

安装方式很简单，下载代码，装个 Apache 之类的，按照官网教程，运行setup 即可。

我这里从网上白嫖了一两个小时的实验容器，供大家参考。

![](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-19/1624110322395-image.png)

应用安装好后，启动服务，即可访问这个 Web 应用：

![](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-19/1624110576194-image.png)

登录进去后，左边就是各种漏洞分类，咱们挑几个测试测试。

### 命令注入

![提供 ping 服务](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-19/1624110928258-image.png)

比如该应用提供 ping 某个地址的服务，后台直接拿用户输入就开搞。

随便输入 `;` 再加个 `echo` 命令就成功了。

![命令注入成功](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-19/1624111130517-image.png)

相当于直接提供一个 WebShell 供大家使用。

### 路径遍历/文件包含

![提供读取文件内容服务](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-19/1624111471520-image.png)

如上图所示，正常提供了一个提供读取（并执行）文件内容的服务。

![正常读取（并执行）文件内容](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-19/1624111493085-image.png)

稍微观察下，直接 `url` 后面跟文件名即可。

其实，这里还暴露了一个 “信息泄露”，文件名递增，果然就猜中了。（你们用户系统的id是不是递增的？有没有直接暴露在公网？）

![路径遍历、文件包含 漏洞](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-19/1624111527566-image.png)

还可以结合前面的命令注入漏洞看对应目录具体有哪些文件（这里就不演示了）。

比如，对应目录有个 "codershitou.php" 文件，直接通过修改 `url` 又能访问其中的内容了。

![路径遍历泄露敏感文件](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-19/1624111819488-image.png)

还能引入远程文件，比如引入一个之前搞的小霸王游戏地址：“http://games.coderstone.cn/”

![文件包含，引入外部内容](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-19/1624111923686-image.png)

因为这里其实还会被 Apache 解释执行，所以这里还可以引入一个外部的 php 可执行文件，做成一个 “钓鱼” 网站。

### SQL 注入

![查询用户信息](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-19/1624112606715-image.png)

提供了一个正常查询用户信息的服务。

试试，SQL 注入，直接脱库了。

![SQL注入](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-19/1624112715957-image.png)

看看源码，就知道了吧？直接字符串拼接。

![SQL注入的源代码](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-19/1624113037987-image.png)

这个时候，你成功攻入后，应该尝试去修改对应漏洞的代码，用相同的方式，攻不进来。

### XSS 

再来个存储型的 XSS 玩玩。

![XSS 留言板](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-19/1624113525538-image.png)

提交后，直接 `alert` 出来了，每个人访问这个页面（刷新），都弹窗。

![XSS 留言板漏洞](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-19/1624114389547-xss-store-demo.gif)

去改代码，进行过滤吧。

其他的还有 CSRF，文件上传等等漏洞，等你来玩。这里就不带着大家一个一个去解析了，建议大家去实践，有问题欢迎讨论。

## 后记

安全问题真的不容忽视，评论区讲讲你之前遇到过的安全漏洞？

另外，我之前收藏的一个IT职业技能图谱（安全工程师），若感兴趣可以在公众号后台回复 “安全” 领取完整高清图谱，整图太大会被压缩，这里给出 Web 安全的部分供大家参考。

![安全工程师技能图谱 —— Web安全](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-6-25/1624552151229-image.png)

最近秋招即将来袭，特此分享校招面经：
- [本科学妹斩获BAT SP Offer](http://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247492598&idx=1&sn=5904b3800a2091ad4215aaf156d59133&chksm=eb44e212dc336b04c37320664cb3bd4c036b1e2329810b91d393e100b9a34f495194d05c15f7#rd)
- [6个大厂Offer，牛逼！](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247491218&idx=1&sn=e20fe76a2ba3e4f9986c7a1fe9d93995&chksm=eb471f76dc309660a3599c9ea11043a807ec48a81be76565a516fe989e63e8b9a6d5dce25bc6&token=623576504&lang=zh_CN&scene=21#wechat_redirect)
- [非科班学弟如何转行斩获 ATM 大厂的 Offer ？](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247489734&idx=1&sn=f9172000b917ea4e81f4e8b3b2afa1e3&chksm=eb471922dc309034064a0420eeb9c21fca533f387a5a9a5bfbd0f25313d134753e490774bb9c&token=1659374559&lang=zh_CN&scene=21#wechat_redirect)
- [羡慕，又一清华学弟斩获 6 个大厂 SSP Offer | 面经分享](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247490412&idx=1&sn=2512cb07a969ff50222c363dd7a6874a&chksm=eb471a88dc30939ee95067ad13447e8b9e579f719d8a89deb95ff56ae81b0447ae2c86efcbaf&token=1659374559&lang=zh_CN&scene=21#wechat_redirect)
- [一个读者大佬精心总结的阿里、腾讯、宇宙条大厂 Offer 面经和硬核面试攻略](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247491116&idx=1&sn=676c6dab8dbb095a31e6fb45cb31a828&chksm=eb471fc8dc3096dea5f1a8600fdc9163d3ce228e640ddb93fad310d44e739f9d719d0722efd7&token=1903173876&lang=zh_CN&scene=21#wechat_redirect)

有收获，别忘三连

> 关于作者：程序猿石头(ID: tangleithu)，从十八县贫困农村一路逆袭上清华（[点击这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），目前在BAT某厂打工，是前大疆（无人机）技术主管。
>
> 欢迎扫码加入互联网大厂内推群 & 技术交流群，一起学习、共同进步。后台回复关键字 “**0**” 送阿里技术大礼包。