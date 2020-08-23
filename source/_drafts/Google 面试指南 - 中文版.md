# 谷歌面试指南 | 中文版

>关于作者：程序猿石头(ID: tangleithu)，现任阿里巴巴技术专家，清华学渣，前大疆后端 Leader。用不同的视角分享高质量技术文章，以每篇文章都让人有收获为目的，欢迎关注，交流和指导！

在这篇文章 [面试 Google, 我失败了 | Google 面经分享](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247483912&idx=1&sn=520bbca6a2056ab4df6b0e1d0ebaf6e0&chksm=eb4703ecdc308afa83b288b1469f0927c1916189f219ee5e8c3c5194defc0b8f313ff7607730&token=1200062146&lang=zh_CN#rd)中，石头分享了 Google 中国 的面试流程和体验，并分享了 HR 小姐姐给提供的原版的 Google 面试指南。

但不少读者反馈本来想仔细读读的，但一看到是英文版就头大了。 其实，石头想说，作为码农从业者，我们阅读基本的英文文献的能力还是应该具备的，不然怎么面向 StackOverflow 编程呢？

啥？说啥叫面向 Stack Overflow 编程，[看看这篇](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247486659&idx=2&sn=c51502fc03686f5f945bc91cffa88c6c&chksm=eb470d27dc308431cd5d10dccb9368e493a6a2b04f24f0e21f973614686d79886e43f82e1ec6&token=504758639&lang=zh_CN#rd)就知道了。

哈哈，不过为了方便大家，本篇文章，我将根据自己的理解从原版的 Google 面试指南中挑出重点用中文给大家阐述。 其实本人觉得，各大公司针对程序员岗位面试来讲相比是通用的，只是有的公司在算法（Code）环节要求会更高一些，比如 Google，Airbnb 等。（之前也面过 Airbnb，被完虐）。 

这份面试指南还是相对比较通用的。下面我就直接来说重点吧。 

## Google 的 SWE 岗位

首先最重要的就是了解你要投递、面试的岗位具体的工作内容和职责，一般还需要了解对应 hc 的职级。一般而言，公司招聘都是一个萝卜一个坑，萝卜太大或太小都不一定合适。比如有的公司，预期是招聘 P7 级别的，但你刚毕业两三年，可能希望就不大。本来只想招聘 P6，结果来了一个 P8 的候选人肯定不合适，所以有时候面试没通过并不是候选人不够优秀，也有可能是候选人过于优秀。

Google 的 SWE 其实就是 Software Engineer 的缩写，就是一般的码农岗位啦。 Google 的 SWE 岗位根据不同的项目，可能需要参与到项目的各个流程中，比如：调研（研究），设计架构，做计划，开发测试以及发布等各个周期。

涉及到具体的产品可能需要处理大规模的数据，需要提供详细的解决方案，将具体的方案落地时可能会涉及到技术的方方面面。 有点“全栈工程师”的味道。

Google 是一家技术驱动型公司，招聘各种技术人才来处理各种技术难题，影响的用户都是数千万上亿级别的。设计到的具体产品包括：AdWords，Chrome 浏览器，Android，Youtube Google 云和 Google 地图等等，Google 的工程师正在通过各种各样的技术来改变世界。 

## 面试 Tips 

在面试过程中，期望了解到候选人的思考过程，不仅仅是考察技术能力，同时也会考察候选人到底是怎么来解决具体问题的。候选人需要和面试官来回沟通确认来明确和佐证自己的观点。

在面试过程中可能会遇到一些开放式的问题。这个时候也不用紧张，可以和面试官来沟通明确具体问题的边界，一步一步来解决。 

当回答一个问题的时候，候选人需要多尝试思考一些优化的方案。很多情况下，可能最开始的解法不一定是最优的。如果可能的话，在最开始回答问题的时候，可以直接先给面试官一个暴力的解法，这样方便在很短的时间之内明确你是否真的了解清楚了题意。

![图源：Google Interview Prep Guide Software Engineer.pdf](https://imgkr.cn-bj.ufileos.com/9d2b85f6-454b-4f0d-9993-187ac18ae98d.png)

面试过程中，并不一定真的会在 IDE 上编译和跑通代码。但最好刻意提前在白板或者纸上联系写代码。 注意要想清楚一些边界的条件，不要遗留一些明显的 bug。但不用纠结一些具体的很小语法错误，只要让面试官明确意思即可，比如不用纠结`substring`的参数到底是`(startIndex, length)` 还是 `(startIndex, endIndex)`。

## 电话面试 

电话面试一般会涉及到数据结构和算法，大概也就是 20~30 行代码，你可以用你自己最熟悉的编程语言。注意代码有良好的可读性，并且足够鲁棒。

1. 你可能会被问一个很开放的问题，需要你跟面试官沟通明确问题的边界，具体的需求；
2. 问题明确后，你需要向面试官解释你的算法思路；
3. 然后需要有能力将上面的算法思路转成代码。因为时间有限，不会要求你给一个完美的解法的。可以先写出一个解法来，然后再逐步优化。注意一些边界的 case。其实在这一步就会卡掉很多人了。在石头的[这篇“从一道面试题谈谈一线大厂码农应该具备的基本能力
”文章中](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247484698&idx=1&sn=03cc4636e7ee7364a85788a98809cc03&chksm=eb4704fedc308de8efd48ab9aed4fd1ddee5665d8e76d0d3767c1f704eac8b15a83e450a08f1&token=504758639&lang=zh_CN#rd) 也阐述了。
4. 逐步优化你的代码，自己主动写测试用例来测试解决其中的 bug。

## 编码（算法）面试 

- Coding: 至少用一门你熟悉的编程语言(不限，推荐 C++，Java，Python，Go 或者 C)实现给定的题目。从代码中会考察一些基本的API、面向对象的设计，编码和测试，包括各种边界条件的处理。注意会重点关注解题目过程中的理解和沟通能力，而非背诵。

- 算法: 可能会涉及到 排序/搜索/分治/动态规划/贪心/递归，具体数据结构，以及也有可能会涉及到 Dijkstra 和 A* 等算法，需要你会算法复杂度的分析。推荐你在下笔（下手）之前，最好先和面试官沟通大致思路。 

- 排序: 常见的排序算法，时间/空间复杂度，各自适用的使用场景分析。例如 快排/归并/堆排序/插入/基数排序等等；知道比如在有一些特殊的场景下，可能插入排序或者基数排序会优于常见的快排、归并或者堆排序。

- 数据结构: 数组/链表/堆/栈/hash/数/二叉树等；知道具体什么算法搭配什么数据结构。 

- 数学: 可能会涉及到离散数学、组合数学等。这在 Google 还相对比较常见。例如选取问题 -- N 个中选 K 个的方法等;

- 图: 有一些问题可能常常会涉及到图相关算法，例如距离，搜索，连通性，环的检测。 你需要知道常见的图的表达方式(例如矩阵/邻接表)，并理解各种表达方式的优缺点。图的遍历方式 bfs/dfs 等，算法复杂度和代码实现。

- 递归: 递归和迭代的转换;

## 系统设计

**系统设计**问题会考察候选人如何将理论知识和经验到现实的具体问题场景中来。 

比如常见的话题可能会包括：接口，类继承关系，分布式系统等。 在特定的场景中，一定的约束条件下，如何设计出可扩展性强的系统，如何平衡比如简单性、性能、鲁棒性。

在系统设计过程中，需要你熟悉各种互联网技术，比如路由，域名解析，负载均衡，防火墙等等。

可能还会涉及到如一些图的遍历，分布式系统，以及如何抽象显示生活中的一些问题，变成产品设计。设计的知识点可能会包括：具体的 API，二叉树，缓存，MapReduce，索引，倒排索引，编译器，内存缓存，网络等等。

**操作系统**也是其中的一个考察点，需要了解进程、线程，并发（并行），锁，信号量等等概念以及他们的实现机制。知道一些基本的比如死锁是怎么发生的以及如何避免，进程、线程的区别，他们的调度资源是什么。

## 参考资源

### 书籍

- [Cracking the Coding Interview](https://books.google.ie/books?id=nlgWywAACAAJ&dq=Cracking+the+Coding+Interview&hl=en&sa=X&ei=hUTtUfXVCoSg4gS5v4C4BQ "Cracking the Coding Interview") By: Gayle Laakmann McDowell 
- [Programming Interviews Exposed: Secrets to Landing Your Next Job](https://books.google.com/books/about/Programming_Interviews_Exposed.html?id=9_by-rpCSSUC&hl=en "Programming Interviews Exposed: Secrets to Landing Your Next Job") By: John Mongan, Eric Giguere, Noah Suojanen, Noah Kindler
- [Programming Pearls](https://books.google.com/books/about/Programming_Pearls_2_E.html?id=vyhrriC6qcEC&hl=en "Programming Pearls") By:Jon Bentley 
- [Introduction to Algorithms](https://books.google.com/books/about/Introduction_to_Algorithms.html?id=VK9hPgAACAAJ&hl=en "Introduction to Algorithms") By: Thomas Cormen, Charles Leiserson, Ronald Rivest, Clifford Stein

### 关于 Google 

- [Company - Google](https://www.google.com/about/our-company/ "Company - Google")
- [The Google story](https://www.google.com/about/our-story/ "The Google story")
- [Life @ Google](https://www.youtube.com/user/lifeatgoogle "Life @ Google")
- [Google Developers](https://developers.google.com/ "Google Developers")
- [Open Source Projects](https://opensource.google.com/projects "Open Source Projects")
- [Github: Google Style Guide](https://github.com/google/styleguide "Github: Google Style Guide")

### 面试准备

- [How we hire](https://careers.google.com/how-we-hire/ "How we hire")
- [Interviewing @ Google](https://careers.google.com/how-we-hire/interview/ "Interviewing @ Google")
- [Candidate Coaching Session: Tech Interviewing](https://www.youtube.com/watch?v=oWbUtlUhwa8 "Candidate Coaching Session: Tech Interviewing")
- [CodeJam: Practice & Learn](https://code.google.com/codejam/past-contests "CodeJam: Practice & Learn")
- [Technical Development Guide](https://techdevguide.withgoogle.com/ "Technical Development Guide")

### Google Publications

- [The Google File System](https://research.google.com/archive/gfs.html "The Google File System")
- [Bigtable](https://research.google.com/archive/bigtable.html "Bigtable")
- [MapReduce](https://research.google.com/archive/mapreduce.html "MapReduce")
- [Google Spanner](https://research.google.com/archive/spanner.html "Google Spanner")
- [Google Chubby](https://research.google.com/archive/chubby.html "Google Chubby")

为了方便，我将此文做成了 PDF，你只需要在公众号后台回复 “Google面试指南” 即可获得本文。

![](https://imgkr.cn-bj.ufileos.com/b665b5ac-b77b-4d1f-ac98-b59f41f06132.png)

另送福利，公众号后台回复“模拟题”获取算法笔试模拟题精解合集，该书籍为阿里云开发电子书系列之一（阿里云开发者社区有不少高质量技术文章，大家可以去观摩学习，有很多书籍都是可以直接免费下载的），涵盖 70+算法题目，近 30 种大厂笔试常考知识点。希望在你“面试战场”上能够助你一臂之力。

## 后记

觉得本号分享的文章有价值，记得添加星标哦。周更很累，不要白 piao，需要来点正反馈，安排个 “一键三连”（点赞、在看、分享）如何？😝 这将是我持续输出优质文章的最强动力。

![](https://imgkr.cn-bj.ufileos.com/0d211c87-89df-40ae-9f83-0f634c701747.gif)
