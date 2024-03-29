---
title: 秋招 | 学弟拿了这么多大厂 Offer，怎么选？
layout: post
categories:
  - MyLife
tags:
  - 总结
  - MyLife
---

> 关于作者：程序猿石头(ID: tangleithu)，从十八县贫困农村一路逆袭上**清华**（[点这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），BAT某厂P7，是前大疆（无人机）技术主管。
>
> 本文首发于微信公众号，[原文链接](https://mp.weixin.qq.com/s/dtoN36JAKX4Vq_VelkExpQ)，转载请全文保留。后台回复关键字 “1024” 获取程序员大厂面试指南。

## 背景

大家好，我是拖延症晚期的石头哥。

之前给大家预告的秋招系列文章终于出炉了。[往期校招分享请戳这里](https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzI3OTUzMzcwNw==&action=getalbum&album_id=1551696282304495619&scene=173&from_msgid=2247489734&from_itemidx=1&count=3&nolastread=1#wechat_redirect)。

今天石头哥邀请到的是一位 牛*（破音）学弟的分享，其实早在几个月前，中途跟他交流，他就甩给了我一个脑图，是酱紫的。

![学弟秋招过程的记录](/resources/gitee-blog-resources/2021-11-16/1637076070156-75666360ef1c794e2021cc059069182.jpg)

看完简直了，这是要拿完所有大厂的 Offer 吗？ 拿这么多 Offer，到时候怎么选啊？

本文分享，主要分为如下图这几个方面，大家可以重点收藏下复习要点，以及简历面试中相关经验。

![校招系列 —— 第7期](/resources/gitee-blog-resources/2021-11-27/1638024345869-%E6%A0%A1%E6%8B%9B%E7%B3%BB%E5%88%97%20%E2%80%94%E2%80%94%20%E7%AC%AC7%E6%9C%9F.png)

废话不多说了，我们来看看学弟的分享吧。

## 个人背景

本人北邮本，Top2硕，大四某无人驾驶公司算法实习，暑期阿里云实习。

秋招投得太杂，收获的意向书有：

- 基础平台：阿里云，百度推广搜某架构，美团外卖，京东；
- 业务：字节抖音电商，快手商业化，拼多多，虾皮，网易互娱
- 游戏：腾讯光子

Offer 够了其他公司就没面了，如微软，Hulu...

## 1. 三维

和保研差不多，秋招最重要的也是你的三维，好学校科班出身，基础知识牢固，丰富的大厂实习经验，SSSSP赢家就是你。

1. 学历/专业: 211+， 计科/软工/网工/通信...
2. 基本知识：语言基础(C++、Go、Java)，算法，TCP/IP、OS、Redis，消息队列， 分布式(CAP、BASE、Paxos、Raft...)
3. 实习/项目：大厂相关实习，知名开源项目...**非常重要**

## 2. 复习&相关题目

本人由于算法转开发，大多复习的是后台/服务器开发相关的知识；

大部分公司会在八股的基础上深入一下，但不会深入太多，很多我觉得难的都不会问....

建议不要只刷面经，系统的看一下/复习一下会更好（如有需要，本文所提及相关资料可后台vx联系codershitou获取）。

以下复习按照我理解的优先级进行排序；

### TCP / IP：复习使用的书籍《TCP/IP详解》，各种 blog

   1. TCP，IP，UDP基本头部
   2. TCP为啥三次握手/四次挥手；对应的状态迁移
   3. TCP的各种状态位，什么时候有用
   4. TCP的3种定时器，TCP的长肥管道问题
   5. 流量控制 & 拥塞控制 & MSS
   6. 半连接，全连接
   7. Time wait; 为啥Time wait；大量短连接怎么处理
   8. TCP vs UDP
   9. HTTP协议基本，以及1.0/1.1/2.0/3.0对比
   10. HTTPS，和Http对比；握手；数字证书；对称加密非对称加密
   11. DNS，递归/迭代查询；什么时候UDP，什么时候TCP
   12. ARP，arp广播，arp代理
   13. ICMP (比较偏)，ping，traceroute
   14. socket编程客户端/服务端的几个函数，以及对应参数
   15. IO多路复用select，poll，epoll区别/优劣，epoll的两种模式
       1. select为啥有个1024的限制，32*i32
       2. epoll线程安全
       3. reactor vs proactor

### OS: 复习使用的书籍《现代操作系统》

   1. 虚拟内存(必问)：MMU/TLB，多级页表，内存分配（slab，伙伴)
   2. 进程&线程基本概念，PCB包含什么，进程内存模型，TCB
   3. 进程间通信
      1. 基本概念，原理
      2. 通信效率，是否涉及系统调用
   4. 死锁，条件，检测/恢复/预防
   5. 同步，原子操作，CAS&FAA，互斥锁，条件变量，RCU
   6. 底层IO模型，阻塞，非阻塞，信号，多路复用，异步
   7. 多线程vs多进程；同一进程线程切换，不同进程线程切换；
   8. 协程vs线程
   9. inode，软连接、硬链接，文件描述符
   10. 零拷贝

### 数据库  复习使用的课程《MySQL实战45讲》+ blog

   1. mysql架构，server层 + 引擎层；
      1. 连接器，查询缓存，分析器，优化器，执行器
      2. 两种存储引擎的对比
   2. redo log vs binlog vs undo log，这块可以问得可深了...
      1. redolog为啥crash safe, binlog为啥不是
      2. 如何恢复数据
      3. 何时刷新log/数据
      4. https://juejin.cn/post/6855129007336521741
   3. 索引
      1. B+树 vs B树
      2. 唯一索引vs普通索引
      3. 聚簇 vs 非聚簇
      4. 最左前缀匹配，给你个sql让你分析
      5. 回表/覆盖索引
      6. 索引设计
      7. explain
   4. 事务，隔离级别（默认），脏读/不可重复读/幻读
   5. MVCC，什么时候生成read view；如何判断哪些事务可见
   6. 锁（加锁才能实际解决幻读）
      1. 两阶段锁
      2. record lock，gap lock， next key lock
   7. 数据库优化，读写分离，主从，分库分表等等
   8. 范式
   9. 手写嵌套查询
      1. 如何设计索引
      2. 执行顺序
   10. 给你个sql，让你分析如何加索引，使用了什么索引

### 语言基础 (C++, Go) 

   1. 几种时期多态，虚函数表(最基本, 多重继承)
   2. 智能指针 & 手写最简单的智能指针
   3. C++的内存分布/ 内存对齐
   4. static / const
   5. C++11，右值，转移语义，lambda等等
   6. ...
   7. Go语言 GMP模型
   8. 线程池，内存池 (比较偏)

### Redis
   1. 基本数据结构底层，大数据量和小数据量情况下不同的数据类型；
      1. sds
      2. 跳表
      3. ziplist，有啥好处
      4. hash，渐进式hash，rehash
      5. intset，提升
   2. 为啥快？基于内存，多路复用，单线程事件分配器
   3. 大key问题；慢日志
   4. 缓存穿透，击穿，雪崩；如何处理
   5. redis分布式锁，单机版&分布式版
   6. redis持久化，AOF vs RDB
   7. redis主从流程

### 数据结构 《STL源码剖析》+ blog
   1. vector底层
      1. 扩容
      2. 迭代器失效
   2. hashmap底层
   3. 树，二叉树，avl，红黑树，B+树，B树，LSM树
      1. avl vs 红黑树
      2. B+树 vs B树
      
### 设计模式 《大话设计模式》
   1. 手写单例 (必问)
   2. 简单工厂，工厂方法...

### linux 常用指令
   1. grep
   2. sed
   3. find
   4. iostat/netstat
   5. top
### 分布式
   1. CAP， BASE
   2. 分布式事务，两阶段，三阶段
   3. Raft基本流程，选主，日志复制，脑裂之后流程
   4. 一致性hash

### 消息队列：没复习，但经常会问

## 3. 算法

除了字节和外企，其他公司的面试题都很简单....也不用特别担心；建议面试前看看公司最喜欢考的题(https://codetop.cc/#/home)。可以看看别人的[刷题笔记](https://mp.weixin.qq.com/s/7T9R9kFXke986vSoPNzC8g)。

个人 LeetCode 刷了400道 + LeetCode Top 100 + LeetCode Top interview + 牛客

-  必刷：LeetCode Top 100 + LeetCode Top interview + 牛客常考题 + codetop
  - 比如著名的 LRU...
- 链表题
  - 翻转，每k个翻转，字节最爱...
  - 环的入口
  - 删除重复节点
  - 链表快排/归并排序
- 动规题，动规题理解了背住常见的几个模板就行；一般最多2维dp
  - 最长公共子串
  - 最长上升子序列
  - 换零钱，变种考了很多次
  - 01背包
  - 回文子串，及其变种比如区间[i, j]符合某某条件
  - 矩阵连乘，加括号
  - 编辑距离
- 二叉树前中后，递归/非递归遍历；一般比较简单
  - 非递归遍历
  - 前序中序重建
  - 最大路径和
  - 公共祖先
- 排序，快排变种
  - 第K大/小
  - 两个数组第k大
- 单调栈，接雨水
- 位运算，子网掩码，只出现一次的数...
- 广度搜索 + 记忆化数组，求最短路径
- dfs，暴力解法，骗分
- 排序算法，n2, nlogn, n
- 排列
  - 全排列，无重复
  - 下一个排列
  - 洗牌算法

## 4. 项目

尽量提前实习，去有含金量的大厂，比如wxg，阿里云，抖音等等；

尽量实习方向和就业方向相同；

没项目经验的可以看看下面这个

- C++ web server https://github.com/linyacool/WebServer

项目常常问

- **介绍你的项目**：**请使用star法则**
- 项目实施的一些详细数据
- 为什么这么设计，你在其中承担的角色
- 如何保证/增加crash-safe的能力
- 为什么xxx，为什么xxx，为什么xxx
- 考虑以后的优化
- 你的收获

## 5. 简历&投递

- 建议使用 超级简历 https://www.wondercv.com/  上面的简历模板，简洁明了，别整些花里胡哨的图片模板；
- 建议参考下网上写简历的方法**Star法则**，背景，待解决的问题，难点，成果；
- 简历多**Review**几遍，不要给自己留坑，某个点不太熟悉请别写，别抱侥幸心理...(我写在简历上的算法项目/实习都被问过...)
- 提前调研下某个公司某个组是否核心(脉脉)，是否难进；适合自己的才是最好的，别一味冲wxg，阿里妈妈之类的；也别随便选一个自己不会去的部门
- 善用内推，熟人 >> 北邮人论坛 > 脉脉/牛客；一些网站上的内推人不负责，不会管你，而论坛里很多师兄会帮你改简历。[阿里内推](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247495225&idx=1&sn=c99a906c2e2dc591d7ecaac798330fb3&chksm=eb44efdddc3366cb1ed31d3468097ceef0d41f00dcc8ed8f6eb0804d0b895576a4fcc5718249&scene=178&cur_album_id=1551696963291693061#rd)，推荐找石头。
- 投递的方向最好不要太杂，不然面试复习的方向可能很多，且复习深度很难把握。

## 6. 面试

不要紧张，不要紧张，不要紧张，**此处不留爷自有留爷处**；

大部分公司面试官都是很nice的，不要被某些面试官的黑脸搞崩心态。

1. 提前熟悉下牛客网之类的白板写题，写写常考题练练手；

2. 找一个安静，整洁的环境；好的环境会让双方都体验更好；

3. 开始面试前，让自己放松下，不要太紧张，不要再去拼命复习，没用的反而会让自己紧张；

4. 面试过程尽量保持自己的语调，确保面试官能听清楚，不会太快太急；

5. **一定要结构化的回答问题**，面试官听你的回答提炼答案也很累；除了基本知识，面试官还**考察表达/沟通能力**，例如：

   - 为啥有xx；相同点是: 第一点，第二点，第三点；
   - 不同点是：第一点，第二点，第三点；
   - 最后总结一下；

6. 遇到不会的题，尽量回答一些有关系的点，如果实在不会，直接说不会，不要绕来绕去；

7. 遇到会的题，在答完基础的情况下，可以加深一下，比如

    - 面试官问你虚拟内存是啥；

    > 虚拟内存的是啥...；段式，页式；单级页表，多级页表；MMU，TLB加速翻译过程；内存换入换出等等；

    - MYSQL的锁：

    > 表锁+行锁；行锁基于索引，record/gap/next-key；意向锁

8. 除了部分公司某些面试官，其他公司的面试官会引导你去回答，也不会缠着你不会的；

9. 不要在面试官面前显示的很卑微，此处不留爷自有留爷处；

10. 面试完了就不要患得患失了，准备下一场比啥都重要；

## 7. 选 Offer 

选 Offer 是一个**无比纠结**的东西，可能纠结过程中反复横跳，难以纠结都是很正常的事。

### 考虑自身特点：

1.  能否接受一段时间的加班(卷)，工作时间多长能接受；
2.  对钱的追求有多高，是想年薪百万以上，还是有个几十万就行；
3.  是不是想一直在一线打拼，还是可能回二线，游戏行业等可能更加不适合在二线发展；
4.  如果想留一线，父母对象是否能出力帮助；
5.  是否注重生活品质，有一些比较重要的爱好，比如周末有一些小资生活，文艺生活；
6.  想做业务，还是想追求一定的技术深度；
7.  对自己有什么要求，是想一直往前冲，还是可能达到一定级别后就开始享受生活；
8.  ...

### 工作/公司特点：

1.  方向，赛道：你选择的方向是否是未来的一个趋势 or 部门是否是一个核心部门；
2.  薪资&福利，有无普调，比如阿里腾讯有买房无息贷款，每年有普调（薪酬回顾）；
3.  组内氛围好不好&领导好不好，影响到你工作状态；
4.  培养机制，是不是一上来就干活；
5.  晋升时间，比如腾讯前期半年一升，阿里升职gap比较大；

### 城市: 

1.  定居北上深哪座城市？工作机会 or 文娱 or 朋友；
2.  户口，应届拿户口最容易，北京非应届拿户口就是难上难；

**鱼与熊掌，不可得兼**，一般来说钱多，活少，发展前景好，有户口的工作是很难同时满足的。

你得考虑**职业/人生规划**，**挑出你最想要的**。

可能别人眼中绝好的机会，就不是你想要的。

选择好了就不要患得患失了，**曾经有一个 Offer 摆在我的面前，我没有珍惜...**

## 8. 总结

1.  互联网感觉越来越卷...秋招变夏招，时间线提前，请早做准备；
2.  尽量早投，尤其是提前批别错过，秋招的一大感悟就是投晚了，真hc紧缺，很多公司都会有个池子养鱼，简历投了几个星期才面试；
3.  适当练下手，培养面试状态，别一开始就面你最想去的公司；
4.  别只等转正offer，今年很多公司招了不少实习生(比如wxg，比如a里云)，转正率不高，等offer会变得很焦虑；
5.  提早复习，边实习边复习，真的会没时间复习&焦虑&复习效果不好；
6.  尽早拿一个offer垫底，没offer+没试提前批真的焦虑；有offer之后面试也硬气起来了；
7.  找个小伙伴 or 对象；不要一个人焦虑；
8.  选offer需要舍得；

祝学弟学妹们，春招/秋招顺利！

## 后记

其他校招经验分享：
- [谁说本科妹纸不能拿 BAT SP Offer？](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&amp;mid=2247492598&amp;idx=1&amp;sn=5904b3800a2091ad4215aaf156d59133&amp;chksm=eb44e212dc336b04c37320664cb3bd4c036b1e2329810b91d393e100b9a34f495194d05c15f7&token=402593151&lang=zh_CN#rd)
- [6个大厂Offer，牛逼！](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247491218&idx=1&sn=e20fe76a2ba3e4f9986c7a1fe9d93995&chksm=eb471f76dc309660a3599c9ea11043a807ec48a81be76565a516fe989e63e8b9a6d5dce25bc6&token=623576504&lang=zh_CN&scene=21#wechat_redirect)
- [非科班学弟如何转行斩获 ATM 大厂的 Offer ？](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247489734&idx=1&sn=f9172000b917ea4e81f4e8b3b2afa1e3&chksm=eb471922dc309034064a0420eeb9c21fca533f387a5a9a5bfbd0f25313d134753e490774bb9c&token=1659374559&lang=zh_CN&scene=21#wechat_redirect)
- [羡慕，又一清华学弟斩获 6 个大厂 SSP Offer | 面经分享](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247490412&idx=1&sn=2512cb07a969ff50222c363dd7a6874a&chksm=eb471a88dc30939ee95067ad13447e8b9e579f719d8a89deb95ff56ae81b0447ae2c86efcbaf&token=1659374559&lang=zh_CN&scene=21#wechat_redirect)
- [一个读者大佬精心总结的阿里、腾讯、宇宙条大厂 Offer 面经和硬核面试攻略](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247491116&idx=1&sn=676c6dab8dbb095a31e6fb45cb31a828&chksm=eb471fc8dc3096dea5f1a8600fdc9163d3ce228e640ddb93fad310d44e739f9d719d0722efd7&token=1903173876&lang=zh_CN&scene=21#wechat_redirect)

上面内容包含在前面整理的本号精华文章，（详见 [100篇原创，聊几句心里话](https://mp.weixin.qq.com/s/MzNXdriVu-X1RwQ8GSc6dg)），可在后台回复“历史文章”下载。

数据结构和算法是重中之重，这里我跟大家推荐一本 Leetcode 算法指南，质量还挺不错的，推荐给大家参考。获取方式，在公众号后台回复 leetcode01 即可获取。

最后，求关注、求星标，本号会定期分享一些技术干货、职场经验等，如果大家对阿里或者其他大厂感兴趣，也可以找我内推，我可以帮忙提供简历 review 等，希望能和大家积极交流讨论，一起学习、共同进步。


> 关于作者：程序猿石头(ID: tangleithu)，从十八县贫困农村一路逆袭上清华（[点击这里查看我的逆袭之路](https://mp.weixin.qq.com/s/G3i7qWK1MPvJ-BfUxfOycQ)），目前在BAT某厂打工，是前大疆（无人机）技术主管。
>
> 欢迎扫码加入互联网大厂内推群 & 技术交流群，一起学习、共同进步。后台回复关键字 “**0**” 送阿里技术大礼包。
