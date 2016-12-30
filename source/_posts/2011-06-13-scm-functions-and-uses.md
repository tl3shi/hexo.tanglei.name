---
id: 814
title: 软件配置管理功能与作用
date: 2011-06-13T09:54:06+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=814
duoshuo_thread_id:
  - 1351844048792453273
categories:
  - 课程学习
tags:
  - 软件配置管理
  - SCM
---
### 软件配置管理功能

SCM意义

a) 记录软件产品的演化过程

b) 确保软件开发者在软件生命周期中的各个阶段都能得到精确的产品配置

c) 最终保证软件产品的完整性、一致性、追朔性、可控性

1) 基线管理<span style="font-family: 'Times New Roman';">:</span>每个基线都将接受配置管理的严格控制，对其的修改将严格按照变更控制要求的过程进行，在一个软件开发阶段结束时，上一个基线加上增加和修改的基线内容形成下一个基线，这就是“基线管理”的过程。

建立基线的好处：

重现性：及时返回并重新生成软件系统给定发布版的能力，或者是在项目中的早些时候重新生成开发环境的能力。当认为更新不稳定或不可信时，基线为团队提供一种取消变更的方法。

可追踪性：建立项目工件之间的前后继承关系。目的是确保设计满足要求、代码实施设计以及用正确代码编译可执行文件。

版本隔离：基线为开发工件提供了一个定点和快照，新项目可以从基线提供的定点之中建立。作为一个单独分支，新项目将与随后对原始项目（在主要分支上）所进行的变更进行隔离。

基线管理的步骤：

(1) <span style="font-family: 宋体;">在开发前确定基线的“配置”</span>

(2) <span style="font-family: 宋体;">基线批准前，根据“配置”检查配置项是否齐备</span>

(3) <span style="font-family: 宋体;">对各个配置项，确认其版本的正确性</span>

(4) <span style="font-family: 宋体;">对每个配置项建立基线标志</span>

(5) <span style="font-family: 宋体;">基线变更管理</span>

(6) <span style="font-family: 宋体;">基线的各类报告和审计信息</span>

2) 变更管理<span style="font-family: 'Times New Roman';">:</span>如何保证它们在复杂多变的开发过程中真正处于受控的状态，并在任何情况下都能迅速的恢复到任一历史状态就要依赖变更管理。

变更管理流程：

a) （获得）提出变更请求；

b) 由<span style="font-family: 'Times New Roman';">CCB</span><span style="font-family: 宋体;">审核并决定是否批准；</span>

c) 为（被接受）修改请求分配人员，提取<span style="font-family: 'Times New Roman';">SCI</span><span style="font-family: 宋体;">，进行修改；</span>

d) 提交修改后的<span style="font-family: 'Times New Roman';">SCI</span><span style="font-family: 宋体;">，并测试（或者评审）；</span>

e) 重建软件的适当版本；

f) 复审（审计）所有<span style="font-family: 'Times New Roman';">SCI</span><span style="font-family: 宋体;">的变化；</span>

g) 发布新版本。

为了更好的指导变更范围的影响分析，可以通过两种表格来帮助发现受到变更影响的内容，一种是《需求跟踪表》，一种是《配置项依赖关系表》

3) 配置库管理：在实际开发活动中，为了让每个开发人员和各个开发团队能更好的分工合作，同时又互不干扰，必须规划好工作空间的管理，主要的手段是设置配置库（即文件夹设置）和设置版本的分支，用于实现对配置项权限管理。

设置版本分支：每个配置项从建立开始就划分成3个不同的分支：私有分支、集成分支、公共（主干）分支，让它们分别对应3类工作空间。私有分支对应的是开发人员的私有开发空间。集成分支对应的是开发团队的公共空间。公共分支对应的是整个软件开发组织的公共空间。上面定义的3类工作空间（分支）由配置管理员统一管理。

配置库的设置：决定配置库的结构是配置管理活动的重要基础，一般常用的是两种组织形式：按配置项类型分类建库和按任务建库。

配置库的日常工作。配置库的日常工作是一些事务性的工作，主要保证配置库的安全性，包括：对配置库的定期备份、清除无用的文件和版本、检测并改进配置库的性能等。

4) 版本管理

