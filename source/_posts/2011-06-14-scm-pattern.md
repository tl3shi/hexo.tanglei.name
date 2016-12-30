---
id: 837
title: 软件配置管理模式
date: 2011-06-14T11:38:00+00:00
author: tanglei
layout: post
guid: /blog/%e8%bd%af%e4%bb%b6%e9%85%8d%e7%bd%ae%e7%ae%a1%e7%90%86%e6%a8%a1%e5%bc%8f.html
duoshuo_thread_id:
  - 1351844048792453288
categories:
  - 课程学习
tags:
  - 软件配置管理
  - SCM
---
<span style="font-size:12pt"><strong>相关概念：<br /> </strong></span>

<span style="font-size:9pt"><strong>码线(codeline)</strong>：源代码文件与组成某个软件组件的其他人工制品（配置项）随着时间而变更的进展过程。码线包含沿着一条路径发展的各个配置项的每个版本。<br /> </span>

<span style="font-size:9pt">描述<strong>工作区结构</strong>的模式：私有工作区、储存库、私有系统构造、集成构造、第三方码线、任务级提交、冒烟测试、单元测试、回归测试。<br /> </span>

<span style="font-size:9pt">描述<strong>码线结构</strong>的模式:<span style="color:#ff3300; font-family:Tahoma"><strong><br /> </strong></span>主线、活动开发线、码线策略、私用版本、版本线、版本预备线、任务分支。<br /> </span>

<span style="font-size:12pt"><strong>私有工作区<br /> </strong></span>

<span style="font-size:9pt"><strong>问题：<br /> </strong></span>

<ol style="margin-left: 42pt">
  <li>
    <div style="text-align: justify">
      <span style="font-size:9pt">如何跟上不断变化的码线并取得进展，而不会为环境变化而分心？<br /> </span>
    </div>
  </li>
  
  <li>
    <div style="text-align: justify">
      <span style="font-size:9pt">在小组环境下开发软件涉及如下两步：变更代码，并测试变更+将代码跟其他人做的工作集成<br /> </span>
    </div>
  </li>
  
  <li>
    <div style="text-align: justify">
      <span style="font-size:9pt">连续集成：花费大量时间，但可以及时清除bug<br /> </span>
    </div>
  </li>
  
  <li>
    <div style="text-align: justify">
      <span style="font-size:9pt">一次集成太多导致查找bug很困难<br /> </span>
    </div>
  </li>
</ol>

<span style="font-size:9pt"><strong>解决方案：<br /> </strong></span>

<ol style="margin-left: 42pt">
  <li>
    <div style="text-align: justify">
      <span style="font-size:9pt">以隔离工作的方法控制变更 (Isolate your work to change control)<br /> </span>
    </div>
  </li>
  
  <li>
    <div style="text-align: justify">
      <span style="font-size:9pt">在私有工作区工作，在那里控制你正在做的代码和组件的版本。你可以完全控制你的环境何时以及如何变更。<br /> </span>
    </div>
  </li>
  
  <li>
    <div style="text-align: justify">
      <span style="font-size:9pt">定期更新工作区，不能远离&#8221;主流&#8221;太久。<br /> </span>
    </div>
  </li>
</ol>

<span style="font-size:12pt"><strong>储存库<br /> </strong></span>

<span style="font-size:9pt"><strong>问题：</strong>如何获得填充新工作区的正确组件的正确版本？<br /> </span>

<span style="font-size:9pt"><strong>解决方案：</strong>One stop shopping（一站式购物）：从单一访问点（即储存库）获得你的代码和有关的人工制品，使创建的开发者工作区尽可能简单与透明。<br /> </span>

<span style="font-size:12pt"><strong>冒烟测试<br /> </strong></span>

<span style="font-size:9pt">在将代码更改嵌入到产品的源树中之前对这些更改进行验证的过程。冒烟测试一般用于每日构建(Daily build)，构建服务器首先从配置库服务器上，下载最新的源代码，然后编译单元测试，运行单元测试通过后，编译可执行文件，可执行文件若可运行，并能执行最基本的功能，则认为通过了冒烟测试。<br /> </span>

