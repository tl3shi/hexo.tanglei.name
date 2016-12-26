---
id: 512
title: '软件度量复习整理-Software Metrics[一]'
date: 2011-04-25T04:07:47+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=512
duoshuo_thread_id:
  - 1351844048792453396
categories:
  - 软件度量及其应用
tags:
  - 软件度量
---
##  基本概念

**软件度量定义**：用来量化软件产品，软件开发资源和软件开发过程的度量。包括可直接测量的对象如代码行，也包括通过测量计算得到的对象如软件质量。

**理解：软件度量(Metrics)**是指对软件产品、软件开发过程或者资源的简单属性的定量描述。

        产品：软件开发过程中所生成的各种文档和程序

        过程：与软件开发有关的各种活动，如软件设计等

        资源：软件开发过程中所需支持，如人员、费用等

    注意点

        定量描述,而不是定性描述

        简单属性,无需参照其它属性便可直接获得定量描述

**        ****软件测量(Measure)**是对软件产品、软件开发过程和资源复杂属性的定量描述，它   是简单属性度量值的函数，软件测量用于事后或实时状态, 如软件可靠性

    注意点

        定量描述,而不是定性描述

        复杂属性-不可直接获得、需参照其它属性的度量值

        实时或者事后状态,用于对历史进行评估

需要软件度量的原因：

    任何工程化的工作都需要度量，软件工程也不例外

    准确了解工程的实施情况

项目实施之前

    辅助制定软件项目的计划

    估算成本和工作量，以便制定计划

项目实施过程中

    提供软件开发的可视性

    跟踪和控制软件项目的开发

    评估软件开发质量，进行质量控制

    加强风险管理

项目实施之后

    对项目的实施情况进行评估

    为后续项目的积累经验数据

**Software Metrics Classification ****软件度量的分类**

**    Types of Entities ****实体种类：过程、产品、资源**

**    Types of Attributes ****属性种类：内部属性、外部属性**

**    Types of Metrics ****度量种类**

**软件度量内容：**

**    ****三个方面：过程、产品、资源**

**    ****两个层次：**

**        ****内部属性**

**            **软件产品，过程和资源本身所具有属性，如软件产品的复杂度、程序长度等

            易于度量

**        ****外部属性**

**            **软件产品，过程和资源与外部环境(用户、管理人员等)间的关系如成本、效益、      可靠性、可维护性等

            难以度量，但由内部属性所决定

** <img class="alignnone" title="两个层次" src="/wp-content/uploads/2011/04/Software%20Metrics.files//image002.gif" alt=""  />**

## Function Points

The function point of a software is the product of Unadjusted Function Count (UFC) and Value Adjustment Factor (VAF).软件的功能的是未调节功能计数与值调节因子的乘积。

**UFC**

Calculation of UFC involves physical counting of structural elements (on absolute scale) and choosing the weighting factors (on ordinal scale) according to the complexity level. The count and the weighting factor are multiplied to determine the function count.计算UFC涉及到结构元素的物理计数(绝对尺度)，和根据复杂程度选择权重因子(序列尺度)，计数和权重的乘积决定了功能的计数。

Number of user** inputs**: Every user input that offer clear application related data to the software is included.输入

Number of user **outputs**: Each user output that offers application related information to the user is identified.输出

Number of **enquiries**: An enquiry is described as an on-line input that produces an immediate software response via an on-line output.查询

Number of** files**: Each logic master file, for instance a logical group of data that might be a section of a database ort an individual file.文件

Number of **external interfaces**: All machine-readable interfaces (e.g. data files on disk or tape) that pass information to another system.外部接口

**VAF****：**These factors are evaluated on a scale (ordinal scale) that runs from 0 to 5。共涉及14个方面的问题，序列尺度从0-5选值。

**FP=UFC*VAF,Productivity = FP/PM;Documentation = pages/FP;**

**例题：**

** <img class="alignnone" title="demo" src="/wp-content/uploads/2011/04/Software%20Metrics.files//image004.gif" alt=""  /><img class="alignnone" title="anwser" src="/wp-content/uploads/2011/04/Software%20Metrics.files//image006.jpg" alt=""  />**

## Steps to Useful Software Metrics

Step 1 &#8211; Identify Metrics Customers 识别度量客户

Step 2 &#8211; Target Goals 目标

Step 3 &#8211; Ask Questions 问题

Step 4 &#8211; Select Metrics 选择度量方法

Step 5 &#8211; Standardize Definitions 标准定义

Step 6 &#8211; Choose a Model 选择模型

Step 7 &#8211; Establish Counting Criteria 建立计数标准

Step 8 &#8211; Decide on Decision Criteria 决定决策标准

Step 9 &#8211; Define Reporting Mechanisms 定义报表机制

Step 10 &#8211; Determine Additional Qualifiers 决定限定词

Step 11 &#8211; Collect Data 搜集数据

Step 12 &#8211; Consider Human Factors 考虑认为因素
