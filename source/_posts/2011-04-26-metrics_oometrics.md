---
id: 543
title: 软件度量-面向对象软件度量
date: 2011-04-26T02:34:16+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=543
duoshuo_thread_id:
  - 1351844048792453191
categories:
  - 课程学习
tags:
  - 软件度量
---
## Object-Oriented Metrics

OOSE metrics are different because of:

Localization

Encapsulation

Information hiding

Inheritance

面向对象软件爱你度量不同于其他度量因为：

本地化、封装型、信息隐藏、继承性

## LK Metrics

LK量度组是由Lorenz和Kidd提出的，他们把基于类的量度分为四种类型：规模、继承、内部（特性）和外部（特性）。

LK:Class Size

### CS

Total number of operations (inherited, private, public) 操作数的总数

Number of attributes (inherited, private, public) 属性的总数

May be an indication of too much responsibility for a class 可能暗示了类的职责。

LK:Number of Operations Overridden 重写方法数

### NOO

A large number for NOO indicates possible problems with the design，NOO值过大暗示类的设计出问题了。

Poor abstraction in inheritance hierarchy继承级别抽象度低。

LK:Number of Operations Added

### NOA

The number of operations added by a subclass 子类增加的方法数

As operations are added it is farther away from super class

As depth increases NOA should decrease.

子类方法增多，应该离父类越来越远，随着深度增加，NOA应该减少。

### SI

LK:Specialization Index 专业化指数

SI = [NOO * L] / Mtotal

L is the level in class hierarchy:L是类层次级别。

Mtotal is the total number of methods：Mtotal是方法总数。

Higher values indicate class in hierarchy that does not conform to the abstraction。值越大暗示类的层次不符合抽象性。

## CK metrics

CK量度组由Chidamber和Kemerer提出，他们建议使用6种基于类设计的量度，通称为CK量度组。

[<img class="aligncenter size-full wp-image-544" title="ck" src="/wp-content/uploads/2011/04/ck.png" alt="CK Metrics"  />](/wp-content/uploads/2011/04/ck.png)

### WMC

(1) 每个类的加权方法WMC (weighed Methods per Class)

WMC=∑Ci (i=1～n)

其中，Ci为一个类的各个方法（或操作或服务）的复杂性，相当于传统方法中的环路复杂性，Ci可相加。方法的数量和它们的复杂性是用来实现和测试一个类工作量总量的指示器。方法的数量越大，继承树（所有子类都继承父类的方法）就越复杂。对一个给定的类，随着方法的数量增大，其应用很可能变得越来越专门化，由此将限制其可能的重用。所以，WMC的值应当合理。

计算：类中方法数量之和。

[<img class="aligncenter size-full wp-image-545" title="wmc" src="/wp-content/uploads/2011/04/wmc.png" alt="WMC"  />](/wp-content/uploads/2011/04/wmc.png)

WMC 4 shopping\_cart = 2;WMC 4 Credit\_Card = 1

### DIT

(2) 继承树的深度DIT (Depth of the Inheritance Tree)

这种量度被定义为从结点到树根的最大长度。

DIT的值越大，复杂性就越高。因为随着DIT的增大，层次的类可能会继承许多方法。当试图预测一个类行为时，困难不仅会增大，而且会增加设计的复杂性。当然DIT较大时，则表示有许多方法被重用，这是其好的一方面。

### NOC

(3) 子的数量NOC (Number of children)

子类在类的层次内，子类可以最直接地从属于一类。随着子类数量的增大，重用也增加了。但父类抽象的表示可能减少，即一些子类可能不是父类真正的成员，同时，测试数量（用来检查每个子类在操作前后的要求）也将增加。

### CBO

(4) 对象类间的耦合CBO

CBO(Coupling Between Object Classes)是指一个类合作（即相关）的数量。当CBO增大时，不仅降低了可重用性，而且使其修改和修改后的测试变得复杂。所以，每个类的CBO值应当保持合理。这与在传统软件中减少耦合的一般原则是一致的。

