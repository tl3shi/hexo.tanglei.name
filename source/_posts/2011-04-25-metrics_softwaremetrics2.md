---
id: 521
title: '软件度量复习整理-Software Metrics[二]'
date: 2011-04-25T10:52:55+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=521
duoshuo_thread_id:
  - 1351844048792453253
categories:
  - 软件度量及其应用
tags:
  - Halstead
  - 数据流结构
  - 软件度量
  - 软件结构度量
---
<address>
  上接：<a href="/blog/metrics_softwaremetrics1.html">/blog/metrics_softwaremetrics1.html</a>
</address>

## Measuring Internal Product Attributes: Size

度量产品内部属性：大小

### Halstead’s Work

A program P is a collection of tokens, composed of two basic elements: operands and operators一个程序P是一些标记的集合，这些标记由2个基本的元素组成：操作数和操作符

Operands are variables, constants, addresses 操作数是变量、常量、地址值

Operators are defined operations in a programming language 操作符由编程语言定义

Number of distinct operators in the program (μ1) μ1是程序中出现的不同的操作符

Number of distinct operands in the program (μ2) μ2是程序中出现的不同的操作数

Total number of occurrences of operators in the program (N1)N1是总共出现的操作符

Total number of occurrences of operands in the program (N2)N2是总共出现的操作数

Program Vocabulary程序词汇量：μ =μ1 + μ2

Program Length程序长度: N = N1 + N2

Program Estimated Length程序估计长度N^=μ1log<sub>2</sub>μ1+μ2log<sub>2</sub>μ2

Program Volume程序容量：V=N log<sub>2</sub>μ=N log<sub>2</sub>(μ1+μ2)

Halstead认为V是编写长度为N的程序所需要的思维比较次数.V通常用来测量软件复杂度.

Potential Volume潜在容量V\*是一个算法的任意表达的最小容量(假设只有一个操作符，一个操作符只引用一次)V\*=(2+μ2*) log<sub>2</sub>(2+μ2*)；

Program Level程序等级L是一个算法的具体实现的抽象级别L= V*/V；最高值是1，当容量变大，级别变低。L能测量一个算法的不同实现表达层次。

Language Level语言级别l=LV*。

Intelligence Content智力内容I测量程序里表述了“多少”I=L^V=(2μ2)/( μ1N2) * N log<sub>2</sub>(μ1+μ2)；

– The difficulty: D = 1/L

– The estimate of L: Ĺ= 1/D = (2/ µ1) × ( µ2/N2)

– The estimated program length: Ń= µ1 × ㏑µ1 + µ2 × ㏑µ2

– The effort required to generate P:

E = V/ Ĺ= µ1 × N2 × N × ㏑µ/ 2 µ2

缺点：

Scalability issue (big estimation variance may occur for large software systems)对于大软件系统可能引起大的估计变化

Unable to be extended to include the size for specification and design 不能延伸至对需求说明和设计进行度量

Theoretical and empirical foundation of the theory need to be justified. 理论和经验基础需要合理。

Halstead方法与代码行相比，定义清晰，对具体的编程语言依赖性小，能为早期的设计提供支持，并且对开发人员技术的依赖性较小。

### Lengh:Code-LoC

SLOC/NCLOC:non-commented source line of code or effective lines of code.不带注释的代码行数。

CLOC：comented source line of code。注释代码行数

Total length LoC = SLOC + CLOC

**Advantages of LOC** **优点
  
** Simple and automatically measurable 测试简单可以自动化测试

Correlates with programming effort (& cost) 可以跟编程人力和成本关联起来

**Disadvantage of LOC** **缺点**

 ****Vague definition 模糊的定义

Language dependability 依赖与语言类型

Not available for early planning 早期不适用

Developers’ skill dependability 依赖于开发者技术经验

### Functionality

**Function Point (Previous Discussed)**

**Feature Point** **特征点**

Feature Point Analysis: in 1985, Capers Jones, extending the FPs counting to real-time and TLC environments MIS&RT&SC；1985年，CJ这个人，在功能点的基础上考虑到实时系统和TLC环境上指出的特征点分析(具体TLC，SC啥意思，没搞明白)。

计算方式：UfeC = 4Ni+5No+4Nq+7Nef+7Nif + 3Na.分别是输入，输出，查询，外部接口文件，内部文件，算法

“Algorithmic complexity” is high such as real-time, process control, and embedded software applications.算法复杂度高，比如在实时系统，过程控制和嵌入式系统软件应用里。

For MIS, functions and feature points produce similar results. For RT, feature points produce counts about %20~%35 higher than function points. MIS系统中，功能和特征点有相似的结果，实时系统中，特征点的结果约高于20%到35%之间。

跟FP比较：

As may be seen, for applications where the number of algorithms and logical data files are the same, Function Points and Feature Points will of course generate the same numeric totals. 可以看出，对应用中的算法和逻辑数据文件的数量是相同的，功能点和特征点当然会产生相同的数字总和。

When Feature Points and Function Points are used on classical MIS projects, the results are often almost identical.      应用于MIS项目时，结果几乎完全相同；

when applied to the more complex forms of system software, Feature Point counts are significantly higher.

当应用于更复杂的系统软件形态时，特征点的计数要高的显著的多.

**Object Point**

Object Point: in 1994, Kauffman, et. al. predict the functionality of a software product earlier in the life cycle than function points. 1994, Kauffman提出滴，预测软件产品在功能性在生命周期中比FP早。

Object points are used as an initial metric for size early in the development cycle. 对象点是在开发周期对尺寸的早期度量。

An initial size metric is determined by counting the number of screens, reports, and components that will be used. 度量由使用的窗口(screen)、报告(reports)、组件(components)的计数来决定

Each object is classified as simple, medium, or difficult. 每个对象都被归类为简单，中等或困难

**Use-case Point**

Use Case Point: in 1993, Gustav Karner，Use-Case is a method to develop requirements in object-oriented analysis and design. 93年，GK这家伙提出滴，用面向对象分析和设计思想来提高需求的一种方法。

Step 1: the total unadjusted actor weights (UAW) 未平衡用例角色数(UAW) 分3个等级，简单-平均-复杂。分别取值123.

Step 2: the total unadjusted use case weights (UUCW) 未平衡用例数(UUCW) 分3个等级，也是简单-平均-复杂。分别取值5-10-15。

Step 3: the unadjusted use case points (UUCP) UUCP = UAW + UUCW，未平衡用例点**(UUCP****，其中：UUCP = UAW + UUCW)**

Step 4: technical Complexity Factor (TCF) ，TCF=0.6+(0.01*TFactor) 技术复杂度因子**(TCF****其中：TCF=0.6+(0.01*TFactor))**

Step 5: the Environmental Factor (EF)，EF= 1.4+(-0.03*EFactor) 环境因子**(EF****其中：EF =1.4+(-0.03*EFactor))**

Step 6: the adjusted use case points (UPC)，UPC= UUCP\*TCF\*EF。平衡用例点**(UCP****其中：UCP= UUCP\*TCF\*EF)**

**未完待续……**