5) 配置审计：主要作用是作为变更控制的补充手段，来确保某一变更需求已被切实实现。审计机制保证修改的动作被完整地记录，四个“W”（Who、When、Why、What），记录了谁修改了这个工件，什么时候做的修改，为什么原因做出这个改动，以及修改了哪些地方。

配置审计分类：

PCA (Physics Configuration Audit)：即物理审计，主要是检查版本是否正确一致。<span style="font-family: 'Times New Roman';">(1) </span><span style="font-family: 宋体;">配置项是否齐备；</span><span style="font-family: 'Times New Roman';">(2) </span><span style="font-family: 宋体;">版本是否齐全，由非配置管理人员来进行。</span>

FCA (Function Configuration Audit)：即功能审计，主要是检查配置项是否完整，各种过程文档是否齐备、正确、与需求是否一致，归结为两点，即完全和齐备。

PCA一般由非配置管理人员来进行(因为审计的对象是配置管理人员)，而做FCA则可以由CMO来进行。

What

  * ü FCA<span style="font-family: 宋体;">：验证配置项的功能特性与需求（原始需求、变更请求… ）的一致性</span>
  * ü PCA<span style="font-family: 宋体;">：验证配置项的物理特性与期望（命名标准、变更流程… ）的一致性</span>

Why

  * ü 防止出现向用户提交不适合的产品，如交付了用户手册的不正确版本。
  * ü 发现不完善的实现，如开发出不符合初始规格说明书或未按变更请求实施变更。
  * ü 找出各配置项间不匹配或不相容的现象。
  * ü 确认配置项已在所要求的质量控制审查之后作为基线入库保存。
  * ü 确认记录和文档保持着可追溯性

When

  * ü 软件交付或<span style="font-family: 'Times New Roman';">release</span><span style="font-family: 宋体;">时</span>
  * ü 每个阶段结束时
  * ü 对于维护性项目，周期性地进行

Who

  * ü 非本项目组成员
  * ü 其他项目中的配置控制者
  * ü 内部审计者
  * ü SCM<span style="font-family: 宋体;">小组</span>

How-<span style="font-family: 宋体;">审计流程：</span>

  * ü 识别配置审计的时间<span style="font-family: 'Times New Roman';">[PM]</span>
  * ü 指派审计者<span style="font-family: 'Times New Roman';">[QA/Audit Group]</span>
  * ü 定义审计范围<span style="font-family: 'Times New Roman';">[PM&Auditors]</span>
  * ü 准备配置审计<span style="font-family: 'Times New Roman';">Checklist[Auditor]</span>
  * ü 通过评审（<span style="font-family: 'Times New Roman';">Review</span><span style="font-family: 宋体;">）、文档记录进行审计</span><span style="font-family: 'Times New Roman';">[Auditor]</span>
  * ü 识别不符合项<span style="font-family: 'Times New Roman';">[Auditor]</span>

  1. ü 关闭不符合项<span style="font-family: 'Times New Roman';">[PM]</span>
  2. ü 验证<span style="font-family: 'Times New Roman';">[Auditor]</span>

6) 配置报告：根据配置项操作的记录来向管理者报告软件开发活动的进展情况。这样的报告应该是定期进行，并尽量通过CASE工具自动生成，用数据库中的客观数据来真实的反映各配置项的情况。应着重反映当前基线配置项的状态，以作为对开发进度报告的参照。

### 软件配置管理作用

**软件配置管理对需方的作用**

a)         保证开发、操作和维护要求的完善；

b)        在受控条件下能够作出改变这些要求的灵活性；

c)        建立SCM活动和任务评价准则的基础；

d)        完全和非完全（工程发行）项的补充。

**软件配置管理对开发方的作用**

a)         查找满足这些要求的项和借助控制改变；

b)        通过提供附加在管理阶段的SCIs（这些情况中，生存周期过程中的主要软件产品）的状况，支持联合评审过程；

c)        通过集中符合性检查中可度量的结果，支持审核过程；

d)        支持质量保证、验证和确认过程，引伸到它们在软件生存周期中存在的范围。

**软件配置管理对技术人员的作用**

a)         这些基线能重建的具有保证的稳定基线；

b)        状况的一致信息；

c)        突出的要求的状况和相互依赖关系；

d)        变化的通知、分析和撤消；

e)         授权的变化机构；

f)          处理、贮存、复制、打包和发行SCIs的一致性方法。
