---
id: 2018
title: 平面点集的Delaunay三角剖分
date: 2012-11-08T00:36:23+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=2018
duoshuo_thread_id:
  - 1351844048792453264
categories:
  - 计算机图形学
tags:
  - 计算机图形学
---
<p style="text-align: justify;">
  <span style="font-size: 10pt;">作业中遇到三角剖分的问题，关键字&#8221;三角剖分&#8221;出来最多的就是&#8221;Delaunay&#8221;三角剖分，整理了下相关资料，记录备忘。<br /> </span>
</p>

<p style="text-align: justify;">
  <a href="#_Toc339392350"><span style="font-size: 10pt;">1.三角剖分与Delaunay剖分的定义<br /> </span></a>
</p>

<p style="text-align: justify;">
  <a href="#_Toc339392351"><span style="font-size: 10pt;">2. Delaunay剖分的算法</span></a><span style="font-size: 10pt;"><br /> </span>
</p>

<p style="text-align: justify;">
  <span style="font-size: 10pt;"><a href="#_Toc339392352">3. Bowyer-Watson算法 VS Lawson 算法</a></span>
</p>

<h3 style="text-align: justify;">
  1.三角剖分与Delaunay剖分的定义
</h3>

如何把一个散点集合剖分成不均匀的三角形网格，这就是散点集的三角剖分问题，散点集的三角剖分，对数值分析以及图形学来说，都是极为重要的一项预处理技术。该问题图示如下：

<p style="text-align: center; background: white;">
  <img src="/wp-content/uploads/2012/11/110712_1636_Delaunay1.png" alt="" /><span style="color: #333333; font-family: Tahoma;"><br /> </span>
</p>

#### 1.1 三角剖分定义

三角剖分：假设V是二维实数域上的有限点集，边e是由点集中的点作为端点构成的封闭线段, E为e的集合。那么该点集V的一个三角剖分T=(V,E)是一个平面图G，该平面图满足条件：
  
1.除了端点，平面图中的边不包含点集中的任何点。
  
2.没有相交边。
  
