---
id: 860
title: “另类” 设计模式
date: 2011-06-17T08:30:05+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=860
duoshuo_thread_id:
  - 1351844048792453155
categories:
  - 网络文摘
  - 设计模式
tags:
  - 反模式
---
转自：<http://coolshell.cn/articles/4844.html> 另类设计模式，还不是我前看的反模式。但大概意思就差不多了吧。原文如下：

下面这篇文章来自这里：<a onclick="pageTracker._trackPageview('/outgoing/www.lsd.ic.unicamp.br/_oliva/fun/prog/resign-patterns?referer=http%3A%2F%2Fcoolshell.cn%2F');" href="http://www.lsd.ic.unicamp.br/~oliva/fun/prog/resign-patterns" target="_blank">http://www.lsd.ic.unicamp.br/~oliva/fun/prog/resign-patterns</a>，这篇文章有点意思了，山寨了我们著名的Design Pattern。这篇文章并不是很容易翻译，也许我翻译的不好，大家多指正。另外，这篇文章将失去原有的趣味在于其使用了经典设计模式的单词很相似的单词，一走眼你还以为是正二八经的设计模式。呵呵。所以，我在下文中，我会保留原有的英文单词，并把真正的23个经典设计模式的英文名放在旁边（灰色）。这篇文章和之前的<a title="如何写出无法维护的代码" href="http://coolshell.cn/articles/4758.html" target="_blank">如何写出无法维护的代码</a>有异曲同工，个人感觉都是比较欢乐的。

<p style="text-align: center;">
  <span style="font-size: 19px;"><strong>辞职模式</strong></span>
</p>

<p style="text-align: center; font-size: 14pt;">
  <strong>Resign<br /> Patterns<br /> </strong><strong><span style="color: #cccccc;">Design<br /> Patterns</span></strong>
</p>

<div style="text-align: center;">
  不合式的非面向项目软件开发病症<br /> Ailments of Unsuitable<br /> Project-Disoriented Software<br /> <span style="color: #cccccc;">Elements of<br /> Reusable Object-Oriented Software</span>
</div>

<div style="text-align: center;">
  <strong>作者</strong>：<a href="mailto:mitework@yercompany.com">Michael Duell</a>
</div>

<h4 style="text-align: left;">
  <strong>概要</strong>
</h4>

<div style="text-align: justify;">
  任何一个熟悉那本由四个人写的经典的设计模式书的朋友，应该知道那本书里的模式都是非常优雅和划时代的。然而，不幸的是，从那些老代码中无法提练出这些模式，因为，在出现这些模式前，大家都不会使用模式。因此，这项工作是从大量的代码中提练出一个模式的目录。这些模式都有充足和永恒的示例。希望你能享受阅读这些模式，但千万不要模仿并使用他们！
</div>

<h4 style="text-align: left;">
  1. Cremational Patterns 火葬模式 | <span style="color: #999999;">Creational patterns 创建模式</span>
</h4>

<div style="text-align: left;">
  下面是五个 cremational patterns.
</div>

<h5 style="text-align: left;">
  <strong>1.1 Abject Poverty  一贫如洗 | <span style="color: #999999;">Abstract Factory 抽象工厂</span></strong>
</h5>

<p style="text-align: justify;">
  Abject Poverty 模式能让你的软件相当难测试和维护，<br /> 并且需要巨大的财政支出，预算已经完全赤字。
</p>

<h5 style="text-align: left;">
  <strong>1.2 Blinder 眼罩模式 | <span style="color: #999999;">Builder 建造模式</span></strong>
</h5>

<p style="text-align: justify;">
  Blinder<br /> 模式是一个应急有效的解决方案，其不需要考虑需求在未来的变化。目前，我们还不太清楚我们为什么叫Blinder模式，一种说法是他们会在写代码的时候被设计人员戴上眼罩，另一种说法是他们希望在维护代码的时候挖出双眼。
</p>

<h5 style="text-align: left;">
  <strong>1.3 Fallacy Method 错误方法 | <span style="color: #999999;">Factory method 工厂方法</span></strong>
</h5>

<p style="text-align: justify;">
  Fallacy方法主要是在于处理一些不明显的案例。代码逻辑看上去是正确的，当只要某想要去测试一下，或是某个不明显的案例发生了，那些代码中的错误也就出现了。
</p>

<p style="text-align: justify;">
  <span id="more-4844"> </span>
</p>

<h5 style="text-align: left;">
  <strong>1.4 ProtoTry   尝试模式| <span style="color: #999999;">Prototype 原型模式</span></strong>
</h5>

