---
title: 分析了获得家庭摇号新能源指标的数据后，我发现了一个秘密
layout: post
categories:
  - 经验技巧
tags:
  - MyLife
  - Shell
  - Mac 
  - 开发效率
---


>关于作者：程序猿石头(ID: tangleithu)，现任阿里巴巴技术专家，清华学渣，前大疆后端 Leader。以每篇文章都让人有收获为目的，欢迎关注，交流和指导！文章首发于微信公众号，欢迎关注。



这两天公布了北京首批家庭新能源小客车指标积分排序结果。

当然，意料之中，很遗憾，本人并未入围，排名 8W 左右。看样子，要想新能源积分排序上去，还得抓紧增加家庭代际数啊。 

![img](https://mmbiz.qpic.cn/mmbiz_png/ZMXDhhGnYibv6ysV7I9y3B0ZUNWNKuSR3MB5qmicS3EJI9OBbATewyZ83VuP8oLKa0T3icFibU9icYJVJ76nKhmVIvA/640.jpg)


让我们来看看这些数据都是怎样的？

网站下载了 pdf，不便于分析，显然作为程序猿还是习惯用程序员的方式来进行分析，首先还是先转为纯文本文件吧，可转换为 csv。

1. 网上有工具，可上传 pdf，转 csv。
2. 可以直接 copy 出来，粘贴纯文本即可。笔者采用了这种方式很快。

有了前面这两篇文章作为基础，下面这些数据可轻易获得：

1. [提升开发效率N倍的20+命令行神器!(附 demo)](http://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247489026&idx=1&sn=cf1650652a44d65730c5ee04258ad9e1&chksm=eb4717e6dc309ef037674943645abe8356aa726416ea46f3349ba227520bd40c95f8a49aa3e5&scene=21#wechat_redirect)
2. [没想到 Shell 命令竟然还能这么玩？| Shell 玩转大数据分析](http://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247488114&idx=1&sn=b6191483135ecd7f7c0b735bc2dbe7a7&chksm=eb471396dc309a80ba8df35f9e04ab585a80cb3f9e485fdf4c9afd380200c2d109b28335a00b&scene=21#wechat_redirect)

因为 copy 出来纯文本，姓名和身份证连在一起了，需要拆分一下，很简单：

``` 
cat car2020.csv | awk '{print substr($3, 1, match($3,/[0-9]/)-1) "\t"  substr($3, match($3,/[0-9]/)) "\t" $4 "\t" $5 "\t" $6 "\t" $7}' > car-2020.csv 
```

![摇号数据集csv](https://mmbiz.qpic.cn/mmbiz_jpg/ZMXDhhGnYibv6ysV7I9y3B0ZUNWNKuSR3ibL5T5lRuGK6u8J6M4IXbLWaficXw4c7qWlM3hUZELc2ILHEAicRDtic9g/640)

#### 分数分析 

首先，文件结果直接按照分数倒序的。

- 最高分 228 分，家庭共 7 个人组成。
- 最低分 72 分，2 代 4 人的家庭居多，也有 3 代 4 人的。

看看分数的分布，大多数围绕着 70 -120 分之间，占比 80%。

```shell
cat car-2020.csv | awk '{print $5}'  | uniq -c  | sort -k 1 -nr
```

![积分分布](https://mmbiz.qpic.cn/mmbiz_jpg/ZMXDhhGnYibv6ysV7I9y3B0ZUNWNKuSR3LpFNHXjGIosO9TOBW9cibJqf6icmJehOSdzK7CCe4gpMTfSSTic96cZYQ/640)

![](https://mmbiz.qpic.cn/mmbiz_png/ZMXDhhGnYibv6ysV7I9y3B0ZUNWNKuSR3eibFsp7PwzDgibkgotibibIp4pHnricjSm5LJicBFUbE6uMG7icZkErXfunMw/640)

#### 家庭情况

- 家庭代数， 近 70% 为 3 代人。

  ```shell
  ➜ Downloads cat car-2020.csv | awk '{print $4}'  | sort | uniq -c
  6621 2
  13379 3
  ```

  ![](https://mmbiz.qpic.cn/mmbiz_png/ZMXDhhGnYibv6ysV7I9y3B0ZUNWNKuSR3IPMnRyHkjxCXgZgD9dIlhxAR0sSLneJXqr6wYibJlia9aHxFebDk6QibA/640)

- 家庭人口数，居然还有 9 口人的。看了下，9 口人 3 代，猜测 双方父母 4 + 两口 2 + 3 小孩？还是怎样的，我看家庭主要申请人也是从第一期就开始申请摇号了，这么大一家人，也没个车牌，也是不容易啊。 

  ![](https://mmbiz.qpic.cn/mmbiz_png/ZMXDhhGnYibv6ysV7I9y3B0ZUNWNKuSR366icJickZFKaibZoctAmkib1k3MDQIFibLskNV9hqibRcREqiaarezGXWP3Ng/640)
  
  ```shell
  ➜  Downloads cat car-2020.csv | awk '{print $3}'  | sort | uniq -c
  4245 3
  5124 4
  6912 5
  2284 6
  1240 7
   193 8
     2 9
  ```

#### 摇号主申请人

太多人从第一年就开始了参与摇号了。 

```shell
➜  Downloads cat car-2020.csv | awk '{print substr($6, 1, 4)}'  | sort | uniq -c
6874 2011
7401 2012
3729 2013
1384 2014
 482 2015
 111 2016
  19 2017
```

![img](https://mmbiz.qpic.cn/mmbiz_png/ZMXDhhGnYibv6ysV7I9y3B0ZUNWNKuSR3cy2Md9RNibsEo1WYRlpM2mv4mK0zxIBRTM9qh9LhQKShTxv4Rn1ADYw/640)

看了下，从第一期摇号的就有 1367 个。 

```shell
➜  Downloads cat car-2020.csv | awk '{print substr($6, 1, 7)}'  | sort | uniq -c 
1367 2011-01
 797 2011-02
 665 2011-03
 519 2011-04
 473 2011-05
 356 2011-06
 424 2011-07
 448 2011-08
 407 2011-09
 516 2011-10
 434 2011-11
 468 2011-12
```

#### 中签者老家哪里的？

这个，需要借助身份证号对应的行政区域了，思路跟之前 [没想到 Shell 命令竟然还能这么玩？| Shell 玩转大数据分析](http://mp.weixin.qq.com/s?__biz=MzI3OTUzMzcwNw==&mid=2247488114&idx=1&sn=b6191483135ecd7f7c0b735bc2dbe7a7&chksm=eb471396dc309a80ba8df35f9e04ab585a80cb3f9e485fdf4c9afd380200c2d109b28335a00b&scene=21#wechat_redirect) 这篇文章上一样，直接给结论吧。先看按照省这个级别来划分的。

```shell
➜  Downloads join -1 2 -2 1 <(cat car-2020.csv | awk '{print substr($2, 1, 2)}' |sort | uniq -c | sort -k1 -nr | head -n 30 | sort -k2) id-area.code2.sort.txt | sort -k2 -nr
11 14792 北京市
13 1101 河北省
37 638 山东省
41 360 河南省
14 330 山西省
23 296 黑龙江省
21 291 辽宁省
42 239 湖北省
15 224 内蒙古自治区
22 217 吉林省
43 175 湖南省
61 174 陕西省
34 169 安徽省
32 162 江苏省
51 161 四川省
36 135 江西省
12 107 天津市
62 82 甘肃省
33 64 浙江省
35 53 福建省
65 46 新疆维吾尔族自治区
64 34 宁夏回族自治区
45 33 广西壮族自治区
50 21 重庆市
63 19 青海省
53 19 云南省
44 19 广东省
52 17 贵州省
31 12 上海市
46 6 海南省
```

- 第一列：身份证开头的两位，基本定位到省；
- 第二列：对应的人数
- 第三列：对应省

![](https://mmbiz.qpic.cn/mmbiz_png/ZMXDhhGnYibv6ysV7I9y3B0ZUNWNKuSR3C48bfHnDacmPqt5uCq60TkbTdSJcibtwgX3Xv2LFUGBof2ia8vyL1eJA/640)

从中可以看出，还是老北京占比最大，占比74%了。石头想找个免费的热力地图生成工具展示一下的，短时间之类没找到，先放弃了。

- 再看看到市区级别的，参考身份证前 6 位。

先看看前 30 的吧，基本也就是围绕着北京了。

```shell
➜  Downloads join -1 2 -2 1 <(cat car-2020.csv | awk '{print substr($2, 1, 6)}' |sort | uniq -c | sort -k1 -nr | head -n 30 | sort -k2) address_code_uniq.csv | sort -k2 -nr
110111 1592 房山区
110223 1531 通县
110224 1439 大兴县
110108 1109 海淀区
110105 1108 朝阳区
110222 1075 顺义县
110229 846 延庆县
110106 734 丰台区
110221 725 昌平县
110226 610 平谷县
110228 599 密云县
110102 570 西城区
110227 557 怀柔县
110101 475 东城区
110104 471 宣武区
110109 415 门头沟区
110103 382 崇文区
110107 332 石景山区
110225 189 房山县
131082 43 三河市
230103 34 南岗区
140202 28 城区
110110 25 燕山区
220104 24 朝阳区
150102 23 新城区
130102 23 长安区
610103 22 碑林区
130203 21 路北区
420106 19 武昌区
130681 18 涿州市
```

其中，address_code_uniq.csv 来自 https://raw.githubusercontent.com/jxlwqq/address-code-of-china/master/address_code.csv，有个坑的地方就是政府官方网站下载的行政区域代码数据 [http://www.mca.gov.cn//article/sj/xzqh/2020/](http://www.mca.gov.cn//article/sj/xzqh/2020/)是最新的，有的行政区域代码已撤销，不再使用。（幸亏石头校验了一下结果数据，发现相差比较大）

但之前已经核发的身份证中不能作废吧。举个例子：行政区划代码110223(北京市 通县)已撤销，新发的身份证中不再使用。

另外，还发现有一例不是用身份证号码作为证件号码的？看样子是护照？`CH1HFP********`  这个，我也不懂了。 

先就这么多吧。另外，若感兴趣的朋友需要本文分析的数据集合用作交流学习使用，可回复“积分排序”获取处理的 Excel和 CSV 文件。

附《摇号解题积分对照表》

![img](https://mmbiz.qpic.cn/mmbiz_png/ZMXDhhGnYibv6ysV7I9y3B0ZUNWNKuSR3eXbBD5fTYbiaRNowT5XL2icqqRnXDBKjvIbibiao8O1vnoicB88zLbKmiaOg/640)

回到题目本身，这个㊙️秘密就是：如果要想家庭摇号尽早“中签”，那就赶紧生娃吧，哈哈哈😝，别打我。