<span style="font-size:9pt">最基本的测试，目的就是先通过最基本的测试，如果最基本的测试都有问题，就直接打回开发部（不放入新的版本中），减少测试部门时间的浪费。缺点在于覆盖面很有限。冒烟测试的执行者是开发人员或版本编译人员。<br /> </span>

<span style="font-size:9pt">每次构造都必须进行冒烟测试，以显而易见的方式验证应用未被损坏。<br /> </span>

<span style="font-size:9pt">冒烟测试对捕获&#8221;特别显眼&#8221;的bug和放过琐细的bug相当有用。<br /> </span>

<span style="font-size:9pt">理想情况下，冒烟测试应该是自动化的，它不能代替比较深入的集成测试。可以把单元测试作为冒烟测试的基础。<br /> </span>

<span style="font-size:9pt">当给系统增加新的基本功能时，需要将冒烟测试扩展到新增加的功能。<br /> </span>

<span style="font-size:12pt"><strong>主线:<br /> </strong></span>

<p style="margin-left: 21pt">
  <span style="font-size:9pt"><strong>问题：<br /> </strong></span>
</p>

<ol style="margin-left: 42pt">
  <li>
    <div style="text-align: justify">
      <span style="font-size:9pt">如何使当前活动码线的数目保持在容易管理的水平，避免项目的版本树长得太宽太密？如何使合并的开销减至最小？<br /> </span>
    </div>
  </li>
  
  <li>
    <div style="text-align: justify">
      <span style="font-size:9pt">分支是组织文件版本和显示版本历史的手段。<br /> </span>
    </div>
  </li>
  
  <li>
    <div style="text-align: justify">
      <span style="font-size:9pt">分支是隔离变更的强有力机制。<br /> </span>
    </div>
  </li>
  
  <li>
    <div style="text-align: justify">
      <span style="font-size:9pt">当分支需要集成时，需要合并这些变更，但通常合并有时候可能很麻烦。<br /> </span>
    </div>
  </li>
  
  <li>
    <div style="text-align: justify">
      <span style="font-size:9pt">人们似乎既迷恋分支，又害怕分支。<br /> </span>
    </div>
  </li>
  
  <li>
    <div style="text-align: justify">
      <span style="font-size:9pt">分支与所使用的版本控制工具密切相关，如VSS很麻烦，但CVS相对容易很多。<br /> </span>
    </div>
  </li>
  
  <li>
    <div style="text-align: justify">
      <span style="font-size:9pt">既要使码线的并发性达到最大，又要使推迟集成可能造成的问题减至最小。<br /> </span>
    </div>
  </li>
</ol>

<span style="font-size:9pt"><strong>解决方案：</strong>简化分支模型：开发单个产品版本时，在主线上进行开发。主线是&#8221;主码线&#8221; (home codeline)，除了特殊情况之外，全部开发工作都在主线上进行。分支时，先考虑总体战略，然后再创建分支。当拿不准时，尽量采用简单的模型。既要使码线的并发性达到最大，又要使推迟集成可能造成的问题减至最小。<br /> </span>

<span style="font-size:12pt"><strong>每日构建 (Daily Build)<br /> </strong></span>

<p style="margin-left: 21pt">
  <span style="font-size:9pt">daily build 就是把一个软件项目的所有的最新的代码从配置库中取出，然后从头进行编译、链接和运行。更甚者可以再运行测试包对软件的主要功能进行测试，发现并报告错误的整个过程，通常由工具自动完成。<br /> </span>
</p>

<p style="margin-left: 21pt">
  <span style="font-size:9pt">daily build 一般是在每日下班后半夜进行，前提是员工check in 最新的code到配置库中，可以把daily build 戏称为 neightly build。然后在第二天上班事分析build 的log，找出error并mail给所属模块负责人，敦促解决（如果这一步能自动完成就更完美了）。<br /> </span>
</p>

<span style="font-size:9pt"> 按照上面的解释，daily build 译为&#8221;每日构建&#8221;，是很合适的。但daily build 的另一个重要功能就是验证软件中各模块关系是否正确，也可称为&#8221;每日集成&#8221;。</span>
