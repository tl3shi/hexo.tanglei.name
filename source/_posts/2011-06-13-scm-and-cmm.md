---
id: 810
title: 软件配置管理与CMM-三库管理
date: 2011-06-13T09:47:50+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=810
duoshuo_thread_id:
  - 1351844048792453285
categories:
  - 软件配置管理
tags:
---
###### 软件配置管理与CMM/CMMI

###### <span style="font-size: 13px; font-weight: normal;">CMM/CMMI将软件配置管理的活动分为6个方面：SCM过程管理、软件配置标识、软件配置控制、软件配置状态统计、软件配置审计、软件发布管理和交付；</span>

Goals:

Software configuration management activities are planned.

Selected software work products are identified, controlled, and available.

Changes to identified software work products are controlled.

Affected groups and individuals are informed of the status and content of software baselines.

在CMM和CMMI中，将配置管理的目的定义为“建立和维护产品的完整性”，是其他配置管理目标的基础。

**三库管理：**三库的概念源自CMM/CMMI，即开发库、受控库和产品库。配置项在三库之间迁移，一级比一级的控制更严格。从CMM的角度来看，对开发库的管理并没有要求，但是对受控库和产品库是需要进行管理的。

[<img class="aligncenter size-medium wp-image-811" title="scm-cmm-three-repository" src="/wp-content/uploads/2011/06/scm-cmm-three-repository.jpg" alt="软件配置管理-三库管理"  />](/wp-content/uploads/2011/06/scm-cmm-three-repository.jpg)

**开发库**：存放开发过程中需要保留的各种信息，供开发人员专用。

**受控库**：在软件开发的某个阶段工作结束时，将工作产品存入或将有关的信息存入。

**产品库**：在开发的软件产品完成系统测试之后，作为最终产品存入库内，等待交付用户或现场安装。

按照三库的思路，软件开发组日常的工作在开发库中开展，当工作达到里程碑时，再迁移到受控库，在受控库中经过更严格的测试后，再上升到产品库，最后发布。实现三库的指导思想应该是逻辑上独立，物理上在一起(三库物理隔离带来的最大问题是配置项失去了历史可追溯性)，通过权限与流程的控制来实现配置项在不同库之间的流转，以及相应角色的人员对相应库的访问。不管是几个库，最终都是要提高管理效率和保存工作成果和工作记录。