<p style="text-align: justify;">
  ProtoTry<br /> 模式一个快速而肮脏的软件开发工作模型的尝试。这个模式的原意本来是想在后面有时间总结一下教训并改进或重写这些代码，但是可惜的是没有时间。所以，这些代码也就成了众所周知的<br /> legacy code – 旧代码。
</p>

<h5 style="text-align: left;">
  <strong>1.5 Simpleton 傻瓜模式 |<span style="color: #999999;"> Singleton 单例模式</span></strong>
</h5>

<p style="text-align: justify;">
  Simpleton<br /> 模式，是把一个终极复杂的模式用于那些最最没有价值的工作上。这个模式精确地指出了人员的能力程度。
</p>

<p style="text-align: justify;">
  &nbsp;
</p>

<h4 style="text-align: left;">
  <strong>2. Destructural Patterns 无结构模式 |<br /> </strong><span style="color: #999999;">Structural patterns  结构模式</span>
</h4>

<p style="text-align: left;">
  下面是七个经典的变性模式
</p>

<h5 style="text-align: left;">
  <strong>2.1 Adopter 领养者模式 |<span style="color: #999999;"> Adapter 适配器模式</span></strong>
</h5>

<p style="text-align: justify;">
  Adopter模式提供了一个给那些“孤儿函数”的家。这这些函数和整个大家族别的函数看上去一点也不一样，他们和整个家族的唯一联系就是通过我们的Adopter。
</p>

<h5 style="text-align: left;">
  <strong>2.2 Brig 监狱模式 | <span style="color: #999999;">Bridge 桥接模式</span></strong>
</h5>

<p style="text-align: left;">
  Brig 模式也就是那些坏代码的容器类。这就是众所周知的软件模块。
</p>

<h5 style="text-align: left;">
  <strong>2.3 Compromise 妥协模式 | <span style="color: #999999;">Composite 合成模式</span></strong>
</h5>

<p style="text-align: justify;">
  Compromise 模式主要用来平衡软件开发的工期和质量。 使用这个模式的结果是——劣质的软件<br /> + 延误的工期。
</p>

<h5 style="text-align: left;">
  <strong>2.4 Detonator 地雷模式 | <span style="color: #999999;">Decorator 修饰模式</span></strong>
</h5>

<p style="text-align: justify;">
  Detonator<br /> 模式是极其普通的，在程序中放置一些不易查觉的地雷。一个常见的经典示例是只用两位数来表示年份。这个炸弹已经暴露出来了，并在那等着爆炸！（陈皓注：作者这里说的是千年虫问题，本文写在1997年）
</p>

<h5 style="text-align: left;">
  <strong>2.5 Fromage 干酪模式 | <span style="color: #999999;">Facade 外观模式</span></strong>
</h5>

<p style="text-align: justify;">
  Fromage 模式让软件看上去满是漏洞。 Fromage<br /> 模式让我们的软件像Cheesy（芝士，也有劣质的意思）一样，有大量的奇淫巧技让你的软件没有任何一点可移值性。这个模式和奶酪一样，越是老越是香啊。
</p>

<h5 style="text-align: left;">
  <strong>2.6 Flypaper 捕蝇纸模式 | <span style="color: #999999;">Flyweight 享元模式</span></strong>
</h5>

<p style="text-align: justify;">
  Flypaper<br /> 模式的意思是，代码是由设计的人完成，而由另一个人维护。维护着这个模式的那个写代码的人发现自己被粘住了，而且很有可能在软件失支控制前夭折。
</p>

<h5 style="text-align: left;">
  <strong>2.7 ePoxy 沥清模式 |<span style="color: #999999;"> Proxy 代理模式</span></strong>
</h5>

<p style="text-align: justify;">
  ePoxy<br /> 模式主旨把软件的模式紧密地耦合在一起。随着耦合模块的增加，我们就可以看到沾粘它们的沥清。
</p>

#### **3. Misbehavioral Patterns 行为不检模式| Behavioral Patterns
  
行为模式**

下面是11个行为不检点模式

##### **3.1 Chain of Possibilities 可能性链模式 | <span style="color: #999999;">Chain of responsibility 责任链模式</span>**

<p style="text-align: justify;">
  Chain of Possibilities<br /> 模式主旨是创造肥大的，拙劣文档的软件模块。没有人知道其功能有多宽泛，其可能性永无止境。也就是我们所说的——无确定性。
</p>

##### **3.2 Commando 突击队模式 | <span style="color: #999999;">Command<br /> 命令模式</span>**

