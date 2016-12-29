---
id: 504
title: 软件度量复习整理-Software Measurement
date: 2011-04-22T15:20:24+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=504
duoshuo_thread_id:
  - 1351844048792453343
categories:
  - 课程学习
tags:
  - 软件度量
---
下周三《软件度量及其应用》就要考试了，今天看了下PPT，总结了下。PPT是英文的，就当是再此熟悉下英语单词吧。第一章是讲测量的相关概念滴。

测量的定义：A common definition states that &#8220;measurement is a process by which numbers or symbols are assigned to attributes of entities of a software product, process, or project.&#8221; 测量是一个用数字或者符号来表示一个软件产品、过程或者项目实体属性的过程。

** ****Humphrey, author of Capability Maturity Model (CMM)** has developed a metrics-based framework, PSP (personal software process);IDEAL, a process improvement guideline from the CMM family of standards again emphasizes measurements

**ISO 9000:2000** focuses on measurement, analysis, and improvement. 专注与测量、分析和改进。

**ISO 9126** gives a framework for measuring software quality. (Functionality, Reliability, Usability, Efficiency, Maintainability, Portability)给出了测量软件质量的框架：功能性，可靠性，可用性，效率，可维护性，可移植性

**The Six** **Sigma** **movement**, in one of its modern forms, is centered on the DMAIC principle: define, measure, analyze, improve and control. 6σ质量改进**方法****:****以**DMAIC改进流程为中心，定义，测量，分析，提高，和控制。

** **Measurement, as a process, exhibits an internal evolution and happens in three phases:测量作为一个过程，有三个阶段：

  1. Measuring with the Mind: Cognitive Phase;认知
  2. Measuring with Words: Semantic Phase;语义
  3. Measuring with Numbers: Quantitative Phase.定量

**测量尺度类型** ：

标定和类型尺度属于语言尺度(Linguistic)。间隔尺度、比例尺度和绝对尺度属于定量尺度。****

**Nominal Scale(****标定尺度)**

Giving unique and unequivocal（不含糊） names to concepts and defining technical terms also belong to this scale. 标定尺度给出了唯一、不含糊的概念名称并且定义技术关系也属于标定尺度；

**Typological Scale** **（类型尺度）**

Identify types or categories in entities that have been already recognized and named.

This scale is also known as the nominal-categorical scale. 类型尺度识别实体中已经定义和命名的类型或种类（categories），也叫绝对标定尺度。

**Ordinal Scale (****序列尺度)**

Assessing values in measured entities and rearranging them according to the order of value. Both value and order are expressed using words or symbols. 估计已测量的实体的值并将他们按顺序重组排列，值和顺序均用字符或符号来表达。

**Interval Scale** **（间隔尺度）**

Used for perceiving increments, not ratios. There is no rational zero in this scale.用于理解增量而不是比例，没有不合理的0值。

**Ratio Scale (****比例尺度)**

Permits ratio calculation and equipped with rational zero reference point.允许比例计算和合理的0参考点。

**Absolute Scale(****绝对尺度)**

Used for counting. There is only one possible measure of an absolute attribute. 用于计数，只有一种可能的绝对属性测量值。

**小结：**

**Nominal**：Entities are classified. No arithmetic meaningful.实体分类，算术没有意义。eg Blood Groups: O+, A , AB , AB-,选择题中的ABC啊之类的。

**Ordinal**：Entities are classified and ordered. Cannot use + or -.实体分类和有序，不能用+/-.

**Interval**：Entities classified, ordered, and differences between them understood (‘units’). No zero, but can use ordinary arithmetic on intervals.实体分类、有序，之间有区别，跟单位相关，没有0值，但能用一般的算数。//可以用+/-,不能用*//

**Ratio**：Zeros, units, ratios between entities. All arithmetic.0值，单位，比例在实体之间，所有的算术可以用。

**Absolute**：Counting; only one possible measure. All arithmetic.计数，只有一种可能，所有的算数法则。

再看下这个几个单词的区别：

Metrics &#8211; The art or science of measurement

Metric &#8211; A standard of measurement

Measurement &#8211; the act or process of measuring

Measure &#8211; dimensions, capacity or amount of something

附上PPT上面的练习题目：

练习：For each of the following statements, explain whether or not it is meaningful and if the statement is meaningless say whether there is a “quick fix&#8221; which could make the statement more meaningful.

(a) 100C is the boiling point of water.
  
(b) Today is twice as hot as yesterday.
  
(c) The FT index fell 325 points today.
  
(d) The program is 50 lines of code long.
  
(e) The program took 3 months to write.
  
(f) The testing on this project took twice as long as the programming.
  
(g) The cost of maintaining program B is twice that of maintaining program A.
  
(h) Program A is more complex than program B.

(a) “100 C is the boiling point of water&#8221; is a meaningful. Degrees C is an interval scale since each degree is equal but the zero is arbitrary. Transformation to Fahrenheit scale is example of an affine transformation which is valid for interval scales.

(b) “Today is twice as hot as yesterday&#8221; is unlikely to be meaningful as weather temperature is measured in C or F which are not ratio scales (which would be required for “twice&#8221; to be meaningful). Differences are meaningful however, so if today is 10 degrees C, and yesterday was 5 degrees C, then it would be meaningful to say that today is 5 degrees hotter than yesterday.

(c) The FT index is an example of an indirect measure (calculated from the value of lots of different shares). The calculation is made such that the resulting value is on a ratio scale. The zero is meaningful (the shares have value) and the differences are equal.

(d)Depending on its precise definition, Line of Code is probably an absolute scale so the sentence is meaningful. Transformations which convert between lines of code measures for different languages may be empirically substantiated but are not valid for an absolute scale.

(e) (f)  Elapsed time is a ratio scale made by subtracting two points in time. Points in time are measured on interval scale (eg. 3/10/2002 10:11:30). Transformations of elapsed time such as 1 month = 20 working days are valid for elapsed time (ratio scale). But (31 Jan 1997) = 31 * (1st Jan 1997) is not valid since date is an interval scale.

(g) Cost is a ratio scale. Assuming we are talking about something like cost of maintenance per year, then the sentence is meaningful.

(h)Complexity however defined is likely to be at least an ordinal scale so the sentence is OK.