计算：类图中，与其他类关联的个数。

CBO(CreditCard)=2

CBO(ShoppingCart) =2

### RFC

(5) 对一个类的响应RFC (Response for a Class)

一个类的响应设置是一组方法，它可能被执行，用来响应接收到的类对象的消息，RFC被定义为响应设置方法的数量。

RFC增加，测试序列增加，测试工作量也将增加。由此可以得出，当RFC增大时，类的设计复杂性也将增大。

计算:类中涉及的方法个数，包括自身方法和调用其他类的方法。

例题：

RS = { methodA1, methodA2, methodB1, methodC1}

RFC = 4

[<img class="aligncenter size-full wp-image-546" title="rfc-demo" src="/wp-content/uploads/2011/04/rfc-demo.png" alt="RFC Metrics"  />](/wp-content/uploads/2011/04/rfc-demo.png)

### LCOM

(6) 方法中聚合的不足LCOM (Lack of Cohesion in Methods)

一个类内的每种方法访问一个或多个属性（也称实例变量）。LCOM是访问一个或多个相同属性方法的数量。

如果LCOM很大，则说明方法可以通过属性与其他方法耦合，这就增加了类设计的复杂性。通常，对LCOM值很大的类，可以把它分为两个或多个单独的类，这样每个类能的设计更方便。

这里讲的耦合和聚合与传统软件中所讲的是一样的。我们希望高聚合和低耦合，即保持低的LCOM。但在某些情况下，LCOM值很大也是合理的。

定义：Definition:

Class Ck with n methods M1,…Mn

Ij is the set of instance variables used by Mj

There are n such sets I1 ,…, In

P = {(Ii, Ij) | (Ii Ç Ij ) = Æ}

Q = {(Ii, Ij) | (Ii Ç Ij ) ¹ Æ}

If all n sets Ii are Æ then P = Æ

LCOM = |P| &#8211; |Q|, if |P| > |Q|

LCOM = 0 otherwise

计算：方法之间的含的成员变量。LCOM=没有交集的-有交集的

例子：

[<img class="aligncenter size-medium wp-image-547" title="LCOM" src="/wp-content/uploads/2011/04/LCOM.png" alt="LCOM Metrics"  />](/wp-content/uploads/2011/04/LCOM.png)

## MOOD metrics

PPT介绍得就太复杂了。了解下

[<img class="aligncenter size-full wp-image-548" title="MOOD" src="/wp-content/uploads/2011/04/MOOD.png" alt="MOOD Metrics"  />](/wp-content/uploads/2011/04/MOOD.png)

1995年,Brito等人针对面向对象属性提出一套称之为MOOD的度量算法集。MOOD度量是另一个著名的度量体系,它从封装性、继承性、耦合性和多性等四个方面给出了面向对象软件六个度量指标。MOOD反映出面向对象的特点,并给出了形式化的度量公式,具有很好的可操作性。

**封装性**的度量可以通过对属性隐蔽因子(At-tributeHiding Factor,简称AHF)和方法隐蔽因子(MethodHiding Factor,简称MHF)进行度量来表示。MHF表示系统中所有类的方法隐蔽的程度;AHF表示系统中所有类的属性隐蔽的程度。

对**继承性**的度量包括属性继承因子(AttributeInheritance Factor,简称AIF)和方法继承因子(Method Inheritance Factor,简称MIF)度量。MIF表示系统中所有类的方法继承的程度;AIF表示系统中所有的属性继承的程度。
  
对**多态性**的度量可以通过对多态因子(Poly-morphism Factor,简称PF)进行度量来表示。PF表示系统中所有类的方法使用多态机制的程度。
  
对**耦合性**的度量可以通过对耦合因子(Cou-plingFactor,简称CF)进行度量来表示。CF表示系统中所有类间的耦合程度。
