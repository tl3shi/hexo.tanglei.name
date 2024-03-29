---
title: 在抖音实习了半年，都干了啥？
layout: post
categories:
  - MyLife
tags:
  - 总结
  - MyLife
---

> 关于程序员石头(ID: tangleithu)：从十八县贫困农村一路逆袭上**清华**（[点这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），BAT某厂P7，是前大疆（无人机）技术主管。
>
> 本文首发于微信公众号，[原文链接](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247501425&idx=1&sn=38e8f25b2232d4bda0542d244c434977&chksm=eb44c795dc334e8344190aea4a6e6e27e945a5a8f95a1ec2d68a8138ce5cec39481f51df135a&token=803475490&lang=zh_CN#rd)，转载请全文保留。后台回复关键字 “1024” 获取程序员大厂面试指南。

## 背景 

大家好，我是石头哥。 

今天我邀请到一个师弟，给大家分享他在抖音实习半年的感悟，主要包括字节文化、技术氛围等体验和感受，以及这半年来实习的产出。

师弟本硕都是211，目前研二在读、本科计算机、硕士软件工程，之前在京东也实习过半年，主要做风控相关 Java 研发，最近的就是在抖音架构部门实习半年，用 Go 进行开发。

下面我们一起来看看师弟的分享吧（石头哥在原文基础上有些许改动）。  

![](/resources\wechat-backup\890bd6db-883e-45dd-8776-c92af9957d34.png)

## 字节文化

文化这个词语，感觉离自己很近，毕竟被素质教育了18年了，但又感觉离自己很远，好像一直脑袋里面也没有什么类似信仰之类的东西。

进字节之前，只感受过周姐的企业文化，从字节离职后，脑子里感觉被烙下了一些字：“==始终创业、坦诚清晰、追求极致、务实敢为==”。

虽然这些东西可能我还没弄明白吧，但是通过和团队的接触，感觉这些都是每天在实践的具体内容。

Lark（飞书）的体验真的很棒，十分有力的提效工具，方便沟通。MeeGo（项目管理工具）相当nice，虽然项目延期后，会被自动化小机器人定时@。

字节会议室，高效的代表作，不管参会人员是在哪里，结合飞书会议，开会体验那叫一个哇塞！

## 技术氛围

刚进去会给你分配一个 mentor，他会带着你熟悉项目、业务、上线流程、开发规范、字节云等等内容，带你快速上手。

当时给我分配的是一个小年轻（就叫他老A吧）老A对我很严厉，头一个月每天会one by one跟我交流一下，遇到问题也不会直接告诉我答案，而是问：“你觉得呢”？

刚开始我还觉得老A故意针对我，后面接触的多了，感觉老A的技术实力很强，是在引导我思考，在周会或技术分享会上都能提出很好的解决办法。

我也在这种氛围下，慢慢的能够独立的通过查阅文档、直接看代码、看线上日志、宿主机日志等方式解决一些问题，直到3个月后，就开始独立承担项目了。

上面分配给我一个需求，我会和PM（产品）、QA（测试）、FE（前端）等同学很好的协作完成。分配的需求，也从简单的CRUD，变成大流量、高并发的线上需求。

说白了，就是把实习生当正式员工看待，自由度很大！

## 整体感受

实习下来的整体感受如下：

1. Go 真的是一门很现代的语言，开发效率极高，学习曲线极低！
2. Redis 是抗住高 QPS 的利器。
3. 一个用户请求从客户端 or 浏览器发出请求 Request，到接受 Response 请求的全流程都属于后端考虑的范围。包括网关、风控、业务逻辑、存储、网络等等。
4. **我最讨厌别人写代码不加注释，我最不喜欢自己写注释！** 好多历史遗留问题不要问为什么，问就是当时在赶进度。所以你对代码的重构尽量在设计之初就考虑到，或者加上注释！
5. 在字节的时候感觉每天很忙，很充实，突然离开了，感觉也挺无聊的。

今年的行情想必大家都体验过了，没错，就是史无前例的23界暑假实习，受各种因素的印象，企业放出的HC很少，导致绝大多数人同时去卷有限的岗位，结果就是，惨不忍睹。

所以说，**今年秋招的情况应该也不是很乐观**，从我实习的感受来看，干技术这行，一定是技术越强，越会有好的发展，那问题来了，如果技术变强呢？

我觉得根源还是在大家自身对技术的喜爱程度，有些人就是喜欢成天抱着电脑研究算法，工程，看一些底层的知识等等，我把这称之为技术自驱力，有些同学可能是看到互联网发展很好，也想赚波快钱。

所以希望大家认真审视过自己内心后，最出不让自己后悔的决定就行！具体而言，可以看一些互联网相关产业，比如国企、事业单位、银行的信息岗位。

大家千万不要在一棵树的吊死，两手抓，多手准备！一定得多拿几个 Offer，比如之前分享过[老版口头通知转正成功，最终却错失校招 Offer](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&amp;mid=2247499004&amp;idx=1&amp;sn=dda9a3a378e370f323e7593762aa03eb&amp;chksm=eb44fd18dc33740ef375b1ed304aafa55c8e783d56095f581ea164b19eee8cb4cf6d4d388735&token=1987163828&lang=zh_CN#rd)， 一定得多关注网上的校招面经等等。比如石头哥这里就分享了[很多校招面经](https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzI3OTUzMzcwNw==&action=getalbum&album_id=1551696282304495619&scene=173&from_msgid=2247489734&from_itemidx=1&count=3&nolastread=1&scene=21#wechat_redirect)。

## 实习工作总结

下面继续分享我这实习具体的工作产出。具体而言包括：直播间导流、春节免费看《我和我的父辈》电影、抖音PC观看历史、广告投放优化、抖音热点榜单投放、抖音高热视频投放等。

具体而言主要经历了如下几个阶段。

### 一、新人学习阶段

- 周期：一个月
- 参与人员：我，我 mentor（后文代称老A）

具体内容：字节有一个月的入门缓冲期，这阶段的学习内容主要有：go、字节云平台、日志系统、网络安全、公司文化、规章制度等等内容。

由于我之前一直都是写Java的，所以主要的精力还是在学习Go语言。

前两周可太爽了，每天拿着400毛爷爷，学习各种课程。但是直到我 mentor有天不忙了，问我学的咋样？说要约个会议室和我one by one聊聊进度。我当时就慌了，没啥进度怎么one by one呢！

就这样，怀着忐忑的心，颤抖的手拿着电脑，带上大家都带的字节工牌，步履蹒跚的爬向了会议室。

相对于我的不安，老A表现的异常平静，并且深情的看着我，嘴角上扬起标准的45°职业微笑，说了声：坐！

坐下后，双方友好的沟通了下进展，结论就是：我学的太慢了，这样的进度不行，需要加快学习。

之后的日子里，在老A的引导下，慢慢的找到了学习的感觉，这也算是步入正轨了吧。

### 二、熟悉组内业务+读代码

- 周期：贯穿整个实习阶段
- 参与人员：我、组内大哥们

具体内容：我们组负责推荐主feed流、内容消费、垂直场景探索等。！扑该，讲人话拉！负责抖音刷视频功能、点赞、收藏、关注、好友、评论、热点等功能。

这段时间主要就是看代码、不断的看代码、还是看代码！把学过的Go知识应用到实践中去。顺便学习学习Go的代码规范，学习下字节的微服务框架、API设计。

### 三、解决简单的问题

- 周期：一个月
- 参与人员：我、我mentor（后文代称老A）、QA、FE


具体内容：说白了就是线上已经在运行的功能，突然发现有点小问题了，有点bug了，或者需要在这个功能的基础上接着加一些字段等等。

通过Git拉一个fix分支，改完相关代码后，交给QA测试后，就可以上线了！上线需要经过测试在隔离环境的检查，然后发布到线上。这些都是自动化的流程，使用字节云就可以了，一键部署。

### 四、独立接需求

- 周期：后面三个月

- 参与人员：我、PM（产品）、QA、FE、数据分析师

具体内容：

**需求1：直播间导流**

如果用户在直播状态，点击用户头像，就会跳转到直播间。

开发过程：这个需求比较简单，就是通过判断某个字段是否存在，然后拼接出直播间的地址，然后访问即可。

<br/>

**需求2：春节免费看《我和我的父辈》**

- 流量预估
- 接口设计
- 用localCache保存影片id，进行兜底
- 通过在线配置来控制播放阶段：未上映 | 免费播放阶段 | 付费播放阶段
- 考虑通用性设计，不光是看这一部电影，根据不同的vid可观看不同的电影。
- 配置监控，了解qps、接口延时、接口返回错误等。

<br/>

**需求3：热榜投放**

需求简介：将抖⾳热榜信息投放到第三⽅⽹站或客⼾端中。

技术简介：对外提供⼀个http接⼝，约定好抓取策略，供多个第三⽅使⽤。

注意：利用localCache进行信息兜底

<br/>

**需求4：端内信息投放**

需求简介：将抖⾳热⻔内容提供给第三⽅⽹站。

技术难点：考虑百万、甚至千万级别的视频资源，如果快速的打包投放。

<br/>

**需求5：抖音PC观看历史**

背景简述：抖⾳PC端需要增加观看历史功能，数据要与App端同步。

技术简介：实时上报历史 + 读取观看历史 + 清空观看历史

技术难点：实时QPS大，既有读操作，又有写操作。

## 反思

前期学习进度慢的主要原因在于，我老觉得我之前是写Java的，现在要转Go肯定要花费很长的时间，其实经过实践来看，Go的学习成本极低，上手很快。就是这种心里包袱，导致了学习路上出现了拦路虎（me）。

中期觉得自己作为开发，只用管好自己的事就行，其实后端作为一个承接前端和测试的桥梁，应该更加积极一点，主动推进负责的需求。

后期觉得自己还有太多的东西要学，从接口设计、到监控指标、代码质量等等。

其实，经常总结是个不错的学习积累方案，欢迎大家关注师弟公众号，感谢兄弟们 点赞 + 收藏 + 转发！

## 后记

确实，经常总结和尝试输出是一种很不错的习惯和学习积累方式。石头哥最初玩写博客，更多地也是抱着一种学习的态度。比如刚学习完了 DNS 解析，HTML 语法，不 “实战”一把么？然后后续又陆陆续续把读书笔记、课程总结都往博客上放。

一方面尝试写作输出可以作为整理学习笔记的地方，方便沉淀回顾学习。在日常工作中，你肯定也有通过别人的博客解决了你的某个问题，这个时候“反哺”一下开放的互联网也何尝不是一件快事。

当有人通过搜索引擎检索到你的内容并留言说感谢帮助他解决一个类似问题的时候，还是有一丝丝成就感的。

此外，还能锻炼写作能力，一个问题自己懂和把它讲给别人懂，是两个完全不一样的概念。进入职场之后，写作、分享也有利于自己的职业成长。因此呼吁读者朋友们也经常总结和输出，比如也[写写博客](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247488750&idx=1&sn=bddb76b8e85d04b303b3d10024b8a56b&chksm=eb47150adc309c1cfe5f847acaf6a3eb7de3efb3c7f2a87e708a686a740aa364c33c80ea3000&token=990554520&lang=zh_CN&scene=21#wechat_redirect)之类的。欢迎大家跟我投稿，可以[加我微信【codershitou】](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247500452&idx=2&sn=10a2456e399a7404f85bd8227b01f374&chksm=eb44c340dc334a5677ff5508c016981f295f49bbda7a4d67330f1d01a03b23a1731bd41eea17&token=1905663863&lang=zh_CN&scene=21#wechat_redirect)。

另外，关于[秋招相关话题](https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzI3OTUzMzcwNw==&action=getalbum&album_id=1551696282304495619&scene=173&from_msgid=2247489734&from_itemidx=1&count=3&nolastread=1&scene=21#wechat_redirect)，推荐大家看我之前分享的几篇文章：

- [2022 秋招 | 拿10+大厂SSP Offer 是一种怎样的体验？
](https://mp.weixin.qq.com/s/dtoN36JAKX4Vq_VelkExpQ)
- [谁说本科妹纸不能拿 BAT SP Offer？](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&amp;mid=2247492598&amp;idx=1&amp;sn=5904b3800a2091ad4215aaf156d59133&amp;chksm=eb44e212dc336b04c37320664cb3bd4c036b1e2329810b91d393e100b9a34f495194d05c15f7&token=402593151&lang=zh_CN#rd)
- [6个大厂Offer，牛逼！](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247491218&idx=1&sn=e20fe76a2ba3e4f9986c7a1fe9d93995&chksm=eb471f76dc309660a3599c9ea11043a807ec48a81be76565a516fe989e63e8b9a6d5dce25bc6&token=623576504&lang=zh_CN&scene=21#wechat_redirect)
- [非科班学弟如何转行斩获 ATM 大厂的 Offer ？](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247489734&idx=1&sn=f9172000b917ea4e81f4e8b3b2afa1e3&chksm=eb471922dc309034064a0420eeb9c21fca533f387a5a9a5bfbd0f25313d134753e490774bb9c&token=1659374559&lang=zh_CN&scene=21#wechat_redirect)
- [羡慕，又一清华学弟斩获 6 个大厂 SSP Offer | 面经分享](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247490412&idx=1&sn=2512cb07a969ff50222c363dd7a6874a&chksm=eb471a88dc30939ee95067ad13447e8b9e579f719d8a89deb95ff56ae81b0447ae2c86efcbaf&token=1659374559&lang=zh_CN&scene=21#wechat_redirect)
- [一个读者大佬精心总结的阿里、腾讯、宇宙条大厂 Offer 面经和硬核面试攻略](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247491116&idx=1&sn=676c6dab8dbb095a31e6fb45cb31a828&chksm=eb471fc8dc3096dea5f1a8600fdc9163d3ce228e640ddb93fad310d44e739f9d719d0722efd7&token=1903173876&lang=zh_CN&scene=21#wechat_redirect)

后面的文字，其实是模板每次带上的，一方面为了引流，另外一个方面，确实如果能帮助到读者，就再好不过了。记住我说的，如果有心进大厂，搞透文末资料，基本问题不会太大。

看到这里，真心希望你能帮忙点赞、分享支持一下，😝这将是我持续输出优质文章的最强动力！

我是石头哥，咱们下期再见！

推荐阅读：

- [Google 工程师面试指南.pdf-免费下载](https://mp.weixin.qq.com/s/OGJhxM7FdeoIkAL2-uUI_Q)
- [清华计算机系王牌课程——《数据结构》课件及源码包下载](https://mp.weixin.qq.com/s/iRcyW1dEeCxleTfOTyr2Lw)
- [BAT大佬写的 1300 页 Leetcode刷题笔记，必须收藏！](https://mp.weixin.qq.com/s/7T9R9kFXke986vSoPNzC8g)

> 关于程序员石头(ID: tangleithu)，从十八县贫困农村一路逆袭上清华（[点击这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），目前在BAT某厂打工，是前大疆（无人机）技术主管。
>
> 欢迎扫码加入互联网大厂内推群 & 技术交流群，一起学习、共同进步。后台回复关键字 “**0**” 送阿里技术大礼包。