<p style="text-align: justify;">
  Commando<br /> 模式主旨是用来应付工作，让事情快点完成。这个模式不管封装，只图快快把代码写完。反正不犯法。
</p>

##### **3.3 Intersperser 散布模式| <span style="color: #999999;">Interpreter<br /> 解释器模式</span>**

<p style="text-align: justify;">
  Intersperser<br /> 模式把一个功能的代码散布在系统的各个地方，其可以让功能无法被测试，修改，以及让人读懂。(陈皓注：这让我想起了以前VB，PB和Delphi的开发，功能的逻辑代码散步在各个组件的不同事件中)
</p>

##### **3.4 Instigator 煽动模式| <span style="color: #999999;">Iterator<br /> 迭代器模式</span>**

Instigator 模式看上去是良性的，但是其却大规模的以暴力的方式在破坏软件系统。（陈皓注：作者没有做过多的解释，不过，我想到了<a title="Windows编程革命简史" href="http://coolshell.cn/articles/3008.html" target="_blank">Windows编程革命史</a>，应该说的就是这个吧）

##### **3.5 Momentum 冲击模式| <span style="color: #999999;">Memento<br /> 备忘模式</span>**

<p style="text-align: justify;">
  Momentum模式让软件大小，内存，CPU，和复杂度成极数级成长。（陈皓注：作者对此没做过多解释，这个特性很像Windows操作系统，每个Windows<br /> 的新版本，无论是在尺寸，内存和CPU要求上，和复杂度上都会比上一版有极数级的提高）
</p>

##### **3.6 Medicator 用药模式| <span style="color: #999999;">Mediator<br /> 媒介模式</span>**

Medicator 模式是一个实时的屠夫一样，其把其它的系统搞得就像被打过强力镇静剂一样没有反应。

##### **3.7 Absolver 免责模式| <span style="color: #999999;">Observer<br /> 观察者模式</span>**

<p style="text-align: justify;">
  Absolver模式表现于那些被以前员工开发的代码的问题。对于现任员工，其可以因为很多代码里历史上的问题而免除被批评，其声称其对软件中的任何问题都不负责。这也是我们从所周知的——“这不是我的代码”。（参看：<a title="程序员惯用的解释(Top 25)" href="http://coolshell.cn/articles/1174.html" target="_blank">程序员的借口</a>）
</p>

##### **3.8 Stake 利害关系模式 | <span style="color: #999999;">State<br /> 状态模式</span>**

<p style="text-align: justify;">
  Stake<br /> 模式表现于那些被现已成为经理的人写的代码中的各种问题。虽然这些问题很不爽，但是经理们在这个软件里的利害关系太高了，所以，不能让任何人重写，因为这代表着我们经理的技术成就。
</p>

##### **3.9 Eulogy 颂歌模式 | <span style="color: #999999;">Strategy策略模式</span>**

<p style="text-align: justify;">
  Eulogy 模式存在于所有的项目中，也就是 Post-Mortem(事后总结分析会)。
</p>

##### **3.10 Tempest Method 暴风雨模式| <span style="color: #999999;">Template<br /> Method 模板方法</span>**

<p style="text-align: justify;">
  Tempest Method<br /> 主要用在软件快要发布的最后几天。这个模式的物征是，代码中没有注释，并有使用了好几个Detonator Pattern 地雷模式。
</p>

##### **3.11 Visitor From Hell 地狱访问者模式 | <span style="color: #999999;">Visitor 访问者模式</span>**

<p style="text-align: justify;">
  Visitor From Hell<br /> 模式一般是在运行时没有检查数组越界的一个巧合。这样一来，我们系统就可以实现Visitor From Hell 模式，因为这样可以造成重要数据的重写。
</p>

<h4 style="text-align: left;">
  <span style="font-size: x-small;">参考</span>
</h4>

  * <span style="font-size: x-small;">[1] Gamma, E., Helm, R., Johnson, R.,<br /> Vlissides, J., Design Patterns – </span><span style="font-size: x-small;">Elements of Reusable Object-Oriented Software.<br /> Addison-Wesley, 1995.</span>

  * <span style="font-size: x-small;">[2] Michael Duell is an Engineer at AG<br /> Communication Systems, where his </span><span style="font-size: x-small;">Resign<br /> Patterns have been rejected in favor of the Gang </span><span style="font-size: x-small;">of Four Design Patterns.</span>

  * <span style="font-size: x-small;">[3] “Resign Patterns: Ailments of<br /> Unsuitable Project-Disoriented Software,” </span><span style="font-size: x-small;">The Software Practitioner, Vol. 7, No. 3, May-June<br /> 1997, p. 14.</span>