3.平面图中所有的面都是三角面，且所有三角面的合集是散点集V的[<span style="font-family: 宋体;">凸包</span>](http://zh.wikipedia.org/wiki/%E5%87%B8%E5%8C%85)(<span style="color: black;"><span style="font-family: 宋体; font-size: 11pt; background-color: white;">在<span style="color: #4f81bd;">二维<a title="欧几里得空间" href="http://zh.wikipedia.org/wiki/æ¬§å éå¾ç©ºé´">欧几里得空间</a>中，凸包可想象为一条刚好包著所有点的橡皮圈</span></span>)</span>。

<h4 style="background: white;">
  1.2. Delaunay三角剖分的定义<span style="font-size: 14pt;"><strong><span style="font-family: Cambria;"><br /> </span></strong></span>
</h4>

在实际中运用的最多的三角剖分是Delaunay三角剖分，它是一种特殊的三角剖分。

Delaunay边：假设E中的一条边e（两个端点为a,b），e若满足下列条件，则称之为Delaunay边：存在一个圆经过a,b两点，圆内(注意是圆内，圆上最多三点共圆)不含点集V中任何其他的点，这一特性又称空圆特性。
  
Delaunay三角剖分：如果点集V的一个三角剖分T只包含Delaunay边，那么该三角剖分称为Delaunay三角剖分。

#### 1.3.Delaunay三角剖分的准则<span style="color: #333333; font-family: Verdana; background-color: white;"><br /> </span>

要满足Delaunay三角剖分的定义，必须符合两个重要的准则：

1、空圆特性：Delaunay三角网是唯一的（任意四点不能共圆），在Delaunay三角形网中任一三角形的外接圆范围内不会有其它点存在。如下图所示：

<p style="text-align: center;">
  <a title="查看图片" href="http://baike.baidu.com/albums/1691145/1691145/0/0.html" target="_blank"><span style="color: #136ec2; font-size: 1pt;">  </span></a><img src="/wp-content/uploads/2012/11/110712_1636_Delaunay2.jpg" alt="" />
</p>

2、最大化最小角特性：在散点集可能形成的三角剖分中，Delaunay三角剖分所形成的三角形的最小角最大。从这个意义上讲，Delaunay 三角网是&#8221;最接近于规则化的&#8221;的三角网。具体的说是指在两个相邻的三角形构成凸四边形的对角线，在相互交换后，六个内角的最小角不再增大。(_如果将三角网中的每个三角形的最小角进行升序排列，则Delaunay三角网的排列得到的数值最大，从这个意义上讲，Delaunay三角网是&#8221;最接近于规则化&#8221;的三角网。_)如下图所示：

<a title="查看图片" href="http://baike.baidu.com/albums/1691145/1691145/0/0.html" target="_blank"><span style="color: #136ec2; font-family: Arial; font-size: 1pt;">  </span></a>![](/wp-content/uploads/2012/11/110712_1636_Delaunay3.jpg)

最大化最小角特性是区分平面点集Delaunay三角剖分于高维点集所特有的性质。正式这一特性，delaunay剖分总是能尽可能避免病态三角形的出现，自动向等边三角形靠近，注意仅适用于平面点集，三维或者更高的delaunay三角剖分不具有相应的性质 (周知.三角剖分算法研究[D].哈尔滨理工大学,2007.)<span style="color: #333333; font-family: Tahoma;"><br /> </span>

#### 1.4.Delaunay三角剖分的特性

  1. <span style="background-color: white;">最接近：以最近临的三点形成三角形，且各线段(三角形的边)皆不相交。</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>
  2. <span style="background-color: white;">唯一性：不论从区域何处开始构建，最终都将得到一致的结果。（<strong>注意</strong>：<strong>出现四个或者更多的节点共外接圆的特殊情况时，delaunay三角划分不唯一</strong>[王成恩，2011</span>]<span style="background-color: white;">）</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>
  3. <span style="background-color: white;">最优性：任意两个相邻三角形形成的凸四边形的对角线如果可以互换的话，那么两个三角形六个内角中最小的角度不会变大。</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>
  4. <span style="background-color: white;">最规则：如果将三角网中的每个三角形的最小角进行升序排列，则Delaunay三角网的排列得到的数值最大。</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>
  5. <span style="background-color: white;">区域性：新增、删除、移动某一个顶点时只会影响临近的三角形。</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>
  6. <span style="background-color: white;">凸包性：三角网最外层的边界形成一个凸多边形的外壳。<br /> </span>

#### 1.5.局部最优化处理

<span style="background-color: white;">理论上为了构造Delaunay三角网，Lawson提出的局部优化过程LOP(Local Optimization Procedure)，一般三角网经过LOP处理，即可确保成为Delaunay三角网，其基本做法如下所示：</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>

  1. <span style="background-color: white;">将两个具有共同边的三角形合成一个多边形。</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>
  2. <span style="background-color: white;">以最大空圆准则作检查，看其第四个顶点是否在三角形的外接圆之内。</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>
  3. <span style="background-color: white;">如果在，修正对角线即将对角线对调，即完成局部优化过程的处理。</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>

<span style="background-color: white;">LOP处理过程如下图所示：</span>**
  
** 

![](/wp-content/uploads/2012/11/110712_1636_Delaunay4.jpg)

### <span style="text-align: justify;">2.Delaunay剖分的算法</span>

<span style="color: black;"><span style="font-family: Arial; background-color: white;">Delaunay</span><span style="font-family: 宋体; background-color: white;">剖分</span></span>是一种三角剖分的标准，实现它有多种算法。本文讲的是**逐点插入**的两种算法。

#### 2.1.Lawson算法

<span style="background-color: white;">逐点插入的Lawson算法是Lawson在1977年提出的，该算法思路简单，易于编程实现。基本原理为：首先建立一个大的三角形或多边形，把所有数据点包围起来，向其中插入一点，该点与包含它的三角形三个顶点相连，形成三个新的三角形，然后逐个对它们进行空外接圆检测，同时用Lawson设计的局部优化过程LOP进行优化，即通过交换对角线的方法来保证所形成的三角网为Delaunay三角网。</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>

<span style="background-color: white;">上述基于散点的构网算法理论严密、唯一性好，网格满足空圆特性，较为理想。由其逐点插入的构网过程可知，遇到非Delaunay边时，通过删除调整，可以构造形成新的Delaunay边。在完成构网后，增加新点时，无需对所有的点进行重新构网，只需对新点的影响三角形范围进行局部联网，且局部联网的方法简单易行。同样，点的删除、移动也可快速动态地进行。但在实际应用当中，这种构网算法当点集较大时构网速度也较慢，如果点集范围是非凸区域或者存在内环，则会产生非法三角形。</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>

<span style="background-color: white;">Lawson算法的基本步骤是：</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>

  1. <span style="background-color: white;">构造一个超级三角形，包含所有散点，放入三角形链表。(求解离散点集的凸包，建立点集凸包边界节点的初始Delaunay三角剖分)</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>
  2. <span style="background-color: white;">将点集中的散点依次插入，在三角形链表中找出包含插入点的三角形（只是点在内部，不是外接圆），将插入点同此三角形的全部顶点连接起来，构成三个小三角形。</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>
  3. <span style="background-color: white;">分别构造没个小三角形的外接圆，检测外接圆是否包含其他三角形顶点，如果三个三角形外接圆均不包含，则继续第二步插入新的点。若某个新三角形包含其他三角形顶点，则采用互换对角线方式形成新的局部Delaunay三角形，再判断新形成的局部delaunay三角形是否包含其他三角形顶点，直至新形成的局部delaunay三角形不包含其余三角形顶点。</span><span style="font-family: 宋体; font-size: 12pt;"><strong><br /> </strong></span>
  4. <span style="background-color: white;">循环执行上述第2步，直到所有散点插入完毕。</span><span style="font-family: 宋体; font-size: 12pt;"><br /> </span>

最后删除超级三角形相关联的三角形即可。

#### 2.2 Bowyer-Watson算法

Bowyer算法由英国Bath大学的Bowyer在1981年提出。算法首先构造离散点集的的若干离散点的[Voronoi图](http://en.wikipedia.org/wiki/Voronoi_diagram)，根据Voronoi领域准则连接临近点，得到初始Delaunay三角剖分，然后逐步加入剖分点，每加入一个点就对已有的Voronoi图进行修改，构造新点集的Voronoi图，直到所有点都插入完毕。具体论文是这篇[Computing Dirichlet Tesselations](http://scholar.google.com.hk/scholar?q=Computing+Dirichlet+Tesselations)。

Watson算法由澳大利亚悉尼大学Watson在1981年提出。算法采用空外接圆准则，直接从三角剖分入手。算法从初始三角划分开始，每加入一个离散点，找出所有外接圆包含此点的三角形，删除这些三角形面向该插入点的边，得到包含此点的多边形，将此点与多边形的定点连接就构成新的Delaunay三角剖分，重复此过程直至所有点插入完毕为止。注意，此算法当四点或以上共圆时将产生错误。论文是这篇[Computing the n-Dimensional Delaunay Tessellation with Application to Voronoi Polytopes](http://scholar.google.com.hk/scholar?hl=zh-CN&as_sdt=0,5&q=Computing+the+n-Dimensional+Delaunay+Tessellation+with+Application+to+Voronoi+Polytopes)。

Bowyer-Watson算法是根据上述两者算法相互补充改进得到的(貌似跟Watson算法差不多，具体可以参考上述两篇论文)，仍然是一种插点增量算法的一种。算法逻辑如下：

  1. <div style="text-align: justify;">
      求解离散点集的凸包，建立点集凸包边界节点的初始三角形划分；
    </div>

  2. <div style="text-align: justify;">
      选择另外的离散点，插入指定位置，在已有的三角形中找出<strong>外接圆</strong>包含此点的三角形，并删除公共边，得到一个包含新插入点的多边形；
    </div>

  3. <div style="text-align: justify;">
      将此点与多边形的其他顶点连接起来，构成新的三角形划分；
    </div>

  4. <div style="text-align: justify;">
      重复插点知道所有点插入完毕。
    </div>

最后删除超级三角形相关联的三角形即可。

### <span style="text-align: justify;">3.Bowyer-Watson算法 VS Lawson 算法</span>

Bowyer-Watson算法和Lawson 算法**区别和联系**。

#### 3.1 Bowyer-Watson Algorithm

  * <div style="text-align: justify;">
      <span style="font-size: 10pt;">form super triangle, enclosing all points p in V<br /> </span>
    </div>

  * <div style="text-align: justify;">
      <span style="font-size: 10pt;">as long as not all vertices of V have been treated, do:<br /> </span>
    </div>

1. insert vertex p in V into triangulation

2. find circumcircles containing p with corresponding triangles

3. remove triangles to get insertion polygon

4. retriangulate insertion polygon by simply adding edges to p

  * <div style="text-align: justify;">
      <span style="font-size: 10pt;">remove super triangle<br /> </span>
    </div>

![](/wp-content/uploads/2012/11/110712_1636_Delaunay5.png)

#### 3.2 Lawson Algorithm

  * <div style="text-align: justify;">
      <span style="font-size: 10pt;">form super triangle, enclosing all points p in V<br /> </span>
    </div>

  * <div style="text-align: justify;">
      <span style="font-size: 10pt;">as long as not all vertices of V have been treated, do:<br /> </span>
    </div>

1. insert vertex p in V into triangulation

<p style="margin-left: 11pt;">
  2. triangulate new p (draw edges to p from enclosing triangle, creating traingles)
</p>

<p style="margin-left: 11pt;">
  3. for all new triangles t created recursively:
</p>

<p style="margin-left: 11pt;">
  check circumcircle of t, if containing neighbouring vertex,，flip
</p>

  * <div style="text-align: justify;">
      <span style="font-size: 10pt;">remove super triangle<br /> </span>
    </div>

![](/wp-content/uploads/2012/11/110712_1636_Delaunay6.png)

![](/wp-content/uploads/2012/11/110712_1636_Delaunay7.png)

参考资料：

<http://baike.baidu.com/view/1691145.htm>

周知.三角剖分算法研究[D].哈尔滨理工大学,2007.

Henrik Zimmer. Voronoi and Delaunay Techniques.2005

[面向科学计算的网格划分与可视化技术](http://www.amazon.cn/gp/product/B005UKY13W/ref=as_li_qf_sp_asin_il_tl?ie=UTF8&camp=536&creative=3200&creativeASIN=B005UKY13W&linkCode=as2&tag=tangleiname05-23)
