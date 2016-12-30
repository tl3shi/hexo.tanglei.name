---
id: 1664
title: LibSVM入门实例
date: 2012-03-28T23:23:07+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=1664
duoshuo_thread_id:
  - 1351844048792453358
categories:
  - 经验技巧
tags:
  - HelloWorld
  - 数据挖掘
  - SVM
---
搜索<a href="http://zh.wikipedia.org/wiki/SVM" target="_blank">SVM</a>入门，收录排名最前的应该就是这几篇文章了：<a href="http://www.blogjava.net/zhenandaci/archive/2009/02/13/254519.html" target="_blank">SVM 入门资料</a>。具体什么原理貌似挺高深的，我也没怎么去看其中的原理。这里我说的<a href="http://www.csie.ntu.edu.tw/~cjlin/libsvm/" target="_blank">LibSvm</a>就是SVM其中一个解决方案的软件包。

LIBSVM<sup><a name="_ftnref1_5888" href="#_ftn1_5888"></a>[1]</sup>是台湾大学林智仁(Lin Chih-Jen)副教授等开发设计的一个简单、易于使用和快速有效的SVM模式识别与回归的开源软件包。其软件主页在<http://www.csie.ntu.edu.tw/~cjlin/libsvm/>，最新版本是3.11，有很多相应语言(java,python,ruby,c#.etc.)的对应接口可以直接调用。

LibSVM的一般使用过程如下：

  * (1) 准备数据，使其符合软件包处理的特定格式；
  * (2) 利用数据进行缩放操作，此步是为了提高结果的精度和效率；
  * (3) 选定核函数；
  * (4) 设置相应的参数对训练集进行训练获取SVM模型；
  * (5) 利用得到的模型对测试集进行测试预测。

毕设涉及的一个课题，基于统计策略的序列数据挖掘在软件缺陷预测当中的应用。当中，自己实现了<a href="http://www.cse.ust.hk/~leichen/courses/comp630p/collection/reference-2-7.pdf" target="_blank">InfoMiner算法</a>，当中想试试用libSvm这个工具看看挖掘的模式的效果。下面将用简单的例子说明LibSVM的入门用法，实例中采用的是libsvm-3.11版本，在Windows系统中模拟。 本例中数据采用文献<a name="_ftnref1_4927" href="#_ftn1_4927"></a>[2]中的数据集中Mysql部分数据，利用InfoMiner算法，period=8，信息增益值最高的20个模式，再对训练/测试集中数据进行比较转换成特征向量得到。

**(1) LibSVM数据格式**

LibSVM使用的数据格式为<label> <index1>:<value1> <index2>:<value2> …

0 1:1 2:2 3:2 4:2 5:2 6:2 7:2 8:2 9:1 10:2

1 1:0 2:2 3:2 4:2 5:2 6:2 7:2 8:2 9:0 10:2

其中，这里每行的首个数字代表分类，后面一次是属性/特征值，index:value表示第index个特征/属性的值是value，如果跳过index，则表示index的属性值为0或者没有。这个值应该是来自于训练集，即训练集中每一个item对应有一个label，用于假定这个item对应的分类是label。

**(2) 数据缩放**

数据缩放将用到svm-scale.exe这个程序，其帮助提示为

Usage: svm-scale [options] data_filename

options:

-l lower : x scaling lower limit (default -1)

-u upper : x scaling upper limit (default +1)

-y y\_lower y\_upper : y scaling limits (default: no y scaling)

-s save\_filename : save scaling parameters to save\_filename

-r restore\_filename : restore scaling parameters from restore\_filename

用如下命令表示将datafilename进行缩放(默认的规则),将缩放后的数据结果重定向输出到scalefiname，并将这个缩放规则存储在save-filename中以便后面继续使用。

**svm-scale –s save-filename datafilename >scalefilename**

[<img title="clip_image002" src="/wp-content/uploads/2012/03/clip_image002_thumb3.jpg" alt="clip_image002"  />](/wp-content/uploads/2012/03/clip_image0024.jpg)

在利用下面的命令对另外的数据以已有的规则(规则文件**saved-filename**)进行缩放。

**svm-scale –r saved-filename datafilename >scalefilename**

[<img title="clip_image004" src="/wp-content/uploads/2012/03/clip_image004_thumb1.jpg" alt="clip_image004"  hspace="12" />](/wp-content/uploads/2012/03/clip_image0041.jpg)

**(3) 选定核函数**

关于核函数的相关介绍除了前面提到的那篇SVM入门八股外，可以参考[这个大神的blog](http://blog.pluskid.org/?p=685).反正我这里是没怎么看的。例子中的就用了默认罢了。

**(4) 训练**

用到的小程序是svm-train.exe,这个参数就多一点点，我就不贴其参考用法了。主要就是利用这个命令对训练集training\_set\_file进行训练，将生成的模型保存在文件model_file中。

svm-train [options] training\_set\_file [model_file]

[<img title="clip_image006" src="/wp-content/uploads/2012/03/clip_image006_thumb1.jpg" alt="clip_image006"  data-pinit="registered" />](/wp-content/uploads/2012/03/clip_image0061.jpg)
  
将第二步中生成的缩放后测试数据训练成模型保存在allPatterns.model文件当中。其中的参数，我暂时也不懂。可以到[这里详细了解](http://www.csie.ntu.edu.tw/~cjlin/libsvm/faq.html#f401)。

**(5) 测试**

利用svm-predict.exe进行预测。

命令将参与测试文件test\_file以模型model\_file进行对比预测，将结果保存在output_file。可选参数-b为1的话则保存其概率。

Usage: svm-predict [options] test\_file model\_file output_file

options:-b probability_estimates: whether to predict probability estimates, 0 or 1 (default 0); for one-class SVM only 0 is supported

[<img title="clip_image008" src="/wp-content/uploads/2012/03/clip_image008_thumb1.jpg" alt="clip_image008"  hspace="12" data-pinit="registered" />](/wp-content/uploads/2012/03/clip_image0081.jpg)

如上所示，第一次用的是由第二步中进行缩放的测试集文件test.scale得到的预测结果是100%，第二次运行的是没有缩放的，得到的结果是90%。预测的结果保存在predict.out，里面直接是测试集中每个记录的分类，是属于哪个label。

<hr align="left" size="1" width="33%" />

<a name="_ftn1_5888" href="#_ftnref1_5888"></a>[1] Chih-Chung Chang and Chih-Jen Lin. 2011. LIBSVM: A library for support vector machines. ACM Trans. Intell. Syst. Technol. 2, 3, Article 27 (May 2011), 27 pages.

<a name="_ftn1_4927" href="#_ftnref1_4927"></a>[2] David Lo, Hong Cheng, Jiawei Han, Siau-Cheng Khoo, Chengnian Sun. Classification of Software Behaviors for Failure Detection:A Discriminative Pattern Mining Approach[C]. Proceedings of the 15th ACM SIGKDD,New York, USA:ACM, 2009:557-565.
