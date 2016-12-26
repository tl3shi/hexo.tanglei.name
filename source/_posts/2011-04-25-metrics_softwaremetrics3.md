---
id: 516
title: '软件度量复习整理-Software Metrics[三]'
date: 2011-04-25T10:53:00+00:00
author: tanglei
layout: post
guid: http://www.tanglei.name/?p=516
duoshuo_thread_id:
  - 1351844048792453412
categories:
  - 软件度量及其应用
tags:
  - 数据流结构
  - 软件度量
  - 软件结构度量
---
<address>
  上接：<a href="/blog/metrics_softwaremetrics1.html">/blog/metrics_softwaremetrics2.html</a>
</address>

## Measuring Internal Product Attributes: Structure

测量产品内部属性：结构

The structure of requirements, design, and code may help the developers to understand the difficulty they sometimes have in converting one product to another, in testing a product, or in predicting external software attributes from early internal product measures, such as maintainability, testability, reusability, and reliability. 需求，设计，编码的结构可能有助于开发者明白把一个产品转换成另一个，测试一个产品，或者从一个早期内部产品的测试，预测软件外部属性，如可维护性，可测试性，可重用性，和可靠性，是有难度滴。-翻译得有点水。

The structure of a product plays a part, not only in requiring development effort but also in how the product is maintained. 产品的结构不仅在开发时对人力的需求，而且在产品的维护上也扮演了重要作用。

**Types of structural measures** **结构度量分类**

Control-flow structure: the sequence in which instructions are executed in a program.控制流结构：指令在程序中执行的顺序。

Data-flow structure: the trail of a data item created or handled by a program. 数据流结构：一个程序中的数据项从创建到处理的轨迹。

Data structure: the organization of the data itself, independent of the program. 数据结构：数据本身的组织，独立于程序。

### Control-Flow Structure

McCabe’s cyclomatic complexity measure。 McCabe环路复杂度测量。

Definition: The cyclomatic number V(G) of a graph G with n vertices, e edges, and p connected components (连通分量) is V(G) = e – n ＋ P。定义：在图G中的复杂度V（G）=……，n节点，e边，p连通分量。MaCabe #CC

Theorem: In a strongly connected graph G, the cyclomatic number is equal to the maximum number of linearly independent circuits. 理论基础：在强联通图G中，复杂度=最大线性无关线环路数。

(引用下百科：V(G)=m-n+p其中，V(G)是有向图G中环路数，m是图G中弧数，n是图G中结点数，p是图G中强连通分量个数。在一个程序中，从程序图的入口点总能到达图中任何一个结点，因此，程序总是连通的，但不是强连通的。为了使图成为强连通图，从图的入口点到出口点加一条用虚线表示的有向边，使图成为强连通图。这样就可以使用上式计算环路复杂性了。)

后面内容PPT讲得好复杂啊，都懒得去看懂。也没时间去弄懂了。我就记得有三种计算方法：把平面分成的圈数目；判定数目+1；边-定点+2；

此处省略N多PPT内容。

The cyclomatic number is a useful indicator of how difficult a program or module will be to test and maintain. When V exceeds 10 in any one module, the module may be problematic.

The module be rejected if its V exceed 20 or if it has more than 50 statements (Bennet 1994).值指示了一个模块或者程序测试或者维护时有多复杂，当任意一个模块值>=10，这个模块就有问题了，超过20时或者超过50句statements时，就应该拒绝它，重新设计。

此处引用学姐学长的资源：

