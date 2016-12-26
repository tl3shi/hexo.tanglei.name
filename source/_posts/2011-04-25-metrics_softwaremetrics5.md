---
id: 527
title: '软件度量复习整理-Software Metrics[五]'
date: 2011-04-25T11:19:25+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=527
duoshuo_thread_id:
  - 1351844048792453308
categories:
  - 软件度量及其应用
tags:
  - CMM
  - 软件度量
---
## Measuring External Product Attributes

测试产品外部属性

Predicting external attributes via measuring and analyzing internal attributes, because:

The internal attributes are often available for measurement early in the life cycle, whereas external attributes are measurable only when the product is complete.

Internal attributes are often easier to measure than external ones.

预测外部属性通过测试和分析内部属性，因为：内部属性通常在生命周期的早期，然后外部属性只能是在产品完成后才可以测试。

External attributes  – Software quality. 外部属性就是说软件的质量。

**What is “Quality”?**

IEEE: The totality of features and characteristics of a product or service that bears on its ability to satisfy given needs.

R. Glass: The degree of excellence of something. We measure the excellence of software via a set of attributes.

质量的定义：

IEEE：产品的总体特征或者服务能够满足需求。

R. Glass：优秀度，通过软件的一系列属性描述的一个产品优秀程度。

### Quality Model: ISO 9126 Quality Model

 ****

<img class="alignnone" title="ISO9126" src="/wp-content/uploads/2011/04/Software%20Metrics.files//image016.gif" alt=""  />

6个特性，27个子特性

<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="80">
      功能性
    </td>
    
    <td width="405">
      准确性、适合性、互操作性、保密安全性+依从性
    </td>
  </tr>
  
  <tr>
    <td width="80">
      效率
    </td>
    
    <td width="405">
      时间、资源+依从性
    </td>
  </tr>
  
  <tr>
    <td width="80">
      易用性
    </td>
    
    <td width="405">
      易操作性、易理解性、易学性、吸引性 +依从性
    </td>
  </tr>
  
  <tr>
    <td width="80">
      可靠性
    </td>
    
    <td width="405">
    </td>
  </tr>
  
  <tr>
    <td width="80">
      维护性
    </td>
    
    <td width="405">
    </td>
  </tr>
  
  <tr>
    <td width="80">
      可移植性
    </td>
    
    <td width="405">
    </td>
  </tr>
</table>

 ****

### Boehm software Quality Model

<img class="alignnone" title="Boehm" src="/wp-content/uploads/2011/04/Software%20Metrics.files//image018.gif" alt=""  />

 ****

**模型的三层次式框架如图所示。总体适用性：可移植性** **可维护性**

### McCall’s Quality Model (1978)

<img class="alignnone" title="McCall" src="/wp-content/uploads/2011/04/Software%20Metrics.files//image020.gif" alt=""  />

 ****

**正确性、可靠性、效率、完整性、可用性**

### Capability Maturity Model (CMM)

A framework to determine process maturity。过程成熟度

Initial: Few defined processes; success depends on individual effort.

Repeatable: Cost, schedule, and product tracking processes in place.

Defined: Standard processes are defined and used.

Managed: Defined processes and product qualities are meaningfully measured.

Optimizing: Measures used to improve process/product.

初始级：很少的定义过程，通过个人努力能够成功。

可重复级：成本，进度和产品过程。

已定义级：定义和遵循了标准过程。

可管理级：良好定义的过程，产品质量可以良好测试。

优化级：持续改进过程/产品。

<p style="text-align: center;">
  <a href="/wp-content/uploads/2011/04/cmm.png"><img class="size-medium wp-image-528 aligncenter" title="cmm" src="/wp-content/uploads/2011/04/cmm.png" alt=""  /></a>
</p>

### Portability

“A set of attributes that bear on the capability of software to be transferred from one environment to another.”

<img class="alignnone" title="可移植" src="/wp-content/uploads/2011/04/Software%20Metrics.files//image022.gif" alt=""  />

### Reliability

“A set of attributes that bear on the capability of software to maintain its evel of performance under stated conditions and a stated period of time.”

defect density 缺陷密度= no. of known defctes / product size. 一直的缺陷数量处于产品大小

where product size is measured in terms of LOC, and the known defects are discovered through testing, inspection or other techniques.

### Usability

Usability of a software product is the extent to which the product is convenient and practical to use. (Boehm 1978)

Good usability includes:

– Well-structured manuals

– Good use of menus and graphics

– Information error messages

– Help function

– Consistent interfaces

### The MUSiC project

<img class="alignnone" title="Music" src="/wp-content/uploads/2011/04/Software%20Metrics.files//image026.jpg" alt=""  />

 ****

### Maintainability

<img class="alignnone" title="可维护性" src="/wp-content/uploads/2011/04/Software%20Metrics.files//image028.jpg" alt=""  />

 ****

### Quality by Domain

Product quality can also vary across application domains.

Within a domain, requirements may also call for qualities that are at odds with each other.

### Real-Time System Qualities

Systems that monitor/control/analyze real world events in real-time

Response time constraints

Reliability

Safety (absence of undesirable behaviors that can cause hazards)

Usability

### Embedded Systems

Systems that interface only with hardware

Reliability

Efficiency of performance

Safety

Robustness

### Information Systems

Systems that process and deliver information to facilitate business processes

Data Integrity

Usability

Robustness

Maintainability

### Distributed Systems

Systems in which computing elements and data storage are physically distributed

Fault tolerance

Reliability

Availability

Data integrity

Transparency

本节完……
