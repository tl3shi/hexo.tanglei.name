---
id: 431
title: eclipse插件Metrics结果分析
date: 2011-04-13T08:29:18+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=431
duoshuo_thread_id:
  - 1351844048792453281
categories:
  - SoftwareEngineering
tags:
  - eclipse插件
  - Metrics
  - 软件度量
---
软件度量的课就要这么完了，都还没有感觉呀。要检查项目，用了eclipse的插件，metrics感觉还不错。不过有的结果不知道啥意思，网上查了下，结合自己的理解，在这里记下来了，分享了。刚开始准备就在图片里面写写了事，不过有的太长了。还是另外再加些内容吧。

<p style="text-align: center;">
  <a href="/wp-content/uploads/2011/04/eclipse_metrics.jpg" target="_blank"><img class="aligncenter size-medium wp-image-432" title="eclipse_metrics" src="/wp-content/uploads/2011/04/eclipse_metrics.jpg" alt=""  /></a>
</p>

主要参考内容来自：<http://metrics.sourceforge.net/>

**Normalized Distance****:** 在eclipse插件的官网上也没详细说明。| A + I &#8211; 1 |, this number should be small, close to zero for good packaging design.就说了计算方法，然后值越小越好，越接近0越能说明包设计好。至于A是啥I是啥也没说。网上查了下才搞明白了。 ****

也是Distance from the Main Sequence (DMS).The _Distance from the Main Sequence_ metric measures the balance between the abstraction and instability rates of the package.衡量抽象性和不稳定率之间的平衡率.

According to what function a package has to perform, it must be able to be unstable, in other words, often significantly or abstractly modified.  It must be sufficiently general to be adaptable to widely diverse situations, either without being modified or with only minimal modifications.  It is preferable to have a balance between these contradictory criteria.根据一个包功能的定义，包应该是不稳定的，换句话说，就是要在没有修改或者修改量很笑的情况下适应不同环境的变化，要有一个较好的平衡与这两个冲突的标准。

Computation计算For a package, the balance between abstraction and instability is obtained through the following expression: | A + I &#8211; 1 |是Abstraction+Instablity-1的绝对值，Abstraction抽率，Instablity不稳定率。一般范围在50%到100%之间。I和A后面会讲。

**Number of Classes****：**类数量**。**

**Specialization Index****：**Average of the specialization index, defined as NORM \* DIT / NOM. This is a class level metric 覆盖方法的数量\*继承深度/方法数。是一个类级别的度量。

**Instability (I)**: The Instability metric measures the rate of instability of a package.  A package is unstable if it depends more on other packages than they depend on it.说的是包的不稳定性。一个包不稳定当它依赖的包多余其他包依赖它的时就说一个包不稳定。 The ratio of efferent coupling (Ce) to total coupling. I = Ce / (Ce + Ca). This metric is an indicator of the package&#8217;s resilience to change. The range for this metric is 0 to 1, with I=0 indicating a completely stable package and I=1 indicating a completely instable package.

**Abstractness** (A): The number of abstract classes (and interfaces) divided by the total number of types in a package。measure**s a** package&#8217;s abstraction rate度量一个包的抽象性。The package&#8217;s abstraction level corresponds to its stability level.是跟它稳定性级别是相符的。

**Number of Attributes****：**属性数量 ****

**Number of Packages**：包数量

**Method Lines of Code****：**方法代码行****

**Weighted methods per Class****：**Sum of the McCabe Cyclomatic Complexity for all methods in a class.每个方法的圈复杂度和。

每个类的加权方法WMC (weighed Methods per Class)

WMC=∑Ci (i=1～n)

其中，Ci为一个类的各个方法（或操作或服务）的复杂性，相当于传统方法中的环路复杂性，Ci可相加。方法的数量和它们的复杂性是用来实现和测试一个类工作量总量的指示器。方法的数量越大，继承树（所有子类都继承父类的方法）就越复杂。对一个给定的类，随着方法的数量增大，其应用很可能变得越来越专门化，由此将限制其可能的重用。所以，WMC的值应当合理。

**Number of Overridden Methods****：**覆盖方法数

**Number of Static Attributes****：**static属性数量****

**Nested Block Depth****：**The depth of nested blocks of code.代码块的嵌套深度

**Number of Methods;**方法数量****

**Lack of Cohesion of Methods:** A measure for the Cohesiveness of a class. Calculated with the Henderson-Sellers method: If m(A) is the number of methods accessing an attribute A, calculate the average of m(A) for all attributes, subtract the number of methods m and divide the result by (1-m). A low value indicates a cohesive class and a value close to 1 indicates a lack of cohesion and suggests the class might better be split into a number of (sub)classes.缺少的方法内聚。如果m(A)是方法中访问属性A的次数，计算所有属性的访问次数的平均值，再减去方法数量，除以1-m。这个值越小说明内聚性越好，如果大了接近1则按时缺少内聚，建议把它分成几个子类。

一个类内的每种方法访问一个或多个属性（也称实例变量）。LCOM是访问一个或多个相同属性方法的数量。 如果LCOM很大，则说明方法可以通过属性与其他方法耦合，这就增加了类设计的复杂性。通常，对LCOM值很大的类，可以把它分为两个或多个单独的类，这样每个类能的设计更方便。这里讲的耦合和聚合与传统软件中所讲的是一样的。我们希望高聚合和低耦合，即保持低的LCOM。但在某些情况下，LCOM值很大也是合理的。

**McCabe Cyclomatic Complexity**：圈复杂度。我还记得有3种计算方法，圈数量=边-节点+2=判断+1 ，网上讲得很多，在此不说了。

**Number of Parameters****：**参数数量****

**Abstractness****：**The number of abstract classes (and interfaces) divided by the total number of types in a package

**Number of Interfaces****：**接口数量****

**Number of Children****：**子类数量**，**子类在类的层次内，子类可以最直接地从属于一类。随着子类数量的增大，重用也增加了。但父类抽象的表示可能减少，即一些子类可能不是父类真正的成员，同时，测试数量（用来检查每个子类在操作前后的要求）也将增加。

**Depth of Inheritance Tree****：**继承树深度，DIT的值越大，复杂性就越高。因为随着DIT的增大，层次的类可能会继承许多方法。当试图预测一个类行为时，困难不仅会增大，而且会增加设计的复杂性。当然DIT较大时，则表示有许多方法被重用，这是其好的一方面。

****