<table border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="669" valign="top">
      McCabe方法的计算步骤分如下三步：</p> 
      
      <p>
        步骤1：将程序流程图退化成有向图，即将程序流程图的每个处理框看作一个节点，将流线看作连接各节点的有向弧。
      </p>
      
      <p>
        步骤2：在有向图中，由程序出口到入口连接一条虚有向弧。
      </p>
      
      <p>
        步骤3：计算V（G）=m-n＋1
      </p>
      
      <p>
        其中，V（G）是有向图G中环数，m是有向图G中的弧数，n是有向图G中的节点数。
      </p>
      
      <p>
        实践表明，模块规模以V(G)≤10为宜，也就是说，V(G)=10是模块规模的一个更科学更精确的上限。</td> </tr> 
        
        <tr>
          <td width="669" valign="top">
            <table border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="87" valign="top">
                </td>
                
                <td width="113" valign="top">
                  原子语句（A）
                </td>
                
                <td colspan="2" width="161" valign="top">
                  条件（C）
                </td>
                
                <td width="142" valign="top">
                  循环（L）
                </td>
                
                <td width="151" valign="top">
                  定序（S）
                </td>
              </tr>
              
              <tr>
                <td width="87" valign="top">
                  节点数
                </td>
                
                <td width="113" valign="top">
                  F<sub>A</sub>() = 2
                </td>
                
                <td colspan="2" width="161" valign="top">
                  F<sub>C</sub>(m<sub>1</sub>,m<sub>2</sub>) = m<sub>1</sub> + m<sub>2</sub>
                </td>
                
                <td width="142" valign="top">
                  F<sub>L</sub>(m<sub>1</sub>) = m<sub>1</sub> + 1
                </td>
                
                <td width="151" valign="top">
                  F<sub>s</sub>(m<sub>1</sub>,m<sub>2</sub>) = m<sub>1</sub> + m<sub>2</sub> &#8211; 1
                </td>
              </tr>
              
              <tr>
                <td width="87" valign="top">
                  边数
                </td>
                
                <td width="113" valign="top">
                  F<sub>A</sub>() = 1
                </td>
                
                <td colspan="2" width="161" valign="top">
                  F<sub>C</sub>(m<sub>1</sub>,m<sub>2</sub>) =m<sub>1</sub>+ m<sub>2 </sub>+ 2
                </td>
                
                <td width="142" valign="top">
                  F<sub>L</sub>(m<sub>1</sub>) = m<sub>1 </sub>+ 2
                </td>
                
                <td width="151" valign="top">
                  F<sub>s</sub>(m<sub>1</sub>,m<sub>2</sub>) = m<sub>1</sub> + m<sub>2</sub>
                </td>
              </tr>
              
              <tr>
                <td width="87" valign="top">
                  环形复杂度
                </td>
                
                <td width="113" valign="top">
                  F<sub>A</sub>() = 0
                </td>
                
                <td colspan="2" width="161" valign="top">
                  F<sub>C</sub>(m<sub>1</sub>,m<sub>2</sub>) = m<sub>1</sub> + m<sub>2</sub> + 1
                </td>
                
                <td width="142" valign="top">
                  F<sub>L</sub>(m<sub>1</sub>) = m<sub>1</sub> + 1
                </td>
                
                <td width="151" valign="top">
                  F<sub>S</sub>(m<sub>1</sub>,m<sub>2</sub>) = m<sub>1</sub> + m<sub>2</sub>
                </td>
              </tr>
              
              <tr>
                <td colspan="3" width="327" valign="top">
                  Hences, MaCabe #CC=计算出的环形复杂度+1
                </td>
                
                <td colspan="3" width="327" valign="top">
                  V(p)=(#Edges+1)-#Nodes+1=#Edges-#Nodes+2
                </td>
              </tr>
              
              <tr height="0">
                <td width="85">
                </td>
                
                <td width="111">
                </td>
                
                <td width="124">
                </td>
                
                <td width="34">
                </td>
                
                <td width="141">
                </td>
                
                <td width="150">
                </td>
              </tr>
            </table>
          </td>
        </tr></tbody> </table> 
        
        <p>
          <strong>Advantages</strong>
        </p>
        
        <p>
          Provides a complexity measure of software and control flow. 为软件的控制流提供了一种复杂度量方式。
        </p>
        
        <p>
          Provides a quantitative measure testing difficulty and reliability。量化了测试复杂性和可靠性。
        </p>
        
        <p>
          Studies have shown a clear relationship between McCabe’s score and the number of errors and time to correct errors.研究发现McCabe 分数跟错误数和纠正错误时间有清晰的关系。
        </p>
        
        <p>
          Provides a practical upper limit for module size of 10, with those that exceed this level causing problems testing the modules。提供准确的模块上限值10，超过它就会引起测试的困难。
        </p>
        
        <p>
          Offers a graphical depiction of the control of flow.提供一种控制流的图形描述。
        </p>
        
        <p>
          Provides a structures testing approach。提供一种结构测试途径。
        </p>
        
        <p>
          Measures characteristics which are related to the size of the task.具有跟任务大小相关的度量特性。
        </p>
        
        <p>
          Simple to compute and can be automated.容易计算且能够自动化应用。
        </p>
        
        <p>
          Can be used to predict future maintenance effort and cost.能够用来预测将来的维护的人力和成本。
        </p>
        
        <p>
          Most widely used test.广泛用来测试。
        </p>
        
        <p>
          Can be computed early in life cycle than Halstead metrics.在生命周期中比Halstead度量方法更早。
        </p>
        
        <p>
          <strong>Disadvantages</strong>
        </p>
        
        <p>
          <strong> </strong>Context sensitive. 5 if states in one program will have the same complexity value as 5 in other.跟上下文敏感，5个if语句跟5个其他的，有相同的复杂度。
        </p>
        
        <p>
          Measures only a few facets of the program.只测量了一个程序的少的几个方面。
        </p>
        
        <p>
          Combining multiple metrics is likely to yield better results.需要结合多种度量方法以获取更好的结果。
        </p>
        
        <p>
          Metrics is calculated too late in the software development process to be an effective management tool.在软件开发过程阶段才计算以至于不是一个有效的管理工具。
        </p>
        
        <p>
          Not a good measure of complexity in data driven systems.在数据驱动的系统当中不是一个好的复杂性度量方式。
        </p>
        
        <p>
          Does not take program length into consideration。没把程序长度考虑进去。
        </p>
        
        <p>
          Object-oriented code can give misleading results. 面向对象的编码方式可能引起错误的结果。
        </p>
        
        <h3>
          Data structure
        </h3>
        
        <p>
          Unfortunately there has been little work in considering the amount of structure in every data item.不幸的是几乎很少有工作在每一个数据项都考虑了结构数量的。
        </p>
        
        <p>
          The overall “complexity” of a system can not be depicted completely without measures of data stucture.总体来说的一个系统的复杂度不能被完成的描述，要是没有数据结构的度量的话。
        </p>
        
        <p>
          Control-flow measures can fail to identify complexity when it is hidden in the data structure.控制流测量对鉴别隐藏在数据结构中的复杂度时会失效。
        </p>
        
        <p>
          <img class="alignnone" title="数据结构" src="/wp-content/uploads/2011/04/Software%20Metrics.files//image008.gif" alt=""  />
        </p>
        
        <p>
          Boehm using D/P has derived a simple ordinal-scale measure called DATA, used as one of the COCOMO cost drivers, to measure amount of data.
        </p>
        
        <h3>
          Data-flow structure
        </h3>
        
        <p>
          未完待续……
        </p>
