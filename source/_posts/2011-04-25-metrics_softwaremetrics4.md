---
id: 525
title: '软件度量复习整理-Software Metrics[四]'
date: 2011-04-25T11:07:04+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=525
duoshuo_thread_id:
  - 1351844048792453371
categories:
  - 软件度量及其应用
tags:
  - 软件度量
---
<address>
  上接：<a href="/blog/metrics_softwaremetrics3.html">/blog/metrics_softwaremetrics3.html</a>
</address>

## Modularity and Information Flow Attributes

Module: a contiguous sequence of program statements, bounded by boundary elements, having an aggregate identifier (Yourdon and Constantine 1979).模块的定义：程序当中连续的代码序列，以分解元素界定，有一系列标识符。

– A module can be any object.一个模块可以是任意的对象。

– A program, unit, procedure, or function.一个程序，单元，过程或者函数。

### Coupling

Coupling is the degree of interdependence between mouldes.耦合说的是模块之间的互相依赖度。

Ri > Rj for i > j

No coupling relation R0: module x and module y have no communication.没有耦合，模块X和Y之间没有通信。

Data coupling relation R1 : x and y communicate by parameters, where each parameter is either a single data element or a homogeneous set of data items (no control element).数据耦合，X，Y之间通过参数进行通讯，每个参数是单一的数据元素，或者是同种数据集合（不含有控制元素）；

Stamp coupling relation R2 : x and y accept the same record type as a parameter.特征耦合：X和Y接受同种记录类型的参数。

Control coupling relation R3 : x passes a parameter (flag) to y with the intention of controlling its behavior.控制耦合：X传递一个标志参数去控制了Y的行为。

Common coupling relation R4 : x and y refer to the same global data.公共耦合：X和Y引用了相同的全局变量。

Content coupling relation R5 : x refers to the inside of y.内容耦合：X引用了Y的内部内容。

Loosely coupling: R1, R2. R1, R2.属于松散耦合。

Tightly coupling: R4, R5. R4, R5属于紧耦合。

**Coupling Measurement (1)**

Coupling between x and y:

c(x, y) = i + n/(n+1).

where i is the number corresponding to the worst coupling relation Ri between x and y, and n is the number of interconnections between x and y.(Fenton and Melton 1990)。X,Y的耦合度 = 最大级别耦合数i + n/(n+1) n是连接次数。

**Coupling Measurement (2)**

A measure of global coupling C of a system S consisting of modules D1, …, Dn, is defined in the following way:

C(S) is the median value of the set  {c(Di, Dj):1<=i<j<=n}

系统S的全局耦合度可以这样定义：其中S包含模块Di,集合的平均值就是系统S的全局耦合度。

### Cohesion

The cohesion of a module is the extent to which its individual components are needed to perform the same task.模块的内聚说的是它为了完成某个相同的任务，内部组件联合的强度。

<img class="alignnone" title="内聚" src="/wp-content/uploads/2011/04/Software%20Metrics.files//image010.gif" alt=""  />

功能内聚：模块完成独立良好定义的功能。(这是最强的内聚，指模块内所有元素共同完成一个功能，缺一不可)

顺序内聚：模块完成对于一个功能。（指一个模块中各个处理元素都密切相关于同一功能且必须顺序执行，前一功能元素输出就是下一功能元素的输入。）；

通信内聚：模块完成多个功能，但是是不同的数据。（指模块内所有处理元素都在同一个数据结构上操作（有时称之为信息内聚），或者指各处理使用相同的输入数据或者产生相同的输出数据。）

过程内聚：模块完成多个功能，他们都只跟一个总体过程相关。（构件或者操作的组合方式是，允许在调用前面的构件或操作之后，马上调用后面的构件或操作，即使两者之间没有数据进行传递）

时间内聚：在同一时间戳内完成了多个功能。（把需要同时执行的动作组合在一起形成的模块为时间内聚模块。）

偶然内聚：模块完成多个功能，它们不相关。（模块中的代码无法定义其不同功能的调用。但它使该模块能执行不同的功能，这种模块称为巧合强度模块。）

PPT上翻译出来不咋懂，后面参考百度百科。

Cohesion Ratio= no. of modules having functional cohesion / totoal no. of modules

内聚率=功能内聚模块个数/总共的模块数。

### Information Flow

Researchers have tried to examine elements information flow like the follow of information:

Total level of information flow through the system.

Total level of information flow between the individual modules and the rest of the system.

研究者试图从下面两个方面来测出信息流元素。系统的总过信息流级别；个别模块和系统剩余模块的信息流级别。

Information flow is based on fan-in and fan-out. 信息流基于扇入和扇出。

Fan-in of a module M is the number of local flows that terminate at M, plus the number of data structures from which information is retrieved by M.模块M的扇入是本地流终止于M加上重新返回M的数据流。[PPT有错，PPT上说的都是Fan-out]

Fan-out of a module M is the number of local flows that emanate from M, plus the number of data structures that are updated by M。模块M的扇出是从M散出的，加上被M更新的数据结构。

a local direct flow occurs if either:

A module invokes a second module and passes information to it; or

The invoked module returns an outcome to the calling module.

局部直接流出现的情况：一个模块调用另一个模块，将信息传递给它。或者，被调用的模块返回结果给调用它的模块。

**Henry and Kafura’s Metrics**

Information flow complexity(M)= length(M)\*((fan-in(M)\*(fan-out(M))<sup>2</sup>

**Shepperd’s Metric**

Shepperd complexity (M)= ((fan-in(M)*(fan-out(M))<sup>2</sup>

<img class="alignnone" title="shepperd" src="/wp-content/uploads/2011/04/Software%20Metrics.files//image014.gif" alt=""  />

Shepperd宣称他的方法是在原有的基础上有改进滴：我们的度量特征是它们消除信息和控制流的模糊性，集中在信息流的度量上，而henry和kafura度量是不能做到的

**Information flow Advantages** **优点**

Measures total level of information flow between the modules of a system.测量了系统的总体信息流级别。

Evaluates potential design changes.评估了潜在的设计改变。

Allows the identification of design problems such as modules with a large amount of fan-in and fan-out.能够鉴别设计错误比如一个模块含有大量的扇入扇出。

Can be produced in the design stage。在设计阶段能够出结果。

Takes into account data-driven programs. 将数据驱动的程序纳入了考虑范围。

Address issues such as complexity and cohesion.说名了复杂度和内聚性。

Suitable for identifying software that exhibits maintenance problems and may be error prone and unreliable. 适于鉴定软件有维护性问题，易于发现错误和不可靠。

Appropriate for identifying lack of cohesion, stress points and missing levels of design abstraction.适于发现缺少内聚度，敏感点，和抽象设计缺失。

Provides motivation for their use in the prediction of cohesion.推动了内聚性的预测。

**Information flow disadvantages** **缺点**

All the flows have equal weighting.所有的流有相同的权重。

If there is no external interactions can give misleading values.如果没有外部交互可能引起误判。

Underestimates local and global information flows.低估了局部和全局信息流。
