---
title: 2020北京积分落户结果公示，落户指标最多的公司竟然又是 ？
layout: post
categories:
  - 经验技巧
tags:
  - 工具
  - Shell
  - Linux
---

> 关于作者：程序猿石头(ID: tangleithu)，现任阿里巴巴技术专家，清华学渣，前大疆后端 Leader。欢迎关注，交流和指导！
>
> 本文首发于微信公众号，[原文链接](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247489970&idx=1&sn=0765365069973269c479eccea07e23bb&chksm=eb471856dc3091407b1b4c4a5dd86ac3d270405ac7e128de9fdc8588278e1fbef8a6d95e499e&token=536564666&lang=zh_CN#rd)，转载请全文保留。后台回复关键字 “1024” 获取程序员大厂面试指南。

## 背景

就在昨天，一年一度的北京积分落户结果出来了，我们照旧来看看今年（2020年）的数据情况。

在看这篇文章之前，你可以通过如下文章来得到石头是如何快速拿到这些数据分析结果的：

- [优秀的程序员是如何利用工具来提升工作效率的？](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247487786&idx=1&sn=842202cc524477ec1546b4747bdbf1a8&chksm=eb4710cedc3099d86953451729c7f569866e6e58abbbec5c7ebe7423d12e1f11e189bb417f80&token=450646044&lang=zh_CN#rd)
- [Shell 助力开发效率提升](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247483767&idx=1&sn=3b271ed5fbb20ee875f41f1d704398f4&chksm=eb470093dc3089856c39d1181f93c851cf725a8522f2fc65bf72246e2fff97c8e8d7f62fa6b5&token=450646044&lang=zh_CN&scene=21#wechat_redirect) 
- [提升开发效率N倍的20+命令行神器!(附 demo)](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247489026&idx=1&sn=cf1650652a44d65730c5ee04258ad9e1&chksm=eb4717e6dc309ef037674943645abe8356aa726416ea46f3349ba227520bd40c95f8a49aa3e5&token=2077533801&lang=zh_CN#rd)

数据可以通过北京市人力资源和社会保障局官方网站下载获取，[关于2020年积分落户公示及落户办理有关工作的通告](http://rsj.beijing.gov.cn/ywsite/jflh/gg/202010/t20201015_2111656.html)。[公示名单](http://fuwu.rsj.beijing.gov.cn/nwesqintegralpublic/settleperson/settlePersonTable) 形如：

![2020 年积分落户公式名单](/resources/use-shell-to-analysis-2020-people-of-getting-residence-of-beijing-by-score/2020 年积分落户公式名单.png)

点击每一项明细可以获得积分具体数值，以最高分为例：

![2020积分落户最高分明细](/resources/use-shell-to-analysis-2020-people-of-getting-residence-of-beijing-by-score/2020积分落户最高分明细.png)

然后，稍微动点小技巧即可获取完整的 6032 条记录。若你想获取石头初步处理后的 excel 数据，可直接后台回复 “2020积分落户” 取得。

## 数据分析

输入就是下载处理后的 csv，每行分别为“姓名、出生年月、单位名称、积分分值”。 

本文将从 积分分数分布、公司分布、年龄分布 等几个方面做简单分析。 

![2020年积分落户数据CSV](/resources/use-shell-to-analysis-2020-people-of-getting-residence-of-beijing-by-score/2020年积分落户数据CSV.png)

### 分数分布

我们来看看积分分布情况，大部分人积分分布在 97~102 分之间。这个分数虽然没有高考相差那么夸张，但一个 0.01 也能相差不少人，比如有 98 人都得了 97.5 分。98.17 有 39 人，少 0.01 的 98.16 有 21 人。 

```bash
➜  积分落户2020数据分析 git:(master) ✗ awk '{print $5}' 10000.csv |sort | uniq -c | sort -nr -k 1  | head -n 10
  98 97.50
  84 97.25
  80 97.33
  73 97.17
  72 97.21
  67 98.50
  66 98.00
  61 97.46
  57 98.46
  54 97.13
➜  积分落户2020数据分析 git:(master) ✗ awk '{print $5}' 10000.csv |sort | uniq -c | sort -nr -k 1  | grep 98.17
  39 98.17
➜  积分落户2020数据分析 git:(master) ✗ awk '{print $5}' 10000.csv |sort | uniq -c | sort -nr -k 1  | grep 98.16
  21 98.16
➜  积分落户2020数据分析 git:(master) ✗ 
```

![2020年北京积分落户积分分布](/resources/use-shell-to-analysis-2020-people-of-getting-residence-of-beijing-by-score/2020年北京积分落户积分分布.png)



按照上次[首批积分落户数据分析](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247488114&idx=1&sn=b6191483135ecd7f7c0b735bc2dbe7a7&chksm=eb471396dc309a80ba8df35f9e04ab585a80cb3f9e485fdf4c9afd380200c2d109b28335a00b&token=2077533801&lang=zh_CN#rd) 的老规矩，拿到这个文件，比如希望你用最快的方法获得以下信息，你将会怎么做？

- 获取取得户口名额最多的top10公司
- 获取取得户口名额的人中姓氏最多的
- 获取年龄分布

当然，方法有很多，比如熟悉各种编程语言的，例如 `python, php, java` 等等写个简单的脚本程序，也能比较快获取答案。或者把相应的数据提取出来，放到 excel 中也可以。

如果你对 Shell 很熟悉，那真的是分分钟，应该是秒秒钟就能获取答案。本文不对 Shell 具体每个命令做过多的解释，不熟悉的同学可以直接 `man $cmd` 或者 `$cmd --help` 等等查看。

之前我也写过一篇名叫 [Shell 助力开发效率提升](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247483767&idx=1&sn=3b271ed5fbb20ee875f41f1d704398f4&chksm=eb470093dc3089856c39d1181f93c851cf725a8522f2fc65bf72246e2fff97c8e8d7f62fa6b5&token=450646044&lang=zh_CN#rd) 的文章，算是给常用的命令的常用参数做了一个解释和示例，有兴趣的同学可以前往查阅。 显然这次的输入数据比上次 [首批的 json 数据](https://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247488114&idx=1&sn=b6191483135ecd7f7c0b735bc2dbe7a7&chksm=eb471396dc309a80ba8df35f9e04ab585a80cb3f9e485fdf4c9afd380200c2d109b28335a00b&token=2077533801&lang=zh_CN#rd) 更简单。

### 获取取得户口名额最多的top10公司


直接`awk` 得到公司名字，对结果进行`sort`排序进行去重`uniq`统计得到重复次数，次时结果为`重复次数 公司名`，再对第一列`-k 1`重复数字进行按照数字排序逆序`-nr` 即 `sort -nr -k 1`，最后取结果的前10行 `head -n 10`。

```bash
➜  首批积分落户  > grep 'unit' jifenluohu.json| cut -f2 -d: | sort | uniq -c | sort -nr -k 1 | head -n 10
 137  "北京华为数字技术有限公司"
  73  "中央电视台"
  57  "北京首钢建设集团有限公司"
  55  "百度在线网络技术（北京）有限公司"
  48  "联想（北京）有限公司"
  40  "北京外企人力资源服务有限公司"
  40  "中国民生银行股份有限公司"
  39  "国际商业机器（中国）投资有限公司"
  29  "中国国际技术智力合作有限公司"
  27  "华为技术有限公司北京研究所"
  
  ➜  积分落户2020数据分析 git:(master) ✗ awk '{print $4}' 10000.csv |sort | uniq -c | sort -nr -k 1 | head -n 10
 112 北京华为数字技术有限公司
  71 中央电视台
  28 北京外企人力资源服务有限公司
  28 华为技术有限公司北京研究所
  27 中国石油天然气股份有限公司管道北京输油气分公司
  27 北京首钢建设集团有限公司
  24 中国建筑第二工程局有限公司
  24 腾讯科技（北京）有限公司
  24 联想（北京）有限公司
  23 中国新华航空集团有限公司
```

对比上次的结果看， “华为” 又是榜首，中央电视台又位列第二，百度下去了，腾讯起来了。（“北京外企人力资源服务有限公司”）挂靠在 FESCO 下的外企，仍然挤进前 10 了。

以下是有户口指标前 50 的公司分布，快看看你的公司是否在榜（完整公司排名名单请后台回复“2020积分落户”获取）。

![2020年北京积分落户公司分布](/resources/use-shell-to-analysis-2020-people-of-getting-residence-of-beijing-by-score/640-20201018150727450.png)



### 获取取得户口名额的人中姓氏最多的

看看想通过积分落户，最好是姓啥，哈哈。

看结果还是姓 "张, 王" 之类的最有戏。 😁 
```bash
➜  首批积分落户  > grep '"name":' jifenluohu.json| sed 's|"name": "||g' | sed 's| ||g' | cut -c 1 | sort | uniq -c | sort -nr -k 1 | head -n 10
 541 张
 531 王
 462 李
 376 刘
 205 陈
 193 杨
 166 赵
 132 孙
  95 郭
  95 徐
  
➜  积分落户2020数据分析 git:(master) ✗ awk '{print $2}' 10000.csv |cut -c 1 | sort | uniq -c | sort -nr -k 1 | head -n 10
 553 王
 477 李
 457 张
 369 刘
 173 陈
 168 杨
 165 赵
 126 孙
 114 周
 100 吴  
```

对比这个数据，才发现真的是很牛 X，前 10 名的姓氏中，只有两个不一样。估计这是否也符合整个中国的姓氏？哪里能拿到这部分数据？可以验证一下。

![2020北京积分落户姓氏分布](/resources/use-shell-to-analysis-2020-people-of-getting-residence-of-beijing-by-score/640-20201018150737725.png)

为了把石头的姓氏“唐”找出来，取了前 50 个，发现像平时不怎么常见的姓氏还能入围前 50，还是很有意思的呢。比如“于”、“丁”等。

### 获取户口名字中叫啥名最流行

这个数据没啥意思就不给了，看看重名的数据吧。

```bash
➜  积分落户2020数据分析 git:(master) ✗ awk '{print $2}' 10000.csv  | sort | uniq -c | sort -nr -k 1 | head -n 10
   9 王鹏
   6 王伟
   6 张颖
   5 赵静
   5 石磊
   5 王琳
   5 王燕
   5 王涛
   5 王勇
   5 孙涛
```

作为码农，必须得养成对自己得到结果进行自测的习惯，所以如果对自己的结果不够自信，可以正向去计算一下最终的结果。

例如可以简单`grep`一下进行验证，叫 "王鹏" 的是不是9个。

```bash
➜  积分落户2020数据分析 git:(master) ✗ grep '王鹏' 10000.csv
202000543	王鹏飞	1979-02	北京航天发射技术研究所	104.09
202001150	王鹏	1980-03	中国扶贫基金会	101.80
202001449	王鹏	1972-10	北京汇众博思信息科技有限公司	101.25
202002088	王鹏	1977-11	银河航天（北京）通信技术有限公司	100.42
202002114	王鹏	1977-05	《中国经济周刊》杂志社	100.38
202002753	王鹏	1976-11	北京睿驰青果科技有限公司	99.66
202003455	王鹏	1983-04	北京首创股份有限公司	98.96
202003514	王鹏飞	1980-07	云粒智慧科技有限公司	98.92
202003694	王鹏	1976-05	上海创景计算机系统有限公司北京办事处	98.75
202003763	王鹏	1980-01	北京兴庆房地产土地评估有限公司	98.71
202004190	王鹏	1980-09	北京欧拓技术有限公司	98.34
```

### 获取年龄分布

```bash  
# 拿到出生年后, 直接通过 awk 计算结果输出
➜  首批积分落户  > grep '"idCard":' jifenluohu.json| cut -f2 -d: | cut -c 9-12 |awk '{print 2019-$1}' | sort | uniq -c
   3 34
  13 35
  39 36
 109 37
 162 38
 302 39
 507 40
 773 41
 799 42
 813 43
 757 44
 586 45
 507 46
 378 47
 238 48
   4 49
   9 50
   1 51
   4 52
   3 53
   2 54
   5 55
   1 56
   1 58
   1 59
   1 60
   1 61  
   
➜  积分落户2020数据分析 git:(master) ✗ awk '{print $3}' 10000.csv  | cut -f1 -d"-" |awk '{print 2020-$1}' | sort | uniq -c
   1 32
   3 35
  30 36
  83 37
 290 38
 468 39
 644 40
 741 41
 808 42
 751 43
 636 44
 507 45
 365 46
 329 47
 108 48
 107 49
  85 50
  27 51
   6 52
  10 53
   9 54
   8 55
   6 56
   5 57
   3 58
   2 59   
```

上次数据最大 61 岁，最小 34 岁，今年最新的数据最小 32 岁，最大 59 岁。这个 32 岁的看来很牛 X。 看看是谁？1988年出生。

```bash
➜  积分落户2020数据分析 git:(master) ✗ grep '1988' 10000.csv
202004964	XX磊	1988-07	中煤北京煤矿机械有限责任公司	97.71
```

这位 XX 磊同学确实优秀，（太具体了不太好，隐藏部分吧），看详细得分，因为有荣誉表彰 20 加分，查了下荣誉表彰指标里的“省部级及以上劳模”分为四类：全国劳模、享受全国劳模待遇人员、省部级劳模、享受省部级劳模待遇人员。

![2020年积分落户指标年龄最小者](/resources/use-shell-to-analysis-2020-people-of-getting-residence-of-beijing-by-score/640-20201018150743678.png)



年龄分布如下所示，主要还是集中在 38 ~ 47 岁之间。

![2020积分落户年龄分布](/resources/use-shell-to-analysis-2020-people-of-getting-residence-of-beijing-by-score/640-20201018151830149.png)



### 其他

这次的数据就先分享到这里，如果你有兴趣，可以到网站上采集更多数据（例如各项分数的明细，例如教育背景、合法稳定就业住所等）进行分析。

另外，如果你想计算一下自己能获得多少分，可以直接到官网网站进行计算，地址为：http://fuwu.rsj.beijing.gov.cn/integraltool/tool/simulation 

![积分落户模拟计算工具](/resources/use-shell-to-analysis-2020-people-of-getting-residence-of-beijing-by-score/640-20201018150747644.png)

> 关于作者：程序猿石头(ID: tangleithu)，现任阿里巴巴技术专家，清华学渣，前大疆后端 Leader，欢迎关注，交流和指导！
>
> 欢迎扫码加入互联网大厂内推群 & 技术交流群，一起学习、共同进步。后台回复关键字 “**0**” 送阿里技术大礼包。

