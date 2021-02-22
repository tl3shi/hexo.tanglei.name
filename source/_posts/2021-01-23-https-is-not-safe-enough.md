---
title: 上班时间摸鱼，你以为公司就不知道了？
layout: post
categories:
  - 经验技巧
tags:
  - 经验技巧
  - 网络安全
---


> 关于作者：程序猿石头(ID: tangleithu)，现任阿里巴巴技术专家，清华学渣，前大疆后端 Leader。欢迎关注，交流和指导！
>
> 本文首发于微信公众号，[原文链接](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&amp;mid=2247491331&amp;idx=1&amp;sn=5f6167f4f7ec08e8255abe40535050b9&amp;chksm=eb471ee7dc3097f1fd69e4c335f2697d0f601f25c4ca55b30aa2576c3c07fbc2961b1fb8cb6c&token=2047392263&lang=zh_CN#rd)，转载请全文保留。后台回复关键字 “1024” 获取程序员大厂面试指南。

![](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610892037424-image.png)

## 背景 

最近发生了几个事情，想必你已经看到过了：

- **网传** 某PDD员工在某匿名社区发布同事被抬上救护车的照片被抓出来并辞退？

- 某运营同学在试用期期间因为在工作期间上了某 1024 网站，导致试用期不过。（恰好今天浏览到一个知乎问题）

![试用期不过因在公司浏览 1024 网站](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610872728007-image.png)

- 前两天还看到不少公众号推文，大意是：看小电影前一定要注意网址是不是 HTTPS 的，因为 HTTPS 是加密的，别人就不知道了。

看到上面几个问题，我不禁想问（这脑回路也是……）：

- 通过浏览器访问 HTTPS 站点，其他人知道吗？ 
- 通过 App 访问匿名论坛（HTTPS），公司知道么？（他是不是接入了公司 WiFi?）

总之就是，上班时间上网摸鱼吗？哪怕用 HTTPS 问，如果公司知道，是通过什么手段？

本文谈谈我的看法，主要分为以下几个方面：

- HTTPS 为什么安全。
- HTTPS 真的安全吗？
- App 如何保证信息安全，不被爬走？
- 公司可能的监控手段有哪些？我们应该怎么做？

## HTTPS 为什么安全

HTTPS，也称作 HTTP over TLS，TLS 前身是SSL，会有各个版本。

![TLS协议在TCP/IP协议栈中的关系](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610876131024-image.png)

上图描述了在TCP/IP协议栈中TLS(各子协议）和 HTTP 的关系。HTTP+TLS 也就是 HTTPS，和 HTTP 相比，HTTPS的优势：

- 数据完整性：内容传输经过完整性校验
- 数据隐私性：内容经过对称加密，每个连接生成一个唯一的加密密钥
- 身份认证：第三方无法伪造服务端（客户端）身份

上面内容参考了[HTTPS工作原理](https://cattail.me/tech/2015/11/30/how-https-works.html "HTTPS工作原理")。（石头在N 久前用印象笔记收藏的，现在好多原文访问不了了）

![HTTPS 原理](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610875482092-image.png)

上图就是大致介绍了 HTTPS 的握手流程，感兴趣的同学可以用 WireShark 抓包详细看看其中的每一个步骤，有助于理解 HTTPS 的完整流程。这里，我就不详述了，可以参考下[小林的这篇图解 HTTPS](https://mp.weixin.qq.com/s/U9SRLE7jZTB6lUZ6c8gTKg)，很详细；石头在 14 年也写过一篇抓包分析的文章。 [Mac/Windows Wireshark/tcpdump抓包TCP 3次握手,4次挥手实例](https://www.tanglei.name/blog/example-show-3-times-handshaking-of-tcp-in-mac-or-windows.html "Mac/Windows Wireshark/tcpdump抓包TCP 3次握手,4次挥手实例")

大致就是客户端和服务端通过“握手会谈”商量出一个双方支持的加密算法和相应随机参数，得到一对密钥，后续的传输的内容都通过这对密钥进行加解密。

这对密钥很牛皮，比如要加密传输消息『tangleithu』，客户端通过公钥加密得到的密文『xyyaabbccdd』进行传输，服务端用自己的私钥对密文解密，恰好能得到『tangleithu』。中间错一位都不行，这样就保证了数据完整和隐私性。

这个过程比较复杂，本文不详述，类似的原理可参考石头多年前写的这篇文章 —— [RSA算法](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&amp;mid=2247483759&amp;idx=1&amp;sn=9b37547a51ac99a8d3d50cb9cf54a99a&amp;chksm=eb47008bdc30899dace5743edfc071d97d37764ed69bd9cebbfe32c14727a7407a6b8b76a433&token=1903173876&lang=zh_CN#rd)。

因此，你在通过 HTTPS 访问网站的时候，就算流量被截取监听，获取到的信息也是加密的，啥实质性的内容也看不到。

例如，如下图所示，当我访问某个网站，此时通过 wireshark 抓包得到的信息，能获得仅仅是一些通信的IP地址而已。

![HTTPS加密传输](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610880227263-image.png)

这下放心了吗？ 

摸鱼的过程中，就算访问的 IP 地址被知道了，好像也无关紧要？

其实，有了 IP 地址也能获取不少信息了。

![](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610880536613-image.png)

还好这个 IP 搜出来是 github，而不是……

![](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610880759157-image.png)

你或许会高兴，连个网站域名都看不到，可以放心摸鱼了。不过，这是真的吗？

![](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610880932973-image.png)

## HTTPS 真的安全吗？

HTTPS 真的完全安全吗？连访问的域名都获取不到？答案是否定的。

上述 HTTPS 在握手阶段有一个很重要的东西 —— 证书。

### SNI —— 域名裸奔

当访问 HTTPS 站点时，会首先与服务器建立 SSL 连接，第一步就是请求服务器的证书。

当一个 Server IP 只对应一个域名（站点）时，很方便，任意客户端请求过来，无脑返回该域名（服务）对应的证书即可。但 IP 地址（IPv4）是有限的呀，多个域名复用同一个 IP 地址的时候怎么办？

服务器在发送证书时，不知道浏览器访问的是哪个域名，所以不能根据不同域名发送不同的证书。

因此 TLS 协议升级了，多了 SNI 这个东西，SNI 即 Server Name Indication，是为了解决一个服务器使用多个域名和证书的 SSL/TLS 扩展。

现在主流客户端都支持这个协议的。别问我怎么知道这个点的，之前工作上因为这个事情还费了老大劲儿……

它的原理是：在与服务器建立 SSL 连接之前，先发送要访问站点的域名（Hostname），这样服务器会根据这个域名返回一个合适的证书。此时还没有办法进行加解密，因此至少这个域名是裸奔的。

如下图所示，上面的截图其实是访问我的个人博客（www.tanglei.name）的抓包情况，客户端发送握手请求时，很自觉带上了自己的域名。

![HTTPS SNI](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610880014107-image.png)

因此，即便是 HTTPS，访问的域名信息也是裸奔状态。你上班期间访问小电影网站，都留下了痕迹，若接入了公司网络，就自然而然被抓个正着。

除了域名是裸奔外，其实还有更严重的风险，那就是中间人攻击。

### 中间人攻击

前面也提到 HTTPS 中的关键其实在于这个证书。从名字可以看出来，中间人攻击就是在客户端、服务器之间多了个『中介』，『中介』在客户端、服务器双方中伪装对方，如下图所示，这个『MitmProxy』充当了中间人，互相欺骗：

![中间人攻击，来源 evil0x](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610882381975-image.png)

可以安装 MitmProxy 或者 Fiddler 之类的抓包软件尝试一把，然后开启代理。

此时用手机访问百度，得到的信息如下：

![证书信任前](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610883196986-image.png)

提示，连接不是私密连接，其实就是浏览器识别了证书不太对劲，没有信任。而如果此时手机安装了 Fiddler 的证书，就会正常访问。

![证书信任后可正常访问](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610883429655-image.png)

因此，当你信任证书后，在中间人面前，又是一览无余了。 

而如果你用了公司电脑，估计你有相应的操作让信任证书吧，或者手机上是否有安装类似的客户端软件吧？

抓紧时间看看手机的证书安装明细。

![](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-18/1610977685007-image.png)

我前任公司在信息安全这块做得就非常谨慎，手机会有工作手机，未授权的任何 App 都不能安装，谁知道 App 会悄悄干些什么事情呢。（最新热点，QQ扫描浏览器历史记录，你可知道）

当然各种 App 肯定也不是吃素的，不会让『中间人攻击』这么容易就得逞的，咱们接着看。

## 如何防止信息安全，反爬

前面提到，要实施中间人攻击，关键在于证书是否得到信任。浏览器的行为是证书可以让用户授权是否信任，而 APP 就可以开发者自己控制。 

比如我尝试通过类似的方式对某匿名社区进行抓包解密 HTTPS，但最终失败了，为什么呢？

![](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610887735437-image.png)

这就要谈到『SSL Pinning』技术。

App 可以自己检验 SSL 握手时服务端返回的证书是否合法，“SSL pinning” 技术说的就是在 App 中只信任固定的证书或者公钥。

因为在握手阶段服务端的证书必须返回给客户端，如果客户端在打包的时候，就把服务端证书放到本地，在握手校验证书的环节进行比较，服务端返回的证书和本地内置的证书一模一样，才发起网络请求。否则，直接断开连接，不可用。

当然，一般情况下，用这种技术也就能防止 HTTPS 信息被解密了。

不过，也还有其他的技术能够破解这种方法，比如 Android 下的一些 Hook 技术，具体而言就是绕过本地证书强校验的逻辑。感兴趣的同学可以抱着学习目的研究一下。不过据说这种方式需要对系统进行 Root、越狱等，需要一些更高权限的设置。

因此，也告诫我们，一定不要乱安装一些软件，稍不注意可能就中招，让自己在互联网上进行裸奔。一方面个人隐私信息等泄露，另外一个方面可能一些非常重要的如账户密码等也可能被窃取。

## 可能的监控手段有哪些？ 

办公电脑当然要接入公司网络，通过上面介绍的内容，你也应该知道，你在什么时候浏览了哪些网站，公司其实都是一清二楚的。

若自己的手机如果**接入了公司网络**也是一模一样（连 Agent 软件都不需要装）。这就提醒我们，**私人上网尽量用自己的移动网络**呀。

![浏览记录，来源知乎](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610889950142-image.png)

上面提到，如一些涉及隐私的敏感信息，如一些 PC 软件、手机 App 自己内部加密传输的话，内容加密（包括但不限于 HTTPS）不被破解也问题不大。

不过，这当然依赖这些软件设计者的水平了。比如同一个匿名用户对外展示的 ID 不能相同，如果是同一个的话也恰好暴露了逻辑漏洞。

当然，我们还是不要抱有侥幸心理，在监管的要求下，如果确实有一些违法等不恰当的言论等，始终还是有门路找到你的。

![耗子尾汁](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610890492922-image.png)

更何况，一般办公电脑都会预安装一些公司安全软件，至于这些软件究竟都干了些什么，有没有进行传说中悄悄截图什么的，这就因人（公司）而异了。（不讨论类似行为是否涉及到侵犯了员工隐私等问题）

![图源知乎](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-1-17/1610890747892-image.png)

不过，个人认为，咱也没必要过度担心。一般公司也不会因为你上班偶尔摸个鱼，逛逛淘宝、看看微博来找你麻烦的。毕竟没必要这么点芝麻事情来『大动干戈』。

但最好是不是对照员工手册来看看，是否有明令禁止的行为？自己的行为是不是太过了，免得被抓住把柄，正所谓『常在河边走哪有不湿鞋』，『欲加之罪、何患无辞』。

石头才疏学浅，文章难免有所疏漏，如有相应问题，还望大家指教。最后，祝大家一辈子都不要因为这种事情掉坑里。

后记：

本文重点强调了 HTTPS 的知识点（中间人攻击、SNI等），其实早在域名解析阶段就已经暴露了。

对域名发起请求前，要知道域名的IP地址，就要访问DNS服务器，公司只需网络中指定DNS服务器，截获不加密的 DNS 报文分分钟就了解“摸鱼”的情况。

![DNS](https://cdn.jsdelivr.net/gh/tl3shi/blog-resources/2021-2-22/1614005063287-image.png)

这里引用下公众号文章发出后，某个读者的评论，觉得有收获，特此补充如下：

想要“偷偷”的摸鱼不被监控，除了上文中提到的 HTTPS，不要忘了安全的DNS，DoH(DNS over HTTPs, DoH)或DoT(DNS over TLS, DoT)。

目前比较好的方式还是，自己搭建DoH的DNS server，连上网络后设置DNS服务器为你的server IP，原生Android甚至在设置里提供了“私人DNS”选项。

当然如果还能跑一个代理服务，前面提到的SNI泄露访问域名的问题也一起解决了。抓包只能发现你一直在访问你自己的server。为了再真一点，甚至可以在你的server上再搭一个web server，放上一些内容，这样就算有人追踪到这个IP，打开看也是一个正常的站点。

参考资料：

- HTTPS工作原理: https://cattail.me/tech/2015/11/30/how-https-works.html
- 如何评价互联网公司监控员工日常上网的行为？: https://www.zhihu.com/question/46818840/answer/103329958
- 网传拼多多员工因在网上发布同事被抬上救护车的照片，被管理层逼迫主动辞职、赶出公司？事件真实性如何？: https://www.zhihu.com/question/438581129/answer/1670519587
- HTTPS工作原理: https://cattail.me/tech/2015/11/30/how-https-works.html
- 浅析HTTPS中间人攻击与证书校验: http://www.evil0x.com/posts/26569.html
- Mac/Windows Wireshark/tcpdump抓包TCP3次握手,4次挥手实例: https://www.tanglei.name/blog/example-show-3-times-handshaking-of-tcp-in-mac-or-windows.html 



> 关于作者：程序猿石头(ID: tangleithu)，现任阿里巴巴技术专家，清华学渣，前大疆后端 Leader，欢迎关注，交流和指导！
>
> 欢迎扫码加入互联网大厂内推群 & 技术交流群，一起学习、共同进步。后台回复关键字 “**0**” 送阿里技术大礼包。